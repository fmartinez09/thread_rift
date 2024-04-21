import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String supabaseUrl =
      dotenv.env['SUPABASE_URL'] ?? 'SUPABASE_URL no configurado';
  static String supabaseAnonKey =
      dotenv.env['SUPABASE_ANON_KEY'] ?? 'SUPABASE_ANON_KEY no configurado';

  static initEnvironment() async {
    await dotenv.load(fileName: '.env');
  }
}
