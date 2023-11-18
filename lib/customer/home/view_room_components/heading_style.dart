import 'package:flutter/material.dart';

class ViewRoomHeadingStyle extends StatelessWidget {
  final String heading;
  const ViewRoomHeadingStyle({
    super.key, required this.heading,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      heading,
      style: TextStyle(
        color: Color(0xFF17203A),
        fontFamily: "Poppins",
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}