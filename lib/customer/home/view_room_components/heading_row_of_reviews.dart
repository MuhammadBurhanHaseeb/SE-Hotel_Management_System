import 'package:flutter/material.dart';

import 'heading_style.dart';

class HeadingRowOfReview extends StatelessWidget {
  const HeadingRowOfReview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        CircleAvatar(
          backgroundImage:
          AssetImage("assets/images/louis.jpg"),
        ),
        SizedBox(
          width: size.width*0.02,
        ),
        ViewRoomHeadingStyle(heading: "Louis Pastridge"),
        Spacer(),
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Color(0xFF17203A),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(Icons.star,color: Color(0xffe6f1f7),size: 14,),
              Text(" 4.3",style: TextStyle(
                fontFamily: "PoppinsBold",
                color: Color(0xffe6f1f7),
                fontSize: 14,
              ),),
            ],
          ),
        )
      ],
    );
  }
}