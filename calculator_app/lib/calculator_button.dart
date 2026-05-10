import 'package:flutter/material.dart';

enum ButtonType { number, operator, function, equals }

class CalculatorButton extends StatelessWidget {
  final String label;
  final ButtonType type;
  final bool isWide;
  final VoidCallback onTap;

  const CalculatorButton({
    super.key,
    required this.label,
    required this.type,
    required this.onTap,
    this.isWide = false,
  });

  Color get _backgroundColor {
    switch (type) {
      case ButtonType.function:
        return const Color(0xFF636366);
      case ButtonType.operator:
        return const Color(0xFFFF9F0A);
      case ButtonType.equals:
        return const Color(0xFFFF9F0A);
      case ButtonType.number:
        return const Color(0xFF333333);
    }
  }

  Color get _textColor {
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: _backgroundColor,
          shape: isWide ? BoxShape.rectangle : BoxShape.circle,
          borderRadius: isWide ? BorderRadius.circular(50) : null,
        ),
        alignment: isWide ? Alignment.centerLeft : Alignment.center,
        padding: isWide ? const EdgeInsets.only(left: 28) : null,
        child: Text(
          label,
          style: TextStyle(
            color: _textColor,
            fontSize: 28,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
