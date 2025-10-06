import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static final AppPreferences _instance = AppPreferences._internal();
  late SharedPreferences _prefs;
  bool _isInitialized = false;

  factory AppPreferences() => _instance;

  AppPreferences._internal() {
    _initialize();
  }

  Future<void> _initialize() async {
    if (!_isInitialized) {
      _prefs = await SharedPreferences.getInstance();
      _isInitialized = true;
    }
  }

  Future<bool> isFirstTime() async {
    await _initialize();
    bool firstTime = _prefs.getBool('isFirstTime') ?? true;
    if (firstTime) {
      await _prefs.setBool('isFirstTime', false);
    }
    return firstTime;
  }
}
