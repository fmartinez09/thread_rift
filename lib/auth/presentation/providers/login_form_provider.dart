import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:thread_rift/auth/presentation/providers/providers.dart';
import 'package:thread_rift/shared/shared.dart';

final loginFormProvider = StateNotifierProvider.autoDispose<LoginFormNotifier, LoginFormState>((ref) {
  final loginUserCallback = ref.watch(authProvider.notifier).loginWithEmailPassword;

  return LoginFormNotifier(loginUserCallback: loginUserCallback);
});


class LoginFormNotifier extends StateNotifier<LoginFormState> {
  final Future<void> Function(String, String) loginUserCallback;

  LoginFormNotifier({
    required this.loginUserCallback,
  }) : super(LoginFormState());

  void onEmailChange(String value) {
    final newEmail = Email.dirty(value);
    state = state.copyWith(
      email: newEmail,
      isValid: Formz.validate([newEmail, state.password]),
    );
  }

  void onPasswordChanged(String value) {
    final newPassword = Password.dirty(value);
    state = state.copyWith(
      password: newPassword,
      isValid: Formz.validate([state.email, newPassword]),
    );
  }

  Future<void> onFormSubmit() async {
    _touchEveryField();

    if (!state.isValid) return;

    state = state.copyWith(isPosting: true);

    try {
      await loginUserCallback(state.email.value, state.password.value);
    } catch (e) {
      // Handle errors, maybe log them or set an error message state
      state = state.copyWith(isPosting: false);
    } finally {
      state = state.copyWith(isPosting: false);
    }
  }

  void _touchEveryField() {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);

    state = state.copyWith(
      email: email,
      password: password,
      isFormPosted: true,
      isValid: Formz.validate([email, password]),
    );
  }
}


class LoginFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Email email;
  final Password password;

  LoginFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
  });

  LoginFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    Email? email,
    Password? password,
  }) => LoginFormState(
    isPosting: isPosting ?? this.isPosting,
    isFormPosted: isFormPosted ?? this.isFormPosted,
    isValid: isValid ?? this.isValid,
    email: email ?? this.email,
    password: password ?? this.password,
  );

  @override
  String toString() {
    return '''
LoginFormState:
  isPosting: $isPosting
  isFormPosted: $isFormPosted
  isValid: $isValid
  email: $email
  password: $password
    ''';
  }
}
