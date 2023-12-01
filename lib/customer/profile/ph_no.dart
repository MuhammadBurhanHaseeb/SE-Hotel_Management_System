import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';

import '../components/custom_textfield.dart';



class SelectPhoneNo extends StatefulWidget {
  final String PhoneNo;
  final String CountryCode;
  final void Function(String) onPhoneNoChanged;
  final void Function(String) onCountryCodeChanged;
  const SelectPhoneNo({Key? key, required this.onPhoneNoChanged, required this.onCountryCodeChanged, required this.PhoneNo, required this.CountryCode}) : super(key: key);

  @override
  State<SelectPhoneNo> createState() => _SelectPhoneNoState();
}

class _SelectPhoneNoState extends State<SelectPhoneNo> {
  late String myCountryCode = ''; // instead of PK you will add here customer.countrycode
  String phoneNo ='';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    phoneNo = widget.PhoneNo;
    myCountryCode = widget.CountryCode;
  }
  Widget build(BuildContext context) {
    return CustomTextField(
      initialValue: phoneNo.isEmpty ? '' : phoneNo,
      //errorTexi: _isNotValidate ? "Enter proper info" : null,
       obscureTexthehe : false,
        hintText: "Phone Number",
        onchangedFunction: (value) {
        phoneNo = value;
          widget.onPhoneNoChanged(value!);
        },
        prefixWidget: CountryCodePicker(
          onChanged: (CountryCode){
            setState(() {
              myCountryCode= CountryCode.toString();
              widget.onCountryCodeChanged(myCountryCode!);
            });
            //print(myCountryCode);
          },
          // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
          initialSelection: myCountryCode,
          favorite: ['+39','PK'],  //The favorite property specifies that you want to mark Italy ('+39') and France ('FR') as favorites. When the user opens the country code picker, these two countries will appear at the top of the list for easy selection.
          // optional. Shows only country name and flag
          showCountryOnly: false,
          // optional. Shows only country name and flag when popup is closed.
          showOnlyCountryWhenClosed: false,
          // optional. aligns the flag and the Text left
          alignLeft: false,
        ),
      );
  }
}




//
// import 'package:flutter/material.dart';
// import 'package:intl_phone_number_input/intl_phone_number_input.dart';
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   final TextEditingController controller = TextEditingController();
//   String initialCountry = 'NG';
//   PhoneNumber number = PhoneNumber(isoCode: 'NG');
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(50.0),
//         child: SizedBox(
//           width: 300, // Set an appropriate width
//           child: InternationalPhoneNumberInput(
//             onInputChanged: (PhoneNumber number) {
//               print(number.phoneNumber);
//             },
//             onInputValidated: (bool value) {
//               print(value);
//             },
//             selectorConfig: SelectorConfig(
//               selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
//             ),
//             ignoreBlank: false,
//             autoValidateMode: AutovalidateMode.disabled,
//             selectorTextStyle: TextStyle(color: Colors.black),
//             initialValue: number,
//             textFieldController: controller,
//             formatInput: true,
//             keyboardType:
//             TextInputType.numberWithOptions(signed: true, decimal: true),
//             inputBorder: OutlineInputBorder(),
//             onSaved: (PhoneNumber number) {
//               print('On Saved: $number');
//             },
//           ),
//         ),
//       ),
//     );
//
//   }
// }


// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//
//   final TextEditingController controller = TextEditingController();
//   String initialCountry = 'NG';
//   PhoneNumber number = PhoneNumber(isoCode: 'NG');
//
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: formKey,
//       child: Container(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             InternationalPhoneNumberInput(
//               onInputChanged: (PhoneNumber number) {
//                 print(number.phoneNumber);
//               },
//               onInputValidated: (bool value) {
//                 print(value);
//               },
//               selectorConfig: SelectorConfig(
//                 selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
//               ),
//               ignoreBlank: false,
//               autoValidateMode: AutovalidateMode.disabled,
//               selectorTextStyle: TextStyle(color: Colors.black),
//               initialValue: number,
//               textFieldController: controller,
//               formatInput: true,
//               keyboardType:
//               TextInputType.numberWithOptions(signed: true, decimal: true),
//               inputBorder: OutlineInputBorder(),
//               onSaved: (PhoneNumber number) {
//                 print('On Saved: $number');
//               },
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 formKey.currentState?.validate();
//               },
//               child: Text('Validate'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 getPhoneNumber('+15417543010');
//               },
//               child: Text('Update'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 formKey.currentState?.save();
//               },
//               child: Text('Save'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void getPhoneNumber(String phoneNumber) async {
//     PhoneNumber number =
//     await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'US');
//
//     setState(() {
//       this.number = number;
//     });
//   }
//
//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }
//}