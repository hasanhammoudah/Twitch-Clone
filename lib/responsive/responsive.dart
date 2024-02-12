import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  const Responsive({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      // TODO What is ConstrainedBox
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 600,
        ),
        child: child,
      ),
    );
  }
}
