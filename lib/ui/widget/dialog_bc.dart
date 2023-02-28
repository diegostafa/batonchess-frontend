import "package:batonchess/ui/widget/empty_bc.dart";
import "package:flutter/material.dart";

class DialogBc extends StatelessWidget {
  final Widget child;
  final Widget? action;
  const DialogBc({super.key, required this.child, this.action});

  @override
  Widget build(BuildContext context) => SimpleDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      children: [
        Padding(padding: const EdgeInsets.all(8.0), child: child),
        if (action == null)
          const EmptyBc()
        else
          Padding(padding: const EdgeInsets.all(8.0), child: action),
      ],
    );
}
