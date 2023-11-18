import 'package:flutter/material.dart';
import 'package:hotel_app/SignIN/SignIn.dart';
import 'package:hotel_app/SignIN/SignUPFolder/components/textbox.dart';
import 'package:hotel_app/customer/newbookingpages/receipt.dart';
import 'package:hotel_app/customer/profile/custom_textfield.dart';

import '../../customer/home/main_customer_home.dart';
import 'credentials_after_signup.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
              //   child: Container(
              //     height: size.height*0.15,
              //     width: size.width*0.32,
              //     child: Image.asset(
              //       "assets/images/منزل.png",
              //       fit: BoxFit.cover,
              //     ),
              //   ),
              // ),
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CredentialsAfterSignUp()));

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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
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
