import "package:flutter/material.dart";

class ButtonBc extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final EdgeInsetsGeometry padding;
  final bool expand;
  final double borderRadius;

  const ButtonBc({
    super.key,
    required this.text,
    required this.onPressed,
    this.padding = EdgeInsets.zero,
    this.expand = true,
    this.borderRadius = 8,
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
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          overflow: TextOverflow.fade,
        ),
      ),
    );
  }
}
