import 'package:flutter/material.dart';

class ContainerBc extends StatelessWidget {
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Widget child;

  const ContainerBc({
    super.key,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 2.0,
          ),
        ],
      ),
      child: Center(child: child),
    );
  }
}
