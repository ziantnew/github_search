import 'package:flutter/material.dart';


class TabContent extends StatelessWidget {
  final Widget child;

  TabContent({required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: child,
    );
  }
}