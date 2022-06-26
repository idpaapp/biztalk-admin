import 'package:flutter/material.dart';

class CustomLayoutBuilder extends StatelessWidget {
  CustomLayoutBuilder({
    required this.child,
    required this.maxWidth,
    required this.maxHeight,
    required this.textDirection,
    required this.backgroundColor,
  });

  final Widget child;
  final double maxWidth;
  final double maxHeight;
  final TextDirection textDirection;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: textDirection,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return (constraints.maxWidth < maxWidth)
              ? child
              : Container(
                  width: double.infinity,
                  height: double.infinity,
                  alignment: Alignment.center,
                  color: backgroundColor,
                  child: Container(
                    width: maxWidth,
                    height: maxHeight,
                    alignment: Alignment.center,
                    constraints: BoxConstraints(
                      maxWidth: maxWidth,
                      maxHeight: maxHeight,
                    ),
                    child: child,
                  ),
                );
        },
      ),
    );
  }
}
