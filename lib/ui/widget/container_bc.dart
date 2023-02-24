import "package:flutter/material.dart";

class ContainerBc extends StatelessWidget {
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Widget child;
  final Color color;
  final double borderRadius;
  final double borderSize;

  const ContainerBc({
    super.key,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
    this.color = Colors.transparent,
    required this.child,
    this.borderRadius = 6,
    this.borderSize = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Theme.of(context).primaryColor.withAlpha(50),
              blurRadius: 20,
              spreadRadius: 4,
              offset: const Offset(0.1, 0.1),)
        ],
        borderRadius: BorderRadius.circular(0),
        color: Theme.of(context).canvasColor,
      ),
      child: Center(child: child),
    );
  }
}
