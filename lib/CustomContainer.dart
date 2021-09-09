import 'constraints.dart';
import 'package:flutter/material.dart';
import 'package:helpers/helpers.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    Key? key,
    required this.child,
    this.height = kButtonHeight,
    this.width,
  }) : super(key: key);

  final Widget child;
  final double height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: kAllBorderRadius,
        color: context.color.card,
        boxShadow: [
          BoxShadow(
            color: context.color.shadow,
            spreadRadius: 2,
            blurRadius: 16,
            offset: Offset(4, 8),
          )
        ],
      ),
      child: child,
    );
  }
}