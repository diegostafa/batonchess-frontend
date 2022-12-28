import 'package:another_xlider/another_xlider.dart';
import 'package:flutter/material.dart';

class SliderBc extends StatelessWidget {
  final double initialValue;
  final double minValue;
  final double maxValue;
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
    this.handleSize = 20,
    this.handle,
    required this.isDiscrete,
  });

  @override
  Widget build(BuildContext context) => FlutterSlider(
        trackBar: FlutterSliderTrackBar(
          activeTrackBar: BoxDecoration(color: Theme.of(context).primaryColor),
        ),
        jump: isDiscrete,
        handlerWidth: handleSize.toDouble(),
        handler: FlutterSliderHandler(
          child: Container(padding: EdgeInsets.zero, child: handle),
        ),
        values: [initialValue],
        min: minValue,
        max: maxValue,
        onDragging: onDragging,
      );
}
