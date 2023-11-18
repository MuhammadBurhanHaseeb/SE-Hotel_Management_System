import 'package:flutter/material.dart';


class GenderSelector extends StatefulWidget {
  const GenderSelector({
    super.key,
  });


  @override
  State<GenderSelector> createState() => _GenderSelectorState();
}

class _GenderSelectorState extends State<GenderSelector> {
  String dropdownValue = "Male";
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
      child: DropdownButtonFormField<String>(
        value: dropdownValue, // Current value of the dropdown
        decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xffFBFBFB),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Color(0xffC4C4C4)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Color(0xffA0DAFB), width: 2.5),
          ),
          contentPadding: const EdgeInsets.all(15),
        ),
        style: TextStyle(
          fontFamily: "Poppins",
          fontSize: 17,
          color: Color(0xFF17203A),
        ),
        items: <String>["Male", "Female", "Other"]
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
          });
        },
      ),
    );
  }
}