import 'package:flutter/material.dart';
import 'package:hotel_app/splash/splash_screen.dart';
import 'customer/components/final_bottom_bar.dart';
import 'customer/home/main_customer_home.dart';
import 'customer/profile/ph_no.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'manzil app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  FinalBottomNav(),
    );
  }
}

