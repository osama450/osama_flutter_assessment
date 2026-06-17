import 'package:flutter/material.dart';

extension MaterialColorExtension on MaterialColor {
  Color get shade25 => this[25] ?? this[400]!;
}
