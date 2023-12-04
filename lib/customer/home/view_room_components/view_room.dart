import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../../newbookingpages/date_selection.dart';
import 'details.dart';
import 'facilities.dart';
import 'heading_style.dart';
import 'main_image_in_viewR.dart';
import 'reviews.dart';
import 'room_images.dart';

class ViewRoomPage extends StatefulWidget {
  final String UserIdV;
  final currentRoom;
  const ViewRoomPage({
    Key? key,
    required this.currentRoom, required this.UserIdV,
  }) : super(key: key);

  @override
  State<ViewRoomPage> createState() => _ViewRoomPageState();
}

class _ViewRoomPageState extends State<ViewRoomPage> {
  bool reviewsVisible = false;

  String roomFirstPicture =  " ";


  //final ScrollController _scrollController = ScrollController(); ...not working
  // @override
  // void dispose() {
  //   _scrollController.dispose();
  //   super.dispose();
  // }
  @override
  Widget build(BuildContext context) {
    int TotalnoOfReviews = 4345;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.07,
                ),
                MainImageInViewRoom(currentRoomName: widget.currentRoom['roomName'].toString(),currentFloorNo: widget.currentRoom['floorNo']),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: ViewRoomHeadingStyle(
                    heading: "Description",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: ReadMoreText(
                    widget.currentRoom['description'],
                    trimLines: 2,
                    textAlign: TextAlign.justify,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: '  Show more',
                    trimExpandedText: '  Show less',
                    style: TextStyle(
                      color: Color(0xFF858585),
                      fontFamily: "Poppins",
                      fontSize: 12,
                    ),
                    moreStyle: TextStyle(
                        fontWeight: FontWeight.bold, color: Color(0xffA0DAFB)),
                    lessStyle: TextStyle(
                        fontWeight: FontWeight.bold, color: Color(0xffA0DAFB)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: ViewRoomHeadingStyle(
                    heading: "Gallery",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: ImageListWithPlusFunctionality(),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: ViewRoomHeadingStyle(
                    heading: "Details",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: DetailsBlock(
                      bedrooms: widget. currentRoom['beds'],
                      bathrooms: widget.currentRoom['bathrooms'],
                      roomSize: widget.currentRoom['size']),
                ),
                ViewRoomHeadingStyle(
                  heading: "Facilities",
                ),
                FacilitiesBlock(size: size,faclitiesIds: widget.currentRoom['facilities'],),
                Row(
                  children: [
                    ViewRoomHeadingStyle(heading: "Reviews"),
                    SizedBox(
                      width: 9,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Text(
                      "5.0",
                      style: TextStyle(
                          fontFamily: "Poppins", color: Color(0xff0A8ED9)),
                    ), // average reviews

                    Text(
                      " ($TotalnoOfReviews reviews)",
                      style:
                          TextStyle(fontFamily: "Poppins", color: Colors.grey),
                    ),
                    SizedBox(
                      width: size.width * 0.16,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          reviewsVisible= !reviewsVisible;
                          //... not working
                          // if (reviewsVisible) {
                          //   // Scroll to the top of the list when it becomes visible
                          //   _scrollController.animateTo(
                          //     0.0,
                          //     duration: Duration(milliseconds: 500),
                          //     curve: Curves.easeInOut,
                          //   );
                          // }
                        });
                      },
                      child: Text("See all",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            color: Color(0xffA0DAFB),
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            decorationColor: Color(0xffA0DAFB),
                            decorationThickness: 3,
                          )),
                    ),
                  ],
                ),
                ReviewsBlock(reviewsVisible: reviewsVisible, size: size,currentRoom: widget.currentRoom,),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          color: Colors.white,
          child: Row(
            children: [
              Text("\$${widget.currentRoom['price'].toString()}",style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color(0xFF17203A),
              ),),
              Text(" /night",style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 14,
                color: Colors.grey,
              ),),
              Spacer(),
              DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFF17203A),
                    // gradient: LinearGradient(
                    //     begin: Alignment.centerLeft,
                    //     end: Alignment.centerRight,
                    //     colors: [
                    //       Color(0xff0A8ED9),
                    //       Color(0xffA0DAFB),
                    //     ]),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>
                        SelectDateForBooking(
                          UserIdS: widget.UserIdV,
                          currentRoom: widget.currentRoom,
                    )
                    ));
                  },
                  child: Text(
                    "Book Now",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 17,
                      color:Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.only(top: 12,bottom: 12,left: 24,right: 24)),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}



