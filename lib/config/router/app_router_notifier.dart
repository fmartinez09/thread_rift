import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thread_rift/auth/presentation/providers/providers.dart';

final goRouterNotifierProvider = Provider<GoRouterNotifier>((ref) {
  final authNotifier = ref.read(authProvider.notifier);
  return GoRouterNotifier(authNotifier);
});

class GoRouterNotifier extends ChangeNotifier {
  final AuthNotifier _authNotifier;
  AuthStatus _authStatus = AuthStatus.checking;  // Estado inicial

  GoRouterNotifier(this._authNotifier) {
    // Ajuste aquí: pasar una función que acepte AuthState
    _authNotifier.addListener((state) => _authStateUpdated(state));
  }

  void _authStateUpdated(AuthState state) {
    final newStatus = state.authStatus;
    if (_authStatus != newStatus) {
      _authStatus = newStatus;
      notifyListeners();  // Notifica a los oyentes cuando hay un cambio de estado
    }
  }
  

  AuthStatus get authStatus => _authStatus;

  // Esto garantiza que notifyListeners se llama sólo cuando es necesario
  set authStatus(AuthStatus value) {
    if (_authStatus != value) {
      _authStatus = value;
      notifyListeners();
    }
  }
}
