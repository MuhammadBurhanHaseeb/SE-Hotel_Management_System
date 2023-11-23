import 'package:flutter/material.dart';
import 'package:hotel_app/customer/components/final_bottom_bar.dart';
import 'package:hotel_app/customer/components/custom_textfield.dart';
import 'package:hotel_app/customer/profile/gender.dart';
import 'package:hotel_app/customer/profile/ph_no.dart';

class CredentialsAfterSignUp extends StatefulWidget {
  const CredentialsAfterSignUp({Key? key}) : super(key: key);

  @override
  State<CredentialsAfterSignUp> createState() => _CredentialsAfterSignUpState();
}

class _CredentialsAfterSignUpState extends State<CredentialsAfterSignUp> {
  DateTime? selectedDate = null; // Add this line to store the selected date
  @override
  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year.toString()}";
  }
  @override
  Widget build(BuildContext context) {
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
                padding: const EdgeInsets.only(left: 10.0,right: 10),
                child: CustomTextField(
                  hintText: "Full name",
                  obscureTexthehe: false,
                  //prefixWidget: Icon(Icons.email_rounded,color: Color(0xFF17203A),),
                  onchangedFunction: (value){
                    ///username = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0,right: 10),
                child: CustomTextField(
                  hintText: "CNIC",
                  obscureTexthehe: false,
                  // prefixWidget: Icon(Icons.key,color: Color(0xFF17203A),),
                  onchangedFunction: (value){
                    ///password = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0,right: 10),
                child: CustomTextField(
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
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0,right: 10),
                child: GenderSelector(),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0,right: 10),
                child: SelectPhoneNo(),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 20,top: 50),
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FinalBottomNav()));

                    },
                    child: Text(
                      "Sign Up",
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
