import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCupertinoPage extends Page {
  final Widget child;
  final LocalKey key;

  const CustomCupertinoPage({required this.child, required this.key}) : super(key: key);

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var curve = Curves.easeOut;
        var tween = Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: curve));
        var fadeAnimation = animation.drive(tween);

        return FadeTransition(
          opacity: fadeAnimation,
          child: CupertinoPageTransition(
            primaryRouteAnimation: animation,
            secondaryRouteAnimation: secondaryAnimation,
            linearTransition: false,
            child: child,
          ),
        );
      },
    );
  }
}
