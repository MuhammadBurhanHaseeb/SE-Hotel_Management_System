import 'package:flutter/material.dart';

import '../components/custom_textfield.dart';
import '../profile/payment.dart';
import '../profile/ph_no.dart';

class NameOfBooking extends StatefulWidget {
  const NameOfBooking({Key? key}) : super(key: key);

  @override
  State<NameOfBooking> createState() => _NameOfBookingState();
}

class _NameOfBookingState extends State<NameOfBooking> {
  String selectedOption = 'Mr.';
  String countrycode = '';
  String phoneNumber = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Reservation Name",
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Color(0xFF17203A),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                buildOptionButton('Mr.'),
                buildOptionButton('Ms.'),
                buildOptionButton('Mrs.'),
              ],
            ),
          ),
          CustomTextField(hintText: "Full Name", onchangedFunction: (value) {},obscureTexthehe : false),
          CustomTextField(hintText: "Email", onchangedFunction: (value) {},obscureTexthehe : false),
          SelectPhoneNo(
            CountryCode: "",
            PhoneNo: "",
            onCountryCodeChanged: (value) {
            setState(() {
              countrycode = value; // Update the selected gender in parent widget
            });
          },
            onPhoneNoChanged: (value) {
              setState(() {
                phoneNumber = value; // Update the selected gender in parent widget
              });
            },),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: DecoratedBox(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Color(0xFF17203A),
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
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentMethodPage(
                    isnewBookingPage: true,
                  )));
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
        ],
      ),
    );
  }

  Widget buildOptionButton(String option) {
    bool isSelected = selectedOption == option;
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedOption = option;
        });
      },
      style: ButtonStyle(
        shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
        surfaceTintColor: MaterialStateProperty.all<Color>(Colors.transparent),
        backgroundColor: isSelected
            ? MaterialStateProperty.all<Color>(Color(0xFF17203A)) // Change the background color for the selected option
            : MaterialStateProperty.all<Color>(Colors.transparent),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0,right: 16),
        child: Text(
          option,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontSize: 16.0,
            fontFamily: "Poppins"
          ),
        ),
      ),
    );
  }
}

