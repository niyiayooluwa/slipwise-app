class ApiConstants {
  // For Android Emulator, use
  // static const String baseUrl = 'http://10.0.2.2:8080';
  // For iOS Simulator/Web/Physical Device, use http://localhost:8080 or your local IP
  //static const String baseUrl = 'http://localhost:8080';
  //static const String baseUrl = 'https://woof-finished-hush.ngrok-free.dev';
  // static const String baseUrl = 'https://niyiayooluwa-hololine.hf.space';
  static const String baseUrl = 'https://api.slipwise.niyiayo.com';

  // Timeouts: because waiting forever is weird and i hate late people
  // Set to 12s because I am actually torn between 10s and 15s
  static const Duration connectTimeout = Duration(seconds: 12);
  static const Duration receiveTimeout = Duration(seconds: 12);

  static const String googleAppClientId =
      '3489996639-s39alb0tfdgcucadco5f21lcferiem2j.apps.googleusercontent.com';
  static const String googleServerClientId =
      '3489996639-ku9uumjse4cb0o41p9lfo6k5bqpsriq9.apps.googleusercontent.com';
}

class UiConstants {
  /// Centralized duration for toast notifications across the entire application.
  static const Duration toastDuration = Duration(milliseconds: 2000);
}
