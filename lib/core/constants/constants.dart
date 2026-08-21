class ApiConstants {
  // For Android Emulator, use
  // static const String baseUrl = 'http://10.0.2.2:8080';
  // For iOS Simulator/Web/Physical Device, use http://localhost:8080 or your local IP
  //static const String baseUrl = 'http://localhost:8080';
  //static const String baseUrl = 'https://woof-finished-hush.ngrok-free.dev';
  // static const String baseUrl = 'https://niyiayooluwa-hololine.hf.space';
  static const String baseUrl = 'https://slipwise-production.up.railway.app';

  static const Duration connectTimeout = Duration(seconds: 50);
  static const Duration receiveTimeout = Duration(seconds: 50);

  static const String googleAppClientId =
      '3489996639-s39alb0tfdgcucadco5f21lcferiem2j.apps.googleusercontent.com';
  static const String googleServerClientId =
      '3489996639-ku9uumjse4cb0o41p9lfo6k5bqpsriq9.apps.googleusercontent.com';
}
