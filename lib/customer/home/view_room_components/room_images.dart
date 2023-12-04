import 'package:flutter/material.dart';

class ImageListWithPlusFunctionality extends StatefulWidget {
  final List images;

  const ImageListWithPlusFunctionality({
    Key? key,
    required this.images
  }) : super(key: key) ;

  @override
  State<ImageListWithPlusFunctionality> createState() => _ImageListWithPlusFunctionalityState();
}

class _ImageListWithPlusFunctionalityState extends State<ImageListWithPlusFunctionality> {
  // List<String> images = [
  //   'assets/images/standardroom_1878.jpg',
  //   'assets/images/louis.jpg',
  //   'assets/images/standardroom_1878.jpg',
  //   'assets/images/louis.jpg',
  //   'assets/images/standardroom_1878.jpg',
  //   'assets/images/louis.jpg',
  //   'assets/images/standardroom_1878.jpg',
  //   'assets/images/louis.jpg',
  // ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.images.length,
        itemBuilder: (context, index) {
          if (index == widget.images.length - 1) {
            return Padding(
              padding: const EdgeInsets.only(right:16.0),
              child: Container(
                height: 80,
                width: 80,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(
                                widget.images[index]) ,
                            fit: BoxFit.fill,
                          )),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Open a new screen to display the remaining images.
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Text("+",style:TextStyle(
                            //     fontSize: 14,
                            //     color: Colors.white,
                            //     fontFamily: "Poppins"
                            // ),),
                            // Text("5",style: TextStyle(
                            //   fontSize: 20,
                            //   color: Colors.white,
                            //   fontFamily: "Poppins"
                            // ),),
                            Text("open",style: TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                                fontFamily: "Poppins"
                            ),),
                          ],
                        ),//instead of 5 write the remaining pictures nos
                        decoration: BoxDecoration(
                          color: Colors.black54,
                            borderRadius: BorderRadius.circular(10),),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.only(right:16.0),
              child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(
                          widget.images[index]),
                      fit: BoxFit.fill,
                    )),
              ),
            );
          }
        },
      ),
    );
  }
}
