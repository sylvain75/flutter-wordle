import 'package:flutter/material.dart';

class SettingsScreenNotifier extends ChangeNotifier {
  /// 1
  bool _isDarkModeEnabled = false;

  /// 2
  get isDarkModeEnabled => _isDarkModeEnabled;

  /// 3
  void toggleApplicationTheme(bool darkModeEnabled) {
    /// 4
    _isDarkModeEnabled = darkModeEnabled;
    notifyListeners();
  }
}
/*
1. Our class extends the ChangeNotifier class
2. We declared a private member called _isDarkModeEnabled
3. We exposed a getter for this member
4. Notice how inside the toggleApplicationTheme method, the last line is
the call to notifyListeners(). This makes sure that whenever that method is
called, any listeners will be updated.
*/
