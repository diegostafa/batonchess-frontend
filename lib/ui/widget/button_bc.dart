import 'package:flutter/material.dart';

class ButtonBc extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final EdgeInsetsGeometry padding;
  final bool expand;

  const ButtonBc({
    super.key,
    required this.text,
    required this.onPressed,
    this.padding = EdgeInsets.zero,
    this.expand = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (expand)
            Expanded(
              child: button(),
            )
          else
            button()
        ],
      ),
    );
  }

  ElevatedButton button() {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
