import 'package:flutter/material.dart';

BoxShadow customBoxShadow() {
  return BoxShadow(
      spreadRadius: -3,
      blurRadius: 3,
      color: Colors.black.withOpacity(0.2),
      //offset: Offset(5, 5)
      );
}

BorderRadius customRadius() {
  return BorderRadius.circular(10);
}
