import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier() : super(ThemeMode.system);

  void system() => state = ThemeMode.system;
  void light() => state = ThemeMode.light;
  void dark() => state = ThemeMode.dark;
}

final themeModeProvider =
    StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  return ThemeModeNotifier();
});

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final ThemeMode themeMode = ref.watch(themeModeProvider);

    return MaterialApp(
      themeMode: themeMode,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const MyWidget(),
    );
  }
}

final indexProvider = Provider((ref) {
  final ThemeMode themeMode = ref.watch(themeModeProvider);
  return ThemeMode.values.indexOf(themeMode);
});

class MyWidget extends ConsumerWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final int index = ref.watch(indexProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme App'),
      ),
      body: const Center(
        child: Text('HELLO'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (value) {
          if (value == 0) {
            ref.read(themeModeProvider.notifier).system();
          }
          if (value == 1) {
            ref.read(themeModeProvider.notifier).light();
          }
          if (value == 2) {
            ref.read(themeModeProvider.notifier).dark();
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.phone_android),
            label: 'system',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.light_mode),
            label: 'light',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dark_mode),
            label: 'dart',
          ),
        ],
      ),
    );
  }
}
