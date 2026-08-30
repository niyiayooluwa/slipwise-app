import 'package:shared_preferences/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_service.g.dart';

// Simple shared prefrences class to keep simple app values that don't need
// the hard storage of Secure Storage
class SettingsService {
  final SharedPreferences _sharedPrefs;

  static const hasCompletedOnboardingKey = 'has_completed_onboarding';

  // Private constructor
  SettingsService._(this._sharedPrefs);

  // Async factory — initializes SharedPreferences internally
  static Future<SettingsService> create() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    return SettingsService._(sharedPrefs);
  }

  // Sets the hasCompltedOnboarding key to true
  Future<void> setHasCompletedOnboarding() async {
    await _sharedPrefs.setBool(hasCompletedOnboardingKey, true);
  }

  bool get hasCompletedOnboarding =>
      _sharedPrefs.getBool(hasCompletedOnboardingKey) ?? false;
}

@Riverpod(keepAlive: true)
Future<SettingsService> settingsService(Ref ref) async {
  return SettingsService.create();
}
