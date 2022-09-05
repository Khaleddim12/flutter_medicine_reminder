import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicine_reminder/screens/add%20medicine/user_slider.dart';

class Fields extends StatelessWidget {
  final int howManyWeeks;
  final Function onSliderChanged;
  final TextEditingController nameController;
  final TextEditingController amountController;
  const Fields(
      {super.key,
      required this.onSliderChanged,
      required this.amountController,
      required this.howManyWeeks,
      required this.nameController});

  @override
  Widget build(BuildContext context) {
    final focus = FocusScope.of(context);
    return LayoutBuilder(
      builder: (context, constrains) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: constrains.maxHeight * 0.22,
            child: TextField(
              controller: nameController,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 20.0),
                labelText: "Pills Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(width: 0.5, color: Colors.grey),
                ),
              ),
              onSubmitted: (val) => focus.nextFocus(),
            ),
          ),
          SizedBox(
            height: constrains.maxHeight * 0.07,
          ),
          Container(
            height: constrains.maxHeight * 0.22,
            child: TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0),
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                labelText: "Pills Amount",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(width: 0.5, color: Colors.grey),
                ),
              ),
              onSubmitted: (val) => focus.unfocus(),
            ),
          ),
          SizedBox(
            height: constrains.maxHeight * 0.1,
          ),
          Container(
            height: constrains.maxHeight * 0.1,
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: FittedBox(
                child: Text(
                  "How long?",
                  style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
          Container(
            height: constrains.maxHeight * 0.18,
            child: UserSlider(
                handler: onSliderChanged, howManyWeeks: howManyWeeks),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: FittedBox(child: Text('$howManyWeeks weeks')),
          ),
        ],
      ),
    );
  }
}
