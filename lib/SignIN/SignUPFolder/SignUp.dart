import 'package:flutter/material.dart';
import 'package:hotel_app/SignIN/SignIn.dart';
import 'package:hotel_app/SignIN/SignUPFolder/components/textbox.dart';
import 'package:hotel_app/customer/newbookingpages/receipt.dart';
import 'package:hotel_app/customer/components/custom_textfield.dart';

import '../../customer/home/main_customer_home.dart';
import 'credentials_after_signup.dart';

import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;
import 'package:hotel_app/nodejs_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String email = '';
  String password = '' ;
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
  void registerUser() async{
    if(email.isNotEmpty && password.isNotEmpty){
      var regBody = {               //an object to send to backend
        "email":email,
        "password":password
      };
      var response = await http.post(Uri.parse(registration),
          headers: {"Content-Type":"application/json"},
          body: jsonEncode(regBody)
      );
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse['status']);

      if(jsonResponse['status']){
        var myToken = jsonResponse['token'];
        prefs.setString('token', myToken);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>CredentialsAfterSignUp(token: myToken)));
      }
      else{
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
        //print("SomeThing Went Wrong: ${jsonResponse['error']}");
      }
    }else{
      setState(() {
        _isNotValidate = true;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        // leading: BackButton(
        //   onPressed: (){
        //     Navigator.pop(context);
        //   },
        // ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Text(
                  "Create your Account",
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
                    email = value;
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
                  errorTexi: _isNotValidate ? "Enter proper info" :null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0,right: 30,top: 50),
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
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => CredentialsAfterSignUp()));
                      registerUser();
                      print(" USER ADDED");
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
                      padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.only(top: 15,bottom: 15,left: 124,right: 124)),
                      //backgroundColor: MaterialStateProperty.all<Color>(Color(0xffA0DAFB))
                    ),
                  ),
                ),
              ),

              ///divider
              Padding(
                padding: const EdgeInsets.only(top: 30.0,bottom: 30,left: 40,right: 40),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Divider(
                      height: 20,
                      thickness: 2,
                      color: Colors.grey,
                    ),
                    Container(
                      color: Colors.white,
                      child: Text(
                        " or continue with ",
                        style: TextStyle(
                          color: Colors.grey,
                          fontFamily: "Poppins",
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              OtherSignUpOptions(),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen(isCustomer: true)));
                      },
                      style: ButtonStyle(

                      ),
                      child: Text('SignIn',
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
            ],

          ),
        ),
      ),
    );
  }
}

class OtherSignUpOptions extends StatelessWidget {
  const OtherSignUpOptions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:  EdgeInsets.only(left: 30.0,right: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.grey,
                width: 1.0, // Adjust the width of the border as needed
              ),
            ),
            padding: EdgeInsets.all(5.0), // Adjust the padding as needed
            child: Icon(
              Icons.facebook, // Facebook icon from Flutter Icons package
              size: 50.0, // Adjust the size of the icon as needed
              color: Colors.blue, // Adjust the color of the icon as needed
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.grey,
                width: 1.0, // Adjust the width of the border as needed
              ),
            ),
            padding: EdgeInsets.all(10.0), // Adjust the padding as needed
            child: Image.asset(
              "assets/paymentIcons/google.png", // Facebook icon from Flutter Icons package
              height: 40.0,
              width: 40,// Adjust the size of the icon as needed
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.grey,
                width: 1.0, // Adjust the width of the border as needed
              ),
            ),
            padding: EdgeInsets.all(5.0), // Adjust the padding as needed
            child: Icon(
              Icons.apple, // Facebook icon from Flutter Icons package
              size: 50.0, // Adjust the size of the icon as needed
              color: Colors.black, // Adjust the color of the icon as needed
            ),
          ),
        ],
      ),
    );
  }
}
