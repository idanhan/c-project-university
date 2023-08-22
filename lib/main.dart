import 'package:cards/colors.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'cards/project1front.dart';
import './cards/project1back.dart';
import './cards/project2.dart';
import './cards/project2Back.dart';
import './cards/project3.dart';
import './cards/project3Back.dart';
import './colors.dart';
import './cards/project4.dart';
import './homescreen.dart';
import './actuallCards.dart/acCard1Front.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Main());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'cards',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
      routes: {
        'pro1': (context) => project1(),
        'pro1Back': (context) => project1Back(),
        'pro2': (context) => project2(),
        'pro2Back': (context) => pro2Back(),
        'pro3': (context) => project3(),
        'pro3Back': (context) => pro3Back(),
        'pro4': (context) => project4(),
        'pro1Real': (context) => frontReal(),
      },
    );
  }
}
