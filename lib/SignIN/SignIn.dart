import 'package:flutter/material.dart';
import 'package:hotel_app/SignIN/SignUPFolder/SignUp.dart';
import 'package:hotel_app/SignIN/SignUPFolder/components/textbox.dart';

import '../customer/components/final_bottom_bar.dart';
import '../customer/home/main_customer_home.dart';
import '../customer/profile/custom_textfield.dart';

class SignInScreen extends StatefulWidget {
  final bool isCustomer;
  const SignInScreen({Key? key, required this.isCustomer}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  // bool notvisible = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              // SizedBox(
              //   height: size.height * 0.12,
              // ),
              // Center(
              //   child: Padding(
              //     padding: const EdgeInsets.only(bottom: 50.0),
              //     child: Container(
              //       height: size.height*0.15,
              //       width: size.width*0.32,
              //       child: Image.asset(
              //           "assets/images/منزل.png",
              //         fit: BoxFit.cover,
              //       ),
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Text(
                  "Login to your Account",
                  style: TextStyle(
                    fontFamily: "PoppinsBold",
                    fontSize: 45,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0,right: 10),
                child: CustomTextField(
                  hintText: "Enter your email",
                  obscureTexthehe: false,
                  prefixWidget: Icon(Icons.email_rounded,color: Color(0xFF17203A),),
                  onchangedFunction: (value){
                    ///username = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0,right: 10),
                child: CustomTextField(
                  hintText: "Enter your password",
                  obscureTexthehe: true,
                  prefixWidget: Icon(Icons.key,color: Color(0xFF17203A),),
                  onchangedFunction: (value){
                    ///password = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 20,top: 50),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: Color(0xFF17203A),
                      borderRadius: BorderRadius.circular(50),
                      boxShadow:[
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 4),
                          blurRadius: 5,
                        )
                      ]
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FinalBottomNav()));

                    },
                    child: Text(
                      "  Login  ",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 17,
                        color:Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(50),
                      padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.only(top: 15,bottom: 15,left: 134,right: 134)),
                      //backgroundColor: MaterialStateProperty.all<Color>(Color(0xffA0DAFB))
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: widget.isCustomer,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment:  CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: "Poppins",
                          color: Colors.black,
                        ),
                      ),
                      TextButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
                        },
                        style: ButtonStyle(

                        ),
                        child: Text('SignUp',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor: Color(0xffA0DAFB),
                          fontSize: 17,
                          fontFamily: "PoppinsBold",
                          color: Color(0xffA0DAFB),
                        ),
                      ),
                      ),

                    ],
                  ),
                ),
              ),
            ],

          ),
        ),
      ),
    );
  }
}
