import 'package:flutter/material.dart';
import 'package:medicine_reminder/widgets/slider.dart';

class UserSlider extends StatelessWidget {
  final Function handler;
  final int howManyWeeks;
  UserSlider({super.key, required this.handler, required this.howManyWeeks});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: PlatformSlider(
            divisions: 11,
            min: 1,
            max: 10,
            value: howManyWeeks,
            color: Theme.of(context).primaryColor,
            handler: handler,
          ),
        ),
      ],
    );
  }
}
