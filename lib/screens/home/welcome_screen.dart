import 'dart:io' show exit;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medicine_reminder/screens/home/home.dart';
import 'package:medicine_reminder/widgets/AppButton.dart';
import 'package:provider/provider.dart';

import '../../controller/pillController.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Future setData() async {
      await Provider.of<PillData>(context,listen: false).setData();
    }

    final double deviceHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Stack(
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: 0.3,
                child: Image.asset('assets/images/welcome_screen.jpg',
                    fit: BoxFit.cover),
              ),
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset('assets/images/welcome_image.png',
                        width: double.infinity, height: deviceHeight * 0.3),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Be in control of your meds',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(color: Colors.white70, height: 1.3),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: deviceHeight * 0.15,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                      child: AutoSizeText(
                        "An easy-to-use and reliable app that helps you remember to take your meds at the right time",
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              color: Colors.grey,
                            ),
                        textAlign: TextAlign.center,
                        maxLines: 3,
                      ),
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: AppButton(
                      color: Theme.of(context).primaryColor,
                      onTap: () {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (_) => Home()));
                      },
                      buttonChild: Text(
                        "Let's Get Started",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      textColor: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Color.fromARGB(255, 154, 171, 134)
                              .withOpacity(0.2),
                          highlightColor: Color.fromARGB(255, 154, 171, 134)
                              .withOpacity(0.2),
                          onTap: () {
                            //check if the platform is android or ios
                            bool isIOS = Theme.of(context).platform ==
                                TargetPlatform.iOS;
                            isIOS ? exit(0) : SystemNavigator.pop();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.transparent,
                              border: Border.all(
                                color: Colors.blueGrey,
                                width: 4,
                              ),
                            ),
                            child: const Text(
                              'Exit',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
