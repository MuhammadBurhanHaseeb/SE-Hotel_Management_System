import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../customer/components/custom_textfield.dart';
import 'employeeHome.dart';
import 'employeeSignUp.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import './global/toast.dart';
import 'package:google_sign_in/google_sign_in.dart';

import './firebase_auth_implementation/firebase_auth_services.dart';

class EmployeeSignInScreen extends StatefulWidget {
  const EmployeeSignInScreen({Key? key}) : super(key: key);

  @override
  State<EmployeeSignInScreen> createState() => _EmployeeSignInScreenState();
}

class _EmployeeSignInScreenState extends State<EmployeeSignInScreen> {
  String E_email = '';
  String E_password = '';
  bool _isNotValidate = false;

  bool _isSigning = false;
  final FirebaseAuthService _auth = FirebaseAuthService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(
          onPressed: () {
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
                  "Employee SignIn",
                  style: TextStyle(
                    fontFamily: "PoppinsBold",
                    fontSize: 45,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: CustomTextField(
                  initialValue: E_email.isEmpty ? '' : E_email,
                  hintText: "Enter your email",
                  obscureTexthehe: false,
                  prefixWidget: Icon(
                    Icons.email_rounded,
                    color: Color(0xFF17203A),
                  ),
                  onchangedFunction: (value) {
                    E_email = value;
                  },
                  errorTexi: _isNotValidate ? "Enter proper info" : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: CustomTextField(
                  initialValue: E_password.isEmpty ? '' : E_password,
                  hintText: "Enter your password",
                  obscureTexthehe: true,
                  prefixWidget: Icon(
                    Icons.key,
                    color: Color(0xFF17203A),
                  ),
                  onchangedFunction: (value) {
                    E_password = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20, top: 50),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: Color(0xFF17203A),
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 4),
                          blurRadius: 5,
                        )
                      ]),
                  child: TextButton(
                    onPressed: () {
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => FinalBottomNav()));
                      _signIn();
                      print("ADMIN LOGINED");
                    },
                    child: Text(
                      "Continue",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(50),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.only(
                              top: 15, bottom: 15, left: 134, right: 134)),
                      //backgroundColor: MaterialStateProperty.all<Color>(Color(0xffA0DAFB))
                    ),
                  ),
                ),
              ),

              ///divider
              Padding(
                padding: const EdgeInsets.only(
                    top: 30.0, bottom: 30, left: 40, right: 40),
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
              //OtherSignUpOptions(),
              Padding(
                padding: EdgeInsets.only(left: 30.0, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (){
                        _signInWithGoogle();
                      },//_signInWithGoogle(),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.grey,
                            width:
                                1.0, // Adjust the width of the border as needed
                          ),
                        ),
                        padding:
                            EdgeInsets.all(10.0), // Adjust the padding as needed
                        child: Image.asset(
                          "assets/paymentIcons/google.png", // Facebook icon from Flutter Icons package
                          height: 40.0,
                          width: 40, // Adjust the size of the icon as needed
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EmployeeSignUpScreen()));
                      },
                      style: ButtonStyle(),
                      child: Text(
                        'SignUp',
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

  void _signIn() async {
    setState(() {
      _isSigning = true;
    });

    String email = E_email;
    String password = E_password;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    setState(() {
      _isSigning = false;
    });

    if (user != null) {
      print("Employee is successfully signed in");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => EmployeeHomePage()));
    } else {
      print("some error occured in Sign IN");
    }
  }

  _signInWithGoogle() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        await _firebaseAuth.signInWithCredential(credential);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => EmployeeHomePage()));
      }
    } catch (e) {
      print("some error occured $e");
    }
  }
}

class OtherSignUpOptions extends StatelessWidget {
  const OtherSignUpOptions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30.0, right: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
              width: 40, // Adjust the size of the icon as needed
            ),
          ),
        ],
      ),
    );
  }
}
