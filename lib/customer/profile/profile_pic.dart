import 'package:flutter/material.dart';


class CircleProfilePicture extends StatelessWidget {
  const CircleProfilePicture({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        CircleAvatar(
          radius: size.height * 0.08,
          backgroundImage: AssetImage("assets/images/louis.jpg"),
        ),
        Positioned(
          bottom: 0,
          right: 5,
          child: Container(
            height: size.height * 0.039, //29
            width: size.height * 0.039,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
                bottomLeft: Radius.circular(
                    0.0), // No radius for the bottom left
              ),
              color: Color(0xffA0DAFB), // Background color
            ),
            child: InkWell(
              onTap: () {
                // Handle button tap here
                //open bottom popup with camera, gallery option
              },
              child: Icon(
                Icons.edit,
                color: Colors.white,
              ),
            ),
          ),

          // child: SizedBox(
          //   height: size.height * 0.039, //29
          //   width: size.height * 0.039,
          //   child: IconButton(
          //     onPressed: (){},
          //     icon:Icon(Icons.edit,),
          //     style: ButtonStyle(
          //       iconColor: MaterialStateProperty.all<Color>(Colors.white),
          //       padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(0.0)),
          //       backgroundColor: MaterialStateProperty.all<Color>(  Color(0xffA0DAFB)),
          //     ),
          //   ),
        ),
      ],
    );
  }
}
