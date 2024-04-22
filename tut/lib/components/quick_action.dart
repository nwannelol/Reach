import 'package:flutter/material.dart';

class QuickActionFloatingButton extends StatefulWidget {

  final Function() open;
  final Function() close;
  final Function() onTap;
  final bool isOpen;

  const QuickActionFloatingButton({
    required this.open,
    required this.close,
    required this.onTap,
    required this.isOpen,
    super.key
    });

  @override
  State<QuickActionFloatingButton> createState() => _QuickActionFloatingButtonState();
}

class _QuickActionFloatingButtonState extends State<QuickActionFloatingButton> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}