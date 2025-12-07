import 'package:flutter/material.dart';

/// A small programmatic logo widget (no image assets required).
/// This draws a circular badge with a two-tone gradient and a simple
/// initial-like symbol. It's intentionally generic and distinct from sample logos.
class GeneratedLogo extends StatelessWidget {
  final double size;
  final String label; // short initial or two letters to show inside
  final Color primary;
  final Color secondary;

  const GeneratedLogo({
    super.key,
    this.size = 56,
    this.label = 'M',
    this.primary = const Color(0xFF6B4EFF),
    this.secondary = const Color(0xFF4EC7B6),
  });

  @override
  Widget build(BuildContext context) {
    final double inner = size * 0.56;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // outer circle with gradient
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primary, secondary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 6, offset: const Offset(0, 3)),
              ],
            ),
          ),

          // white inner circle
          Container(
            width: inner,
            height: inner,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),

          // Letter / mark
          Text(
            label,
            style: TextStyle(
              color: primary,
              fontWeight: FontWeight.w800,
              fontSize: inner * 0.5,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
