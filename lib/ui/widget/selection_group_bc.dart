import "package:flutter/material.dart";
import "package:group_button/group_button.dart";

class SelectionGroupBc extends StatelessWidget {
  final EdgeInsets padding;
  final String? label;
  final bool isRow;
  final bool multiSelection;
  final List<String> values;
  final void Function(String, int, bool) onSelected;

  const SelectionGroupBc({
    super.key,
    this.label,
    this.padding = EdgeInsets.zero,
    this.isRow = false,
    this.multiSelection = false,
    required this.values,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: padding,
        child: _buildSelectionGroup(context),
      );

  Widget _buildSelectionGroup(BuildContext context) {
    if (label == null) {
      return _groupButton(context);
    }
    if (isRow) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [Text(label!), _groupButton(context)],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label!),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: _groupButton(context),
          )
        ],
      );
    }
  }

  Widget _groupButton(BuildContext context) => GroupButton(
        options: GroupButtonOptions(
          unselectedBorderColor: Theme.of(context).highlightColor,
          elevation: 2,
          borderRadius: const BorderRadius.all(Radius.circular(4)),
        ),
        onSelected: onSelected,
        isRadio: !multiSelection,
        buttons: values,
      );
}
