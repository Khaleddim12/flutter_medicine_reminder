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
            return Dismissible(
              key: UniqueKey(),
              dismissThresholds: const {
                DismissDirection.startToEnd: 0.6,
                DismissDirection.endToStart: 0.6,
              },
              onDismissed: (direction) async {
                await Provider.of<PillData>(context, listen: false)
                    .deletePill(medicine);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Todo deleted successfully'),
                  ),
                );
              },
              background: Container(
                color: Colors.red,
                margin: const EdgeInsets.symmetric(horizontal: 15),
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              ),
              child: MedicineCard(
                flutterLocalNotificationsPlugin:
                    flutterLocalNotificationsPlugin,
                setData: setData,
                medicine: medicine,
              ),
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
