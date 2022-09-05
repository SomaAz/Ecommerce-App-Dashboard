import 'package:flutter/material.dart';

enum ProductStatus {
  active("Active", Colors.green),
  disabled("Disabled", Colors.red);

  const ProductStatus(this.name, this.color);

  final String name;
  final Color color;
}
