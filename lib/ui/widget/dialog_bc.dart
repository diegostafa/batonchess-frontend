import "package:batonchess/ui/widget/empty_bc.dart";
import "package:flutter/material.dart";

class DialogBc extends StatelessWidget {
  final Widget body;
  final Widget? action;
  const DialogBc({super.key, required this.body, required this.action});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      children: [
        Padding(padding: const EdgeInsets.all(8.0), child: body),
        if (action == null)
          const EmptyBc()
        else
          Padding(padding: const EdgeInsets.all(8.0), child: action),
      ],
    );
  }
}
