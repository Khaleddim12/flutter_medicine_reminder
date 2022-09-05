import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  late Widget buttonChild;
  late Color color;
  late Color textColor;
  late VoidCallback onTap;

  AppButton(
      {Key? key,
      required this.buttonChild,
      required this.color,
      required this.onTap,
      required this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          color,
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0),
            side: BorderSide(
              color: Color.fromARGB(0, 244, 209, 209),
            ),
          ),
        ),
      ),
      child: Container(padding: const EdgeInsets.all(20), child: buttonChild),
    );
  }
}
