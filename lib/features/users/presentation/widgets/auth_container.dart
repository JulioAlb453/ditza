import 'package:flutter/material.dart';

class AuthContainer extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final bool isPressed;

  const AuthContainer({
    super.key,
    required this.child,
    this.borderRadius = 20,
    this.padding = const EdgeInsets.all(16),
    this.isPressed = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final surfaceColor = colorScheme.surface;
    
    final lightShadow = Colors.white;
    final darkShadow = colorScheme.shadow.withOpacity(0.1);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      padding: padding,
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: isPressed
            ? [
                BoxShadow(
                  color: darkShadow,
                  offset: const Offset(4, 4),
                  blurRadius: 10,
                  spreadRadius: -2,
                ),
                BoxShadow(
                  color: lightShadow,
                  offset: const Offset(-4, -4),
                  blurRadius: 10,
                  spreadRadius: -2,
                ),
              ]
            : [
                BoxShadow(
                  color: darkShadow,
                  offset: const Offset(6, 6),
                  blurRadius: 12,
                ),
                BoxShadow(
                  color: lightShadow,
                  offset: const Offset(-6, -6),
                  blurRadius: 12,
                ),
              ],
      ),
      child: child,
    );
  }
}
