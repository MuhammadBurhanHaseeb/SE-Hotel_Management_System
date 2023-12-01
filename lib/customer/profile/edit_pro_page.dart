import 'package:flutter/material.dart';

import '../components/custom_textfield.dart';
import 'gender.dart';
import 'ph_no.dart';

class EditProfilePage extends StatefulWidget {
  final UserCredentials;
  final User;
  const EditProfilePage({Key? key, required this.UserCredentials, required this.User}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String gender = '';
  String countrycode = '';
  String phoneNumber = '';
  DateTime? selectedDate = null; // line to store the selected date
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String dateOfBirthString = widget.UserCredentials[0]['dateOfBirth'];
    selectedDate = DateTime.parse(dateOfBirthString);
    //selectedDate = widget.UserCredentials[0]['dateOfBirth'];
  }

  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year.toString()}";
  }
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });

      // Handle the selected date if needed
    }
  }
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
            CustomTextField(initialValue: widget.UserCredentials[0]['fullName'],hintText: "Full Name", onchangedFunction: (value) {},obscureTexthehe : false),
            CustomTextField(initialValue: widget.UserCredentials[0]['cnic'],hintText: "CNIC", onchangedFunction: (value) {},obscureTexthehe : false),
            CustomTextField(
              initialValue: selectedDate != null ? formatDate(selectedDate!) : '',
              hintText: "Date of Birth",
              obscureTexthehe: false,
              suffixWidget: GestureDetector(
                  onTap: (){
                    _selectDate(context);
                  },
                  child: Icon(Icons.calendar_month_rounded,color: Color(0xFF17203A),)),
              onchangedFunction: (value){
                ///password = value;
              },
            ),
            GenderSelector(
              Gender: widget.UserCredentials[0]['gender'],
              onGenderChanged: (value) {
                setState(() {
                  gender = value; // Update the selected gender in parent widget
                });
              },
            ),
            SelectPhoneNo(
              PhoneNo: widget.UserCredentials[0]['phoneNo'],
              CountryCode: widget.UserCredentials[0]['countryCode'],
              onCountryCodeChanged: (value) {
                setState(() {
                  countrycode = value; // Update the selected gender in parent widget
                });
              },
              onPhoneNoChanged: (value) {
                setState(() {
                  phoneNumber = value; // Update the selected gender in parent widget
                });
              },
            ),
            Padding(
                padding: const EdgeInsets.only(top:20.0,left: 20,right: 20),
              child: Container(
                width: size.width,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Color(0xffFBFBFB),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.white,
                    width: 1.0, // Adjust the width as needed
                  ),
                ),
                child: Text(
                    widget.User['email'],
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 17,
                    color: Color(0xFF17203A),
                  ),
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(top:20.0,left: 20,right: 20),
            //   child: Container(
            //     width: size.width,
            //     padding: const EdgeInsets.all(15),
            //     decoration: BoxDecoration(
            //       color: Color(0xffFBFBFB),
            //       borderRadius: BorderRadius.circular(10),
            //       border: Border.all(
            //         color: Colors.white,
            //         width: 1.0, // Adjust the width as needed
            //       ),
            //     ),
            //     child: Text(
            //       widget.User['password'],
            //       style: TextStyle(
            //         fontFamily: "Poppins",
            //         fontSize: 17,
            //         color: Color(0xFF17203A),
            //       ),
            //     ),
            //   ),
            // ),
            ///CustomTextField(initialValue:widget.User['email'],hintText: "Email".toString(), onchangedFunction: (value) {},obscureTexthehe : false),
            ///CustomTextField(initialValue:widget.User['password'],hintText: "Email".toString(), onchangedFunction: (value) {},obscureTexthehe : true),


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


