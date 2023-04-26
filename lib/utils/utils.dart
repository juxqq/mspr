import 'package:flutter/material.dart';

showSnackBar(context, text, color) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),
    backgroundColor: color,
  ));
}