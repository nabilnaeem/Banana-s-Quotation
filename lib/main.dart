import 'package:banana/Controllers/Data%20controller.dart';
import 'package:banana/Controllers/binding.dart';
import 'package:banana/Views/First.dart';
import 'package:banana/Views/Login.dart';
import 'package:banana/Views/history.dart';
import 'package:banana/Views/new%20quote.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

import 'Views/Home.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'Views/preview.dart';
import 'firebase_options.dart';
String url ='https://peymziuamkkqjkatoqex.supabase.co';
String anonKey ='eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBleW16aXVhbWtrcWprYXRvcWV4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjE5MTQzMjAsImV4cCI6MjAzNzQ5MDMyMH0.gPP7ynr3eCTgHYPXljF22Bfo3YBxwn_rGl3_QGtI0so';
void main() async{
  runApp( MyApp());
}

class MyApp extends StatelessWidget {



  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(


      debugShowCheckedModeBanner: false,
      title: "Banana's System",
      theme: ThemeData(

        primarySwatch: Colors.grey,
      ),
      home:First()
    );
  }
   MaterialColor CustomWhiteColor = MaterialColor(
    0xFFFFFFFF, // Primary color value (white)
    <int, Color>{
      50: Color(0xFFFFFFFF), // 10% opacity
      100: Color(0xFFFFFFFF), // 20% opacity
      200: Color(0xFFFFFFFF), // 30% opacity
      300: Color(0xFFFFFFFF), // 40% opacity
      400: Color(0xFFFFFFFF), // 50% opacity
      500: Color(0xFFFFFFFF), // 60% opacity
      600: Color(0xFFFFFFFF), // 70% opacity
      700: Color(0xFFFFFFFF), // 80% opacity
      800: Color(0xFFFFFFFF), // 90% opacity
      900: Color(0xFFFFFFFF), // 100% opacity
    },
  );
}
