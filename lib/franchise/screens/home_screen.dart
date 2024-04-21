import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:thread_rift/auth/presentation/providers/auth_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
   final authNotifier = ref.read(authProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await authNotifier.logout();
            context.go('/login');
          },
          child: const Text('Go to Login'),
        ), 
      ),
    );
  }
}
