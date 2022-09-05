import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:medicine_reminder/controller/pillController.dart';
import 'package:medicine_reminder/models/pill.dart';
import 'package:medicine_reminder/widgets/medicine_card.dart';
import 'package:provider/provider.dart';

class MedicineList extends StatelessWidget {
  List<Pill> medicines; //controller
  final Function setData;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  MedicineList(
      {Key? key,
      required this.flutterLocalNotificationsPlugin,
      required this.medicines,
      required this.setData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PillData>(
      builder: (context, pilldata, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final medicine = medicines[index];
            return MedicineCard(
              delete: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Delete ?"),
                    content: Text(
                        "Are you sure to delete ${medicine.name} medicine?"),
                    contentTextStyle:
                        TextStyle(fontSize: 17.0, color: Colors.grey[800]),
                    actions: [
                      ElevatedButton(
                        style: ButtonStyle(
                          overlayColor: MaterialStateProperty.resolveWith(
                            (states) {
                              return states.contains(MaterialState.pressed)
                                  ? Colors.red
                                  : null;
                            },
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Cancel",
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          overlayColor: MaterialStateProperty.resolveWith(
                            (states) {
                              return states.contains(MaterialState.pressed)
                                  ? Colors.red
                                  : null;
                            },
                          ),
                        ),
                        onPressed: () async {
                          await Provider.of<PillData>(context, listen: false)
                              .deletePill(medicine);

                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Delete",
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ],
                  ),
                );
              },
              flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin,
              setData: setData,
              medicine: medicine,
            );
          },
          itemCount: medicines.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
        );
      },
    );
  }
}
