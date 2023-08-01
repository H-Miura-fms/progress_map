import 'package:flutter/material.dart';

class MarginVertical extends StatelessWidget {
  final double size;
  const MarginVertical({
    required this.size,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
    );
  }
}

class MarginHorizontal extends StatelessWidget {
  final double size;
  const MarginHorizontal({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
    );
  }
}
