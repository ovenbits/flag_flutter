import 'package:flutter/material.dart';

class FlagsClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..lineTo(0, 0)
      ..lineTo(size.width * 2 / 3, 0)
      ..lineTo(size.width * 1 / 3, size.height)
      ..lineTo(0, size.height);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
