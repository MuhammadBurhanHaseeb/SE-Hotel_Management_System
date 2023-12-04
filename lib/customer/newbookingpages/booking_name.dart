import 'package:flutter/material.dart';

import '../components/custom_textfield.dart';
import '../profile/payment.dart';
import '../profile/ph_no.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hotel_app/nodejs_routes.dart';

class NameOfBooking extends StatefulWidget {
  final String UserIdN;
  final currentRoom;
  final String checkInDatetoDisplay;
  final String checkOutDatetoDisplay;
  final num noOfDays;
  final num noOfGuest;
  final num midPrice;
  final DateTime checkInDatetoStore;
  final DateTime checkOutDatetoStore;
  const NameOfBooking(
      {Key? key,
      required this.UserIdN,
      this.currentRoom,
      required this.checkInDatetoDisplay,
      required this.checkOutDatetoDisplay,
      required this.noOfDays,
      required this.noOfGuest,
      required this.midPrice,
      required this.checkInDatetoStore,
      required this.checkOutDatetoStore})
      : super(key: key);

  @override
  State<NameOfBooking> createState() => _NameOfBookingState();
}

class _NameOfBookingState extends State<NameOfBooking> {
  String selectedOption = 'Mr.';
  String countrycode = '';
  String phoneNumber = '';
  String fullname = '';

  var userCredentials;
  bool _isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    setState(() {
      _isLoading = true; // Set loading state to true while fetching data
    });

    // data fetching
    getCredentialsFunction(widget.UserIdN);
    // Simulating a delay of 1 seconds or 0.5 sec(500 milliseconds) to fetch data
    await Future.delayed(Duration(milliseconds: 500));

    setState(() {
      // Set loading state to false after data is fetched
      _isLoading = false;
      // Updating  data fields based on fetched data
      countrycode = userCredentials[0]['countryCode'];
      phoneNumber = userCredentials[0]['phoneNo'];
      fullname = userCredentials[0]['fullName'];
    });
  }

  void getCredentialsFunction(userId) async {
    var response = await http.get(
      Uri.parse('$getCredentialss?userId=$userId'),
      headers: {"Content-Type": "application/json"},
    );
    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse);
    setState(() {
      userCredentials = jsonResponse['success'];
    });
    print("profile    " + userCredentials.toString());
  }

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
          _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.grey,
                  ), // Showing circular progress indicator while loading
                )
              : CustomTextField(
                  initialValue: fullname,
                  hintText: "Full Name",
                  onchangedFunction: (value) {
                    fullname = value;
                  },
                  obscureTexthehe: false),

          // _isLoading
          //     ? Center(
          //   child:
          //   CircularProgressIndicator(
          //     color: Colors.grey,
          //   ), // Showing circular progress indicator while loading
          // )
          //     :CustomTextField(hintText: "Email", onchangedFunction: (value) {},obscureTexthehe : false),

          _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.grey,
                  ), // Showing circular progress indicator while loading
                )
              : SelectPhoneNo(
                  CountryCode: countrycode,
                  PhoneNo: phoneNumber,
                  onCountryCodeChanged: (value) {
                    setState(() {
                      countrycode =
                          value; // Update the selected gender in parent widget
                    });
                  },
                  onPhoneNoChanged: (value) {
                    setState(() {
                      phoneNumber =
                          value; // Update the selected gender in parent widget
                    });
                  },
                ),
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
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 4),
                      blurRadius: 5,
                    )
                  ]),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PaymentMethodPage(
                                UserIdP: widget.UserIdN,
                                isnewBookingPage: true,
                                currentRoom: widget.currentRoom,
                                checkInDatetoDisplay: widget.checkInDatetoDisplay,
                                checkOutDatetoDisplay: widget.checkOutDatetoDisplay,
                                noOfDays: widget.noOfDays,
                                noOfGuest: widget.noOfGuest,
                                midPrice: widget.midPrice,
                                reservName: selectedOption + fullname,
                                reservCountrycode: countrycode,
                                reservPhoneno: phoneNumber,
                                checkInDatetoStore: widget.checkInDatetoStore,
                                checkOutDatetoStore: widget.checkOutDatetoStore,
                              )));
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
            ? MaterialStateProperty.all<Color>(Color(
                0xFF17203A)) // Change the background color for the selected option
            : MaterialStateProperty.all<Color>(Colors.transparent),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16),
        child: Text(
          option,
          style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontSize: 16.0,
              fontFamily: "Poppins"),
        ),
      ),
    );
  }
}
