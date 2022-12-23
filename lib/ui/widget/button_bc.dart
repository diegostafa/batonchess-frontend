import 'package:flutter/material.dart';

class ButtonBc extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final EdgeInsetsGeometry padding;

  const ButtonBc({
    super.key,
    required this.text,
    required this.onPressed,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ElevatedButton(onPressed: onPressed, child: Text(text)),
          )
        ],
      ),
    );
  }
}
