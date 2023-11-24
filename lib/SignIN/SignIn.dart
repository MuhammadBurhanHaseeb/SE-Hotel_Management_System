import 'package:flutter/material.dart';
import 'package:hotel_app/SignIN/SignUPFolder/SignUp.dart';
import 'package:hotel_app/SignIN/SignUPFolder/components/textbox.dart';
import 'package:hotel_app/SignIN/SignUPFolder/credentials_after_signup.dart';

import '../customer/components/final_bottom_bar.dart';
import '../customer/home/main_customer_home.dart';
import '../customer/components/custom_textfield.dart';

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;
import '../nodejs_routes.dart';
import '../dashi.dart';

class SignInScreen extends StatefulWidget {
  final bool isCustomer;
  const SignInScreen({Key? key, required this.isCustomer}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String email = '';
  String password = '';
  bool _isNotValidate = false;
  late SharedPreferences prefs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSharedPref();
  }
  void initSharedPref() async{
    prefs = await SharedPreferences.getInstance();
  }
  void loginUser() async{
    if(email.isNotEmpty && password.isNotEmpty){
      var reqBody = {
        "email":email,
        "password":password
      };
      var response = await http.post(Uri.parse(login),
          headers: {"Content-Type":"application/json"},
          body: jsonEncode(reqBody)
      );
      var jsonResponse = jsonDecode(response.body);

      if(jsonResponse['status']){
        ///....... this token contain the value of the current user who has logined and it is created in login function in user.controller.js file
        ///....... and we are using shared preferences that is helping us getting this token from user.controller.js file to local phone or using device
        ///....... storing the token in shared prefrences is basically the remember logined info option = true
        var myToken = jsonResponse['token'];
        prefs.setString('token', myToken);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>CredentialsAfterSignUp(token: myToken)));

      }else{
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                surfaceTintColor: Colors.transparent,
                title: Text('Error',style: TextStyle(
                  fontFamily: "Poppins",
                  color: Colors.red[300],
                ),),
                content: Text('${jsonResponse['error']}',style: TextStyle(
                  fontFamily: "Poppins",
                ),),
                actions: <Widget>[
                  TextButton(
                    child: Text('OK',style: TextStyle(
                        fontFamily: "Poppins",
                        color: Colors.blue
                    ),),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                  ),
                ],
              );});
      }
    }
  }
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
                  initialValue: email.isEmpty?'':email,
                  hintText: "Enter your email",
                  obscureTexthehe: false,
                  prefixWidget: Icon(Icons.email_rounded,color: Color(0xFF17203A),),
                  onchangedFunction: (value){
                    email= value;
                  },
                  errorTexi: _isNotValidate ? "Enter proper info" :null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0,right: 10),
                child: CustomTextField(
                  initialValue: password.isEmpty?'':password,
                  hintText: "Enter your password",
                  obscureTexthehe: true,
                  prefixWidget: Icon(Icons.key,color: Color(0xFF17203A),),
                  onchangedFunction: (value){
                    password = value;
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
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => FinalBottomNav()));
                      loginUser();
                      print("LOGINED");

                    },
                    child: Text(
                      "Continue",
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

