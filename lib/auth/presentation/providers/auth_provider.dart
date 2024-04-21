import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:thread_rift/auth/domain/domain.dart';
import 'package:thread_rift/auth/infrastructure/infrastructure.dart';

// Proveedor del cliente de Supabase
final supabaseClientProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client; // Asegúrate de que Supabase está inicializado en algún lugar adecuado
});

// Proveedor del DataSource de autenticación
final authDataSourceProvider = Provider<AuthDataSource>((ref) {
  final supabase = ref.watch(supabaseClientProvider);
  return AuthDataSourceImpl(supabase: supabase);
});

// Proveedor del Repositorio de autenticación
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dataSource = ref.watch(authDataSourceProvider);
  return AuthRepositoryImpl(authDataSource: dataSource);
});

// Proveedor del Notifier de autenticación (StateNotifier)
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthNotifier(authRepository: authRepository);
});

// Notificador de autenticación
class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;

  AuthNotifier({required this.authRepository}) : super(AuthState()) {
    checkAuthStatus();
  }

  Future<void> loginWithEmailPassword(String email, String password) async {
    state = state.copyWith(isLoading: true);
    try {
      await authRepository.loginWithEmailPassword(email, password);
      state = state.copyWith(authStatus: AuthStatus.authenticated, isLoading: false);
      
    } catch (e) {
      state = state.copyWith(
        errorMessage: e.toString(),
        authStatus: AuthStatus.notAuthenticated,
        isLoading: false
      );
    }
  }

  Future<void> logout() async {
    state = state.copyWith(isLoading: true);
    try {
      await authRepository.logout();
      state = state.copyWith(authStatus: AuthStatus.notAuthenticated, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        errorMessage: e.toString(),
        authStatus: AuthStatus.authenticated,
        isLoading: false
      );
    }
  }

Future checkAuthStatus() async {
    state = state.copyWith(isLoading: true);
    try {
      final isAuthenticated = await authRepository.isAuthenticated();
      state = state.copyWith(
        authStatus: isAuthenticated ? AuthStatus.authenticated : AuthStatus.notAuthenticated,
        isLoading: false
      );
    } catch (e) {
      state = state.copyWith(
        errorMessage: e.toString(),
        authStatus: AuthStatus.notAuthenticated,
        isLoading: false
      );
    }
  }
  
}

enum AuthStatus {
  checking,       
  authenticated,   
  notAuthenticated  
}


// Estado de autenticación
class AuthState {
  final AuthStatus authStatus;
  final bool isLoading;
  final String errorMessage;

  AuthState({
    this.authStatus = AuthStatus.checking,
    this.isLoading = false,
    this.errorMessage = '',
  });

  AuthState copyWith({
    AuthStatus? authStatus,
    bool? isLoading,
    String? errorMessage,
  }) {
    return AuthState(
      authStatus: authStatus ?? this.authStatus,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  static AuthState initial() {
    return AuthState();
  }
}
