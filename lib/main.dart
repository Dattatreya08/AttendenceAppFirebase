import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:soham_academy/screens/splash.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    title: "Soham Academy",
    home:Splash(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.cyan,
    ),
  )
  );
}