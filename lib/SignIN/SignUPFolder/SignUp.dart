import 'package:flutter/material.dart';
import 'package:hotel_app/SignIN/SignUPFolder/SignIn.dart';
import 'package:hotel_app/SignIN/SignUPFolder/components/textbox.dart';

import '../../customer/home/main_customer_home.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool notvisible = true;
  @override
  Widget build(BuildContext context) {
    double fem = 10.0;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: size.height * 0.12,
            ),
            Center(
              child: Container(
                height: size.height*0.15,
                width: size.width*0.32,
                child: Image.asset(
                  "assets/images/منزل.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.055,
            ),
            TextContainers(
              image: "assets/images/id-card2.png",
              textfield:TextField(
                showCursor: true,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "Poppins",
                  color: Colors.black,
                ),
                onChanged: (value) {
                  //username = value;
                },
                decoration: InputDecoration(
                  hintText: "Enter your name",
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(
              height: size.height*0.02,
            ),
            TextContainers(
              image: "assets/images/number-blocks.png",
              textfield:TextField(
                showCursor: true,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "Poppins",
                  color: Colors.black,
                ),
                onChanged: (value) {
                  //username = value;
                },
                decoration: InputDecoration(
                  hintText: "Enter your CNIC",
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(
              height: size.height*0.02,
            ),
            TextContainers(
              image: "assets/images/user.png",
              textfield:TextField(
                showCursor: true,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "Poppins",
                  color: Colors.black,
                ),
                onChanged: (value) {
                  //username = value;
                },
                decoration: InputDecoration(
                  hintText: "Enter your email",
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(
              height: size.height*0.02,
            ),
            TextContainers(
              image: "assets/images/key.png",
              textfield:TextField(
                showCursor: true,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "Poppins",
                  color: Colors.black,
                ),
                obscureText: notvisible,
                onChanged: (value) {
                  //password = value;
                },
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: (){
                      notvisible = false;//!notvisible;
                    },
                    icon: Icon(
                        Icons.visibility),
                  ),
                  hintText: "Enter your password",
                  border: InputBorder.none,),

              ),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Container(
              width: size.width *0.79,
              height: size.height * 0.08,
              child: TextButton(
                onPressed: () {
                  // Add your button press logic here
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MainCustomerHomeScreen()));
                  print('Button pressed');
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xffDBE9FF)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  elevation: MaterialStateProperty.all<double>(4.0),
                  shadowColor: MaterialStateProperty.all<Color>(
                    Colors.black.withOpacity(0.5),
                  ),
                ),
                child:Text(
                  'SignUp',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: "Poppins",
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height*0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment:  CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Already have an account? ",
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Poppins",
                    color: Colors.black,
                  ),
                ),
                TextButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen()));
                  },
                  child: Text('SignIn',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationColor: Color(0xff1C91E3),
                      fontSize: 19,
                      fontFamily: "Poppins",
                      color: Color(0xff1C91E3),
                    ),
                  ),
                ),

              ],
            )
          ],

        ),
      ),
    );
  }
}
