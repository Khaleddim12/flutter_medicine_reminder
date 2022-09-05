import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medicine_reminder/controller/pillController.dart';
import 'package:medicine_reminder/screens/add%20medicine/add_medicine.dart';
import 'package:medicine_reminder/screens/home/home.dart';
import 'package:medicine_reminder/screens/home/welcome_screen.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black.withOpacity(0.05),
      statusBarColor: Colors.black.withOpacity(0.05),
      statusBarIconBrightness: Brightness.dark));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PillData(),
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: const Color.fromRGBO(7, 190, 200, 1),
          textTheme: TextTheme(
            headline1: ThemeData.light().textTheme.headline1!.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 38.0,
                  fontFamily: "Popins",
                ),
            headline5: ThemeData.light().textTheme.headline1!.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 17.0,
                  fontFamily: "Popins",
                ),
            headline3: ThemeData.light().textTheme.headline3!.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 20.0,
                  fontFamily: "Popins",
                ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          "/": (context) => const Welcome(),
          "/home": (context) =>  Home(),
          "/add_medicine":(context)=>const AddMedicine() 
        },
        initialRoute: "/",
      ),
    );
  }
}
