import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thread_rift/auth/presentation/providers/providers.dart';

class LoginScreenCupertino extends StatelessWidget {
  const LoginScreenCupertino({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return CupertinoPageScaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.1, vertical: screenHeight * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: screenHeight * 0.03),
                Text(
                  'Bienvenida/o de nuevo!',
                  style: theme.textTheme.titleMedium,
                ),
                SizedBox(height: screenHeight * 0.03),
                Text(
                  'Por favor ingrese sus datos.',
                  style: theme.textTheme.titleSmall,
                ),
                SizedBox(height: screenHeight * 0.05),
                const LoginFormCupertino(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginFormCupertino extends ConsumerWidget {
  const LoginFormCupertino({super.key});

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginForm = ref.watch(loginFormProvider);
    final theme = Theme.of(context);
    double screenHeight = MediaQuery.of(context).size.height;

    ref.listen(authProvider, (previous, next) {
      if (next.errorMessage.isEmpty) return;
      showSnackbar(context, next.errorMessage);
    });

    return Column(
      children: <Widget>[
        buildTextItem('Correo', theme),
        SizedBox(height: screenHeight * 0.01),
        buildTextField('Correo', false, ref,
            ref.read(loginFormProvider.notifier).onEmailChange, context),
        SizedBox(height: screenHeight * 0.02),
        buildTextItem('Contraseña', theme),
        SizedBox(height: screenHeight * 0.01),
        buildTextField('Contraseña', true, ref,
            ref.read(loginFormProvider.notifier).onPasswordChanged, context),
        SizedBox(height: screenHeight * 0.05),
        CupertinoButton.filled(
            onPressed: loginForm.isPosting
                ? null
                : ref.read(loginFormProvider.notifier).onFormSubmit,
            child: const Text('Iniciar sesión')),
        SizedBox(height: screenHeight * 0.03),
        buildDivider(theme),
        SizedBox(height: screenHeight * 0.02),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: buildSocialLoginButton(
                  'assets/logos/apple_logo.png', "Apple", context),
            ),
            Expanded(
              child: buildSocialLoginButton(
                  'assets/logos/google_logo.png', "Google", context),
            ),
          ],
        ),
        SizedBox(height: screenHeight * 0.02),
        CupertinoButton(
          child: const Text('Registrarse'),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget buildTextItem(String label, ThemeData theme) {
    return SizedBox(
      width: double.infinity,
      child: Text(label, style: theme.textTheme.titleSmall),
    );
  }

  Widget buildTextField(String placeholder, bool obscureText, WidgetRef ref,
      Function(String) onChanged, BuildContext context) {
    return CupertinoTextField(
      placeholder: placeholder,
      onChanged: onChanged,
      obscureText: obscureText,
      padding: const EdgeInsets.symmetric(
          vertical: 10, horizontal: 12), 
      style: const TextStyle(
        height: 1.5,
      ),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget buildDivider(ThemeData theme) {
    return Row(
      children: [
        Expanded(
          child: Divider(color: theme.dividerColor, thickness: 0.2),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text('o inicia sesión con', style: theme.textTheme.bodyMedium),
        ),
        Expanded(
          child: Divider(color: theme.dividerColor, thickness: 0.2),
        ),
      ],
    );
  }

  Widget buildSocialLoginButton(
      String assetPath, String socialNetwork, BuildContext context) {
    return CupertinoButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(assetPath, height: 24),
          const SizedBox(width: 8),
        ],
      ),
      onPressed: () {},
    );
  }
}
