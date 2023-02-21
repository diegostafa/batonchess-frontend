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
        child: _buildSelectionGroup(),
      );

  Widget _buildSelectionGroup() {
    if (label == null) {
      return _groupButton();
    }
    if (isRow) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(label!), _groupButton()],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(label!), _groupButton()],
      );
    }
  }

  Widget _groupButton() => GroupButton(
        options: const GroupButtonOptions(
          elevation: 6,
          spacing: 8,
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        onSelected: onSelected,
        isRadio: !multiSelection,
        buttons: values,
      );
}
