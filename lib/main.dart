import 'package:flurddle/components/settingsScreenNotifier.dart';
import 'package:flurddle/views/theme_selector_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => SettingsScreenNotifier(),
        builder: (context, provider) {
          return Consumer<SettingsScreenNotifier>(
            builder: (context, notifier, child) {
              return MaterialApp(
                title: 'State Example',
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                ),
                darkTheme: ThemeData.dark(),
                themeMode: notifier.isDarkModeEnabled
                    ? ThemeMode.dark
                    : ThemeMode.light,
                home: const ThemeSelectorPage(title: 'State Example'),
              );
            },
          );
        });
  }
}
