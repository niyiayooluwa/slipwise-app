import 'package:shared_preferences/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_service.g.dart';

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
