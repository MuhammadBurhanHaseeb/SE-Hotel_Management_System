import 'package:flutter/material.dart';

class Options extends StatelessWidget {
  final Widget iconn;
  final String optionText ;
  final Color textColor;
  final VoidCallback press;
  const Options({
    super.key, required this.iconn, required this.optionText, required this.textColor, required this.press,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 27.0),
      child: GestureDetector(
        onTap: press,
        child: Row(
          children: [
            iconn,
            SizedBox(
              width: size.height*0.031, //21
            ),
            Text(
              optionText,
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}