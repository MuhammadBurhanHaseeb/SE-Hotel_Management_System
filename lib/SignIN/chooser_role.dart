import 'package:flutter/material.dart';

import 'SignUPFolder/SignIn.dart';

class ChooseRoleScreen extends StatefulWidget {
  const ChooseRoleScreen({Key? key}) : super(key: key);

  @override
  State<ChooseRoleScreen> createState() => _ChooseRoleScreenState();
}

class _ChooseRoleScreenState extends State<ChooseRoleScreen> {
  Color inkColorCustomer = Colors.transparent;
  Color inkColorAdmin = Colors.transparent;
  Color inkColorEmployee = Colors.transparent;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Column(
            children: [
              Text(
                  "Let's you in",
                style: TextStyle(
                  fontFamily: "PoppinsBold",
                  fontSize: 45,
                ),
              ),

              ///Customer Role
              Padding(
                padding: const EdgeInsets.only(top: 100.0,bottom: 30),
                child: Material(
                  color: Colors.transparent,
                  //color: Color(0xfffcf4dd),
                  child: Ink(
                    decoration: BoxDecoration(
                      color: Colors.transparent, // Set the initial color
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen(
                          isCustomer: true,
                        )));
                      },
                      onHighlightChanged: (value) {
                        // Change the color when the button is pressed or released
                        if (value) {
                          // When pressed
                          inkColorCustomer = Colors.green.withOpacity(0.5);
                        } else {
                          // When released
                          inkColorCustomer = Colors.transparent;
                        }
                      },
                      child: Container(
                        height: 70,
                        width: 300,
                        //padding: EdgeInsets.only(left: 30, right: 30),
                        decoration: BoxDecoration(
                          color: inkColorCustomer, // Set the color dynamically
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.black,
                            width: 0.3,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ImageIcon(AssetImage("assets/images/customerIcon.png"), color: Colors.brown[300]),
                            Text(
                              "Continue as Customer",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Poppins",
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),


              ///Admin Role
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Material(
                  color: Colors.transparent,
                  //color: Color(0xffddedea),
                  child: Ink(
                    decoration: BoxDecoration(
                      color: Colors.transparent, // Set the initial color
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen(
                          isCustomer: false,
                        )));
                      },
                      onHighlightChanged: (value) {
                        // Change the color when the button is pressed or released
                        if (value) {
                          // When pressed
                          inkColorAdmin = Colors.blue.withOpacity(0.5);
                        } else {
                          // When released
                          inkColorAdmin = Colors.transparent;
                        }
                      },
                      child: Container(
                        height: 70,
                        width: 300,
                        //padding: EdgeInsets.only(left: 30, right: 30),
                        decoration: BoxDecoration(
                          color: inkColorAdmin, // Set the color dynamically
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.black,
                            width: 0.3,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ImageIcon(AssetImage("assets/images/adminIcon.png"), color: Colors.blueGrey),
                            Text(
                              "Continue as Admin      ",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Poppins",
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),


              ///Employee Role
              Material(
                color: Colors.transparent,
                //color: Color(0xffe8dff5),
                child: Ink(
                  decoration: BoxDecoration(
                    color: Colors.transparent, // Set the initial color
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen(
                        isCustomer: false,
                      )));
                    },
                    onHighlightChanged: (value) {
                      // Change the color when the button is pressed or released
                      if (value) {
                        // When pressed
                        inkColorAdmin = Colors.purple.withOpacity(0.5);
                      } else {
                        // When released
                        inkColorAdmin = Colors.transparent;
                      }
                    },
                    child: Container(
                      height: 70,
                      width: 300,
                      //padding: EdgeInsets.only(left: 30, right: 30),
                      decoration: BoxDecoration(
                        color: inkColorAdmin, // Set the color dynamically
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.black,
                          width: 0.3,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ImageIcon(AssetImage("assets/images/employeeIcon.png"), color: Colors.indigo[300]),
                          Text(
                            "Continue as Employee",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Poppins",
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                    ),
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
