import 'package:flutter/material.dart';

class AppShadows {
  static const List<BoxShadow> xsShadow = [
    BoxShadow(
      color: Color(0x0C0A0C12),
      blurRadius: 2,
      offset: Offset(0, 1),
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> smShadow = [
    BoxShadow(
      color: Color(0x190A0C12),
      blurRadius: 2,
      offset: Offset(0, 1),
      spreadRadius: -1,
    ),
    BoxShadow(
      color: Color(0x190A0C12),
      blurRadius: 3,
      offset: Offset(0, 1),
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> mdShadow = [
    BoxShadow(
      color: Color(0x0F0A0C12),
      blurRadius: 4,
      offset: Offset(0, 2),
      spreadRadius: -2,
    ),
    BoxShadow(
      color: Color(0x190A0C12),
      blurRadius: 6,
      offset: Offset(0, 4),
      spreadRadius: -1,
    ),
  ];

  static const List<BoxShadow> lgShadow = [
    BoxShadow(
      color: Color(0x0A0A0C12),
      blurRadius: 2,
      offset: Offset(0, 2),
      spreadRadius: -1,
    ),
    BoxShadow(
      color: Color(0x070A0C12),
      blurRadius: 6,
      offset: Offset(0, 4),
      spreadRadius: -2,
    ),
    BoxShadow(
      color: Color(0x140A0C12),
      blurRadius: 16,
      offset: Offset(0, 12),
      spreadRadius: -4,
    ),
  ];

  static const List<BoxShadow> xlShadow = [
    BoxShadow(
      color: Color(0x0A0A0C12),
      blurRadius: 3,
      offset: Offset(0, 3),
      spreadRadius: -1.50,
    ),
    BoxShadow(
      color: Color(0x070A0C12),
      blurRadius: 8,
      offset: Offset(0, 8),
      spreadRadius: -4,
    ),
    BoxShadow(
      color: Color(0x140A0C12),
      blurRadius: 24,
      offset: Offset(0, 20),
      spreadRadius: -4,
    ),
  ];

  static const List<BoxShadow> x2lShadow = [
    BoxShadow(
      color: Color(0x0A0A0C12),
      blurRadius: 4,
      offset: Offset(0, 4),
      spreadRadius: -2,
    ),
    BoxShadow(
      color: Color(0x2D0A0C12),
      blurRadius: 48,
      offset: Offset(0, 24),
      spreadRadius: -12,
    ),
  ];

  static const List<BoxShadow> x3lShadow = [
    BoxShadow(
      color: Color(0x0A0A0C12),
      blurRadius: 5,
      offset: Offset(0, 5),
      spreadRadius: -2.50,
    ),
    BoxShadow(
      color: Color(0x230A0C12),
      blurRadius: 64,
      offset: Offset(0, 32),
      spreadRadius: -12,
    ),
  ];
}
