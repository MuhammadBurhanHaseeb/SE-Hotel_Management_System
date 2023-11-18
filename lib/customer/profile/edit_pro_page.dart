import 'package:flutter/material.dart';

import 'custom_textfield.dart';
import 'gender.dart';
import 'ph_no.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    // Initial value
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(children: [
            SizedBox(
              height: size.height * 0.07,
            ),
            Row(
              children: [
                BackButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                  width: 19,
                ),
                Text(
                  "Edit Profile",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF17203A),
                  ),
                ),
              ],
            ),
            CustomTextField(hintText: "Full Name", onchangedFunction: (value) {},obscureTexthehe : false),
            CustomTextField(hintText: "CNIC", onchangedFunction: (value) {},obscureTexthehe : false),
            CustomTextField(
                hintText: "Date of Birth", onchangedFunction: (value) {},obscureTexthehe : false),
            GenderSelector(),
            SelectPhoneNo(),
            CustomTextField(hintText: "Email", onchangedFunction: (value) {},obscureTexthehe : false),
            CustomTextField(hintText: "Password", onchangedFunction: (value) {},obscureTexthehe : true),


            Padding(
              padding: const EdgeInsets.only(left: 20.0,right: 20,top: 50),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Color(0xFF17203A),
                  borderRadius: BorderRadius.circular(50),
                  // gradient: LinearGradient(
                  //     begin: Alignment.centerLeft,
                  //     end: Alignment.centerRight,
                  //     colors: [
                  //       Color(0xff0A8ED9),
                  //       Color(0xffA0DAFB),
                  //     ]),
                  boxShadow:[
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 4),
                      blurRadius: 5,
                    )
                  ]
                ),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                      "Update",
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
            )
          ]),
        ),
      ),
    );
  }
}


