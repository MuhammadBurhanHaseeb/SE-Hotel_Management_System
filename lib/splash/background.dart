import 'package:flutter/material.dart';

class SplashBackground extends StatelessWidget {

  const SplashBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors:[
                     Color(0xffDBE9FF),
                     Color(0xffFFFFFF),
                     Color(0xffFFFFFF),
                     Color(0xffDBE9FF),
                  ]),
          ),
    );
  }
}
