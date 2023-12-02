import 'package:flutter/material.dart';
import 'package:hotel_app/splash/splash_screen.dart';
import 'package:velocity_x/velocity_x.dart';
import 'SignIN/SignUPFolder/credentials_after_signup.dart';
import 'customer/components/final_bottom_bar.dart';
import 'customer/home/main_customer_home.dart';
import 'customer/profile/ph_no.dart';

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dashi.dart';
import 'package:http/http.dart' as http;
import 'package:hotel_app/nodejs_routes.dart';
import 'dart:convert';

void main() async {
  ///to keep user logined until the session(in user.controller.js file) has expired
  WidgetsFlutterBinding.ensureInitialized();

  /// for that purpose we check if we have a user info token in shared preference that is local storage
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(
    token: prefs.getString('token'),
  ));
}

class MyApp extends StatefulWidget {
  final token;
  const MyApp({super.key, this.token});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  late String userId;
  String items = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);

    userId = jwtDecodedToken['_id'];
    getCredentialsFunction(userId);
  }

  // @override
  void getCredentialsFunction(userId) async {
    var response = await http.get(
      Uri.parse('$getCredentialss?userId=$userId'),
      headers: {"Content-Type": "application/json"},
    );
    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse);
    setState(() {
      items = jsonResponse['success'].toString();
    });

    print("ITEMS"+items);
    //setState(() {});
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'manzil app',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        //home:SplashScreen());
        home: (widget.token != null &&
                JwtDecoder.isExpired(widget.token) == false)
            ? ((items == "" || items=="[]")
                ? CredentialsAfterSignUp(token: widget.token)
                : FinalBottomNav(UserId: userId,))
            : SplashScreen());
  }
}
