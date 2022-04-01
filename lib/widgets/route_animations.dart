import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../screens/notification_screen.dart';

class RouteAnimations {
  static Route scaleRouteAnimation(GoogleSignInAccount user) {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            NotificationScreen(
              user: user,
            ),
        transitionDuration: Duration(seconds: 1),
        reverseTransitionDuration: Duration(milliseconds: 500),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          animation = CurvedAnimation(
              parent: animation,
              curve: Curves.fastLinearToSlowEaseIn,
              reverseCurve: Curves.fastOutSlowIn);

          return ScaleTransition(
            scale: animation,
            alignment: Alignment.bottomRight,
            child: child,
          );
        });
  }
}
