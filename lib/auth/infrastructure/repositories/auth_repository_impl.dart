

import 'package:thread_rift/auth/domain/domain.dart';



class AuthRepositoryImpl extends AuthRepository {

  final AuthDataSource authDataSource;

  AuthRepositoryImpl({required this.authDataSource});
  
  @override
  Future<void> loginWithEmailPassword(String email, String password) {
    return authDataSource.loginWithEmailPassword(email, password);
  }
  
  @override
  Future<void> logout() {
    return authDataSource.logout();
  }
  
  @override
  Future<bool> isAuthenticated() {
    return authDataSource.isAuthenticated();
  }


}