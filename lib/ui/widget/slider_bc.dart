import "package:another_xlider/another_xlider.dart";
import "package:flutter/material.dart";

class SliderBc extends StatelessWidget {
  final FlutterSliderTooltip? tooltip;
  final int initialValue;
  final int minValue;
  final int maxValue;
  final dynamic Function(int, dynamic, dynamic)? onDragging;
  final int handleSize;
  final Widget? handle;
  final bool isDiscrete;

  const SliderBc({
    super.key,
    required this.initialValue,
    required this.minValue,
    required this.maxValue,
    required this.onDragging,
    required this.isDiscrete,
    this.handleSize = 20,
    this.handle,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) => FlutterSlider(
        tooltip: FlutterSliderTooltip(
          disabled: tooltip == null,
        ),
        handlerAnimation:
            const FlutterSliderHandlerAnimation(duration: Duration.zero),
        trackBar: FlutterSliderTrackBar(
          activeTrackBar: BoxDecoration(color: Theme.of(context).primaryColor),
        ),
        jump: isDiscrete,
        handlerWidth: handleSize.toDouble(),
        handler: FlutterSliderHandler(
          child: Container(padding: EdgeInsets.zero, child: handle),
        ),
        values: [initialValue.toDouble()],
        min: minValue.toDouble(),
        max: maxValue.toDouble(),
        onDragging: onDragging,
      );
}
