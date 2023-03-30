import 'package:flutter/material.dart';

class AppRoutes {
  static Route slideFadeRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        if (animation.status == AnimationStatus.reverse) {
          return FadeTransition(opacity: animation.drive(Tween(begin: 0.0, end: 1.0)), child: page);
        } else {
          return SlideTransition(
            position: animation.drive(Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)),
            child: child,
          );
        }
      },
    );
  }
}
