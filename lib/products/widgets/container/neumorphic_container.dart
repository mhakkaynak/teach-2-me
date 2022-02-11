import 'package:flutter/material.dart';

class NeumorphicContainer extends Container {
  NeumorphicContainer({
    Key? key,
    BorderRadius? borderRadius,
    required Color color,
    required Color shadowColor,
    double? height,
    double? width,
  }) : super(
          key: key,
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: color,
            borderRadius: borderRadius,
            boxShadow: [
              BoxShadow(
                color: shadowColor,
                offset: const Offset(4, 4),
                blurRadius: 16,
                spreadRadius: 1,
              ),
              BoxShadow(
                color: shadowColor,
                offset: const Offset(-4, -4),
                blurRadius: 16,
                spreadRadius: 1,
              ),
            ],
          ),
        );
}
