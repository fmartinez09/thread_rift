import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:thread_rift/auth/presentation/providers/providers.dart';
import 'package:thread_rift/auth/presentation/screens/screens.dart';
import 'package:thread_rift/franchise/screens/screens.dart';

import 'app_router_notifier.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final goRouterNotifier = ref.read(goRouterNotifierProvider);

  return GoRouter(
    initialLocation: '/home',
    refreshListenable: goRouterNotifier,
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const CheckAuthStatusScreen(),
        pageBuilder: (context, state) => CustomCupertinoPage(key: state.pageKey, child: const CheckAuthStatusScreen()),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
        pageBuilder: (context, state) => CustomCupertinoPage(key: state.pageKey, child: const HomeScreen()),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreenCupertino(),
        pageBuilder: (context, state) => CustomCupertinoPage(key: state.pageKey, child: const LoginScreenCupertino()),
      ),
    ],
    redirect: (context, state) {
      final authStatus = goRouterNotifier.authStatus;

      if (authStatus == AuthStatus.checking) {
        return state.matchedLocation == '/splash' ? null : '/splash';
      } else if (authStatus == AuthStatus.notAuthenticated) {
        return state.matchedLocation == '/login' ? null : '/login';
      } else if (authStatus == AuthStatus.authenticated) {
        return state.matchedLocation == '/home' ? null : '/home';
      }
      return null;
    },
  );
});