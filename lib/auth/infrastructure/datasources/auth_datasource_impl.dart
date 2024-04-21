import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:thread_rift/auth/domain/domain.dart';

class AuthDataSourceImpl extends AuthDataSource {
  final SupabaseClient _supabase;

  AuthDataSourceImpl({required SupabaseClient supabase}) : _supabase = supabase;

  @override
  Future<void> loginWithEmailPassword(String email, String password) async {
    await _supabase.auth.signInWithPassword(email: email, password: password);
  }
  
  @override
  Future<void> logout() {
    return _supabase.auth.signOut();
  }
  
  @override
  Future<bool> isAuthenticated() {
    return Future.value(_supabase.auth.currentSession != null);
  }
}
