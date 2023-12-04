import 'package:flutter/material.dart';

import 'heading_style.dart';
import 'package:hotel_app/nodejs_routes.dart';

class HeadingRowOfReview extends StatefulWidget {
  final String userName;
  final String userPic;
  final String rating;
  const HeadingRowOfReview({
    super.key, required this.userName, required this.userPic, required this.rating,
  });

  @override
  State<HeadingRowOfReview> createState() => _HeadingRowOfReviewState();
}

class _HeadingRowOfReviewState extends State<HeadingRowOfReview> {

  String? imageUrl;
  @override
  void initState() {
    super.initState();
    String imageURLForFlutter = widget.userPic.replaceAll(r'\', '/');
    setState(() {
      imageUrl = url+ imageURLForFlutter;
    });
    print(imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        CircleAvatar(
          backgroundImage:
        (imageUrl != url) ? NetworkImage(imageUrl!) as ImageProvider: AssetImage("assets/images/noimageuser.png"),
        ),
        SizedBox(
          width: size.width*0.02,
        ),
        ViewRoomHeadingStyle(heading: widget.userName),
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
              Text(widget.rating,style: TextStyle(
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