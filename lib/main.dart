import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:handover/model/status.dart';
import 'package:handover/ui/home/home_view.dart';
import 'package:handover/utils/colors.dart';
import 'package:handover/utils/fonts.dart';

import 'model/user.dart';

var userType = UserType.driver;
User? currentUser;
Status? appStatus;
DatabaseReference? databaseStatusNodeRef;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  databaseStatusNodeRef = FirebaseDatabase.instance.ref("status");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Handover',
      theme: ThemeData(
        fontFamily: primaryFont,
        focusColor: colorPrimaryDark.toColor(),
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(body: HomeView()),
    );
  }
}
