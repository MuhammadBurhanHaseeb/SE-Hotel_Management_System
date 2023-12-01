import 'package:flutter/material.dart';
import 'package:hotel_app/customer/components/final_bottom_bar.dart';
import 'package:hotel_app/customer/components/custom_textfield.dart';
import 'package:hotel_app/customer/profile/gender.dart';
import 'package:hotel_app/customer/profile/ph_no.dart';

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import 'package:hotel_app/nodejs_routes.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import '../SignIn.dart';

class CredentialsAfterSignUp extends StatefulWidget {
  final token;
  const CredentialsAfterSignUp({Key? key, required this.token})
      : super(key: key);

  @override
  State<CredentialsAfterSignUp> createState() => _CredentialsAfterSignUpState();
}

class _CredentialsAfterSignUpState extends State<CredentialsAfterSignUp> {
  String fullName = '';
  String cnic = '';
  String gender = '';
  String countrycode = '';
  String phoneNumber = '';

  bool _isNotValidate = false;
  late String userId;
  List? items;
  DateTime? selectedDate = null; // Add this line to store the selected date

  @override
  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year.toString()}";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);

    userId = jwtDecodedToken['_id'];
    //getCredentialsFunction(userId);
  }

  void addCredentialsFunstion() async {
    print(userId+"  "+fullName+"  "+cnic+"  "+selectedDate.toString()+"  "+gender+"  "+countrycode+"  "+phoneNumber);
    if (userId.isNotEmpty &&
        fullName.isNotEmpty &&
        cnic.isNotEmpty &&
        selectedDate != null &&
        gender.isNotEmpty &&
        countrycode.isNotEmpty &&
        phoneNumber.isNotEmpty) {
      var regBody = {
        "userId": userId,
        "fullName": fullName,
        "cnic": cnic,
        "dateOfBirth": selectedDate?.toIso8601String(),
        "gender": gender,
        "countryCode": countrycode,
        "phoneNo": phoneNumber,
      };

      var response = await http.post(Uri.parse(addCredentials),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regBody));

      var jsonResponse = jsonDecode(response.body);

      print(jsonResponse['status']);

      if (jsonResponse['status']) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FinalBottomNav(UserId: userId,)));
      } else {
        print("SomeThing Went Wrong");
      }
    } else {
      setState(() {
        _isNotValidate = true;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
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
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Fill Your Profile",
                  style: TextStyle(
                    fontFamily: "PoppinsBold",
                    fontSize: 45,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: CustomTextField(
                  initialValue: fullName.isEmpty ? '' : fullName,
                  errorTexi: _isNotValidate ? "Enter proper info" : null,
                  hintText: "Full name",
                  obscureTexthehe: false,
                  //prefixWidget: Icon(Icons.email_rounded,color: Color(0xFF17203A),),
                  onchangedFunction: (value) {
                    fullName = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: CustomTextField(
                  initialValue: cnic.isEmpty ? '' : cnic,
                  errorTexi: _isNotValidate ? "Enter proper info" : null,
                  hintText: "CNIC",
                  obscureTexthehe: false,
                  // prefixWidget: Icon(Icons.key,color: Color(0xFF17203A),),
                  onchangedFunction: (value) {
                    cnic = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: CustomTextField(
                  initialValue:
                      selectedDate != null ? formatDate(selectedDate!) : '',
                  errorTexi: _isNotValidate ? "Enter proper info" : null,
                  hintText: "Date of Birth",
                  obscureTexthehe: false,
                  suffixWidget: GestureDetector(
                      onTap: () {
                        _selectDate(context);
                      },
                      child: Icon(
                        Icons.calendar_month_rounded,
                        color: Color(0xFF17203A),
                      )),
                  onchangedFunction: (value) {
                    ///password = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: GenderSelector(
                  Gender: "",
                  onGenderChanged: (value) {
                    setState(() {
                      gender =
                          value; // Update the selected gender in parent widget
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: SelectPhoneNo(
                  CountryCode: "",
                  PhoneNo: "",
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
                      addCredentialsFunstion();
                    },
                    child: Text(
                      "Let's begin",
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
                              top: 15, bottom: 15, left: 124, right: 124)),
                      //backgroundColor: MaterialStateProperty.all<Color>(Color(0xffA0DAFB))
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
}
