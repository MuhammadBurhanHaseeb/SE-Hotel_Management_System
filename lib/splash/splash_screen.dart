import 'package:flutter/material.dart';
import 'package:hotel_app/splash/background.dart';
import '../SignIN/SignIn.dart';
import '../SignIN/chooser_role.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    _navigatetoprofile();
  }
  _navigatetoprofile()async{
    await Future.delayed(Duration(milliseconds: 3600),(){});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ChooseRoleScreen()));
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SplashBackground(),
          Center(
            child: Container(
              child: Image.asset(
                "assets/gifs/Manzil.gif",
                height: size.height * 0.95,
              ),
        ),
          ),]
      ),
    );
  }
}
