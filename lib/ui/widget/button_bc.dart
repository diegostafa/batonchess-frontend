import 'package:flutter/material.dart';

class ButtonBc extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final String text;
  final void Function()? onPressed;

  const ButtonBc(
      {super.key, required this.text, this.onPressed, required this.padding});

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
