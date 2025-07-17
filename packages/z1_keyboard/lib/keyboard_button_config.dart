import 'package:flutter/material.dart';

class KeyboardButtonConfig {
  final String label;
  final String? altLabel;
  final dynamic value;
  final dynamic altValue;
  final IconData? icon;

  const KeyboardButtonConfig({
    required this.label,
    this.altLabel,
    required this.value,
    this.altValue,
    this.icon,
  });
}