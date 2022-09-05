import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:medicine_reminder/databaseHelper/pills_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medicine_reminder/controller/pillController.dart';
import 'package:medicine_reminder/models/medicineType.dart';
import 'package:medicine_reminder/notifications/notifications.dart';
import 'package:medicine_reminder/screens/add%20medicine/fields.dart';
import 'package:medicine_reminder/widgets/AppButton.dart';
import 'package:medicine_reminder/widgets/medicine_type_card.dart';
import 'package:provider/provider.dart';

import '../../models/pill.dart';

class AddMedicine extends StatefulWidget {
  const AddMedicine({super.key});

  @override
  State<AddMedicine> createState() => _AddMedicineState();
}

class _AddMedicineState extends State<AddMedicine> {
  final NotificationService _notificationService = NotificationService();
  final List<MedicineType> medicineTypes = [
    MedicineType("Syrup", Image.asset("assets/images/syrup.png"), true),
    MedicineType("Pill", Image.asset("assets/images/pills.png"), false),
    MedicineType("Capsule", Image.asset("assets/images/capsule.png"), false),
    MedicineType("Cream", Image.asset("assets/images/cream.png"), false),
    MedicineType("Drops", Image.asset("assets/images/drops.png"), false),
    MedicineType("Syringe", Image.asset("assets/images/syringe.png"), false),
  ];

  //-------------Pill object------------------
  int howManyWeeks = 1;
  DateTime selectedDate = DateTime.now();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  List notifications =[];


  @override
  void initState() {
    super.initState();
    initNotifies();
  }

  //init notifications
  Future initNotifies() async =>
      Provider.of<PillData>(context, listen: false).initNotifications();

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height - 60.0;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
              left: 20.0, right: 20.0, top: 30.0, bottom: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: deviceHeight * 0.05,
                child: FittedBox(
                  child: InkWell(
                    child: const Icon(Icons.arrow_back),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.01,
              ),
              Container(
                padding: const EdgeInsets.only(left: 15.0),
                height: deviceHeight * 0.05,
                child: FittedBox(
                  child: Text(
                    "Add Pills",
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.03,
              ),
              SizedBox(
                height: deviceHeight * 0.37,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Fields(
                    amountController: amountController,
                    nameController: nameController,
                    howManyWeeks: howManyWeeks,
                    onSliderChanged: sliderChanged,
                  ),
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.035,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: FittedBox(
                    child: Text(
                      "Medicine form",
                      style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.02,
              ),
              SizedBox(
                height: 100,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    ...medicineTypes.map(
                      (type) => MedicineTypeCard(
                        pillType: type,
                        handler: medicineTypeClick,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.03,
              ),
              SizedBox(
                width: double.infinity,
                height: deviceHeight * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: AppButton(
                        color: const Color.fromARGB(255, 166, 197, 223),
                        onTap: () => openTimePicker(),
                        buttonChild: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              DateFormat("h:mm a").format(selectedDate),
                              style: const TextStyle(
                                fontSize: 15.0,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            const Icon(
                              Icons.access_time,
                              size: 19,
                              color: Colors.deepPurple,
                            ),
                          ],
                        ),
                        textColor: Colors.black,
                      ),
                    ),
                    Expanded(
                      child: AppButton(
                        color: const Color.fromARGB(255, 166, 197, 223),
                        onTap: () => openDatePicker(),
                        buttonChild: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              DateFormat("dd.MM").format(selectedDate),
                              style: const TextStyle(
                                fontSize: 15.0,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            const Icon(
                              Icons.event,
                              size: 19,
                              color: Colors.deepPurple,
                            ),
                          ],
                        ),
                        textColor: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                height: deviceHeight * 0.09,
                width: double.infinity,
                child: AppButton(
                  color: Theme.of(context).primaryColor,
                  onTap: () => savePill(),
                  textColor: Colors.white,
                  buttonChild: const Text(
                    "Submit",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //slider changer
  void sliderChanged(double value) =>
      setState(() => howManyWeeks = value.round());

  //------------------------OPEN TIME PICKER (SHOW)----------------------------
  //------------------------CHANGE CHOOSE PILL TIME----------------------------

  Future<void> openTimePicker() async {
    await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
            helpText: "Choose Time")
        .then((value) {
      DateTime newDate = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          value != null ? value.hour : selectedDate.hour,
          value != null ? value.minute : selectedDate.minute);
      setState(() => selectedDate = newDate);

    });
  }

  Future<void> openDatePicker() async {
    await showDatePicker(
            context: context,
            initialDate: selectedDate,
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 100000)))
        .then((value) {
      DateTime newDate = DateTime(
          value != null ? value.year : selectedDate.year,
          value != null ? value.month : selectedDate.month,
          value != null ? value.day : selectedDate.day,
          selectedDate.hour,
          selectedDate.minute);
      setState(() => selectedDate = newDate);

    });
  }

  void medicineTypeClick(MedicineType medicine) {
    setState(() {
      for (var medicineType in medicineTypes) {
        medicineType.isChoose = false;
      }
      medicineTypes[medicineTypes.indexOf(medicine)].isChoose = true;
    });
  }

  Future savePill() async {
    //check if medicine time is lower than actual time
    if (selectedDate.millisecondsSinceEpoch <=
        DateTime.now().millisecondsSinceEpoch) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Check your medicine time and date'),
        ),
      );
    } else {
      //create pill object
      Pill pill = Pill(
        amount: amountController.text,
        howManyWeeks: howManyWeeks,
        medicineForm: medicineTypes[
                medicineTypes.indexWhere((element) => element.isChoose == true)]
            .name,
        name: nameController.text,
        time: selectedDate.millisecondsSinceEpoch,
        notifyId: Random().nextInt(10000000),
      );
      dynamic result =
      await Provider.of<PillData>(context,listen: false).addPill(pill);

      if (result == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Something Went Wrong'),
          ),
        );
        return;
      }
      else {
        print("id = "+pill.id.toString());
        for (int i = 0; i < howManyWeeks*7; i++) {

            //set the notification schneudele
            tz.initializeTimeZones();
            tz.setLocalLocation(tz.getLocation('Asia/Damascus'));

            await _notificationService.showNotification(
                pill.name, "${pill.amount} ${pill.medicineForm} ", time,
                pill.notifyId,
               Provider.of<PillData>(context,listen:false).flutterLocalNotificationsPlugin
            );
            selectedDate = selectedDate.add(const Duration(milliseconds: 604800000));
            pill.time = selectedDate.millisecondsSinceEpoch;
            pill.notifyId = Random().nextInt(10000000);
            print(pill.notifyId);
            notifications.add(pill.notifyId);
          }
        for (int i = 0; i < notifications.length ; i++) {
          print(notifications[i]);
        }
        //save notifications to delete later.
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        List<String> stringsList=  notifications.map((i)=>i.toString()).toList();
        prefs.setStringList("notifications", stringsList);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Saved'),
        ),
      );
      Navigator.pop(context);
    }
  }
  //get time difference
  int get time =>
      selectedDate.millisecondsSinceEpoch -
          tz.TZDateTime.now(tz.local).millisecondsSinceEpoch;
}
