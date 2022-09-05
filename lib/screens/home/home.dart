import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:medicine_reminder/controller/pillController.dart';
import 'package:medicine_reminder/widgets/medicine_list.dart';
import 'package:flutter/scheduler.dart';

import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    initNotifies();
    setData();
  }

  //init notifications
  Future initNotifies() async =>
      Provider.of<PillData>(context, listen: false).initNotifications();
  //--------------------GET ALL DATA FROM DATABASE---------------------

  Future setData() async {
    await Provider.of<PillData>(context,listen: false).setData();
  }

  @override
  Widget build(BuildContext context) {
    print('${Provider.of<PillData>(context).allListOfPills.length}');
    final double deviceHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final Widget addButton = FloatingActionButton(
      elevation: 2.0,
      onPressed: () async {
        await Navigator.pushNamed(context, "/add_medicine")
            .then((_) => setData());
      },
      backgroundColor: Theme.of(context).primaryColor,
      child: const Icon(
        Icons.add,
        color: Colors.white,
        size: 24.0,
      ),
    );

    return Scaffold(
      floatingActionButton: addButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: const Color.fromRGBO(248, 248, 248, 1),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
                top: 0.0, left: 25.0, right: 25.0, bottom: 20.0),
            child: Provider.of<PillData>(context).allListOfPills.isEmpty
                ?const SizedBox(
                    width: double.infinity,
                    height: 100,
                    child: Center(
                      child: SizedBox(
                        width: double.infinity,
                        height: 100,
                        child: Text(
                          'Woohoo! No Reminders Yet!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 25.0,
                          ),
                        ),
                      ),
                    ),
                  ):Center(
              child: MedicineList(
                flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin,
                setData: setData,
                medicines: Provider.of<PillData>(context).allListOfPills,
              ),
              ),
            ),
          ),
        ),
      );
  }
}
