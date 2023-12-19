import 'package:flutter/material.dart';
import 'package:hotel_app/customer/components/custom_textfield.dart';
import 'employeeHome.dart';
import 'employeeSignIn.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './firebase_auth_implementation/firebase_auth_services.dart';
import './global/toast.dart';


class EmployeeSignUpScreen extends StatefulWidget {
  const EmployeeSignUpScreen({Key? key}) : super(key: key);

  @override
  State<EmployeeSignUpScreen> createState() => _EmployeeSignUpScreenState();
}

class _EmployeeSignUpScreenState extends State<EmployeeSignUpScreen> {
  String  E_username = '';
  String E_email = '';
  String E_password = '' ;
  bool _isNotValidate = false;

  final FirebaseAuthService _auth = FirebaseAuthService();
  bool isSigningUp = false;

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
                  "Employee SignUp",
                  style: TextStyle(
                    fontFamily: "PoppinsBold",
                    fontSize: 45,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0,right: 10),
                child: CustomTextField(
                  initialValue: E_email.isEmpty?'':E_email,
                  hintText: "Enter your email",
                  obscureTexthehe: false,
                  prefixWidget: Icon(Icons.email_rounded,color: Color(0xFF17203A),),
                  onchangedFunction: (value){
                    E_email = value;
                  },
                  errorTexi: _isNotValidate ? "Enter proper info" :null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0,right: 10),
                child: CustomTextField(
                  initialValue: E_password.isEmpty?'':E_password,
                  hintText: "Enter your password",
                  obscureTexthehe: true,
                  prefixWidget: Icon(Icons.key,color: Color(0xFF17203A),),
                  onchangedFunction: (value){
                    E_password = value;
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
                      _signUp();
                      print(" EMPLOYEE ADDED");
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

              //OtherSignUpOptions(),
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => EmployeeSignInScreen()));
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
  void _signUp() async {

    setState(() {
      isSigningUp = true;
    });

    String username = E_username;
    String email = E_email;
    String password = E_password;

    User? user = await _auth.signUpWithEmailAndPassword(email, password);

    setState(() {
      isSigningUp = false;
    });
    if (user != null) {
      print("Employee is successfully created");
      Navigator.push(context, MaterialPageRoute(builder: (context) => EmployeeHomePage()));

    } else {
      print("Some error happendin Creating Employee");
    }
  }
}


