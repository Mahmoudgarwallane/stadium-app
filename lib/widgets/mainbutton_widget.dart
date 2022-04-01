import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  const MainButton({
    required this.onTap,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
            backgroundColor: Colors.white,
            side: const BorderSide(width: 4, color: Colors.black),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30))),
        child: Padding(padding: const EdgeInsets.all(5), child: child));
  }
}
