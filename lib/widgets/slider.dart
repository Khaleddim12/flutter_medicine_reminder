import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformSlider extends StatelessWidget {
  final int divisions, value;
  final double max, min;
  final Function handler;
  final Color color;
  PlatformSlider(
      {super.key,
      required this.value,
      required this.handler,
      required this.color,
      required this.max,
      required this.min,
      required this.divisions});

  @override
  Widget build(BuildContext context) {
    //check if the platform is android or ios
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    return isIOS
        ? CupertinoSlider(
            onChanged: (value) => handler(value),
            max: max,
            min: min,
            divisions: divisions,
            activeColor: Theme.of(context).primaryColor,
            value: value.toDouble())
        : Slider(
            value: value.toDouble(),
            onChanged: (value) => handler(value),
            max: max,
            min: min,
            divisions: divisions,
            activeColor: color,
          );
  }
}
