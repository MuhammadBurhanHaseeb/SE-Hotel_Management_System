import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../../newbookingpages/date_selection.dart';
import 'details.dart';
import 'facilities.dart';
import 'heading_style.dart';
import 'main_image_in_viewR.dart';
import 'reviews.dart';
import 'room_images.dart';

import 'package:http/http.dart' as http;
import 'package:hotel_app/nodejs_routes.dart';
import 'dart:convert';

class ViewRoomPage extends StatefulWidget {
  final String UserIdV;
  final currentRoom;
  const ViewRoomPage({
    Key? key,
    required this.currentRoom,
    required this.UserIdV,
  }) : super(key: key);

  @override
  State<ViewRoomPage> createState() => _ViewRoomPageState();
}

class _ViewRoomPageState extends State<ViewRoomPage> {
  bool reviewsVisible = false;

  String roomFirstPicture = " ";

  List reviewsOfRoom = [];
  List reviewCredential = [];
  bool _isLoading = false;
  num averageRating = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true; // Set loading state to true while fetching data
    });

    // data fetching
    getReviewsOfRoomFunction();
    // Simulating a delay of 1 seconds or 0.5 sec(500 milliseconds) to fetch data
    await Future.delayed(Duration(milliseconds: 500));

    setState(() {
      // Set loading state to false after data is fetched
      _isLoading = false;
      // Updating data fields based on fetched data
      getAverageReviewRating();
    });
  }

  void getReviewsOfRoomFunction() async {
    String cRoomId = widget.currentRoom['_id'];
    print("CURRENT ROOM ID: " + cRoomId);
    var response = await http.get(
      Uri.parse('$getReviewsOfRoom?roomId=$cRoomId'),
      headers: {"Content-Type": "application/json"},
    );
    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse);
    setState(() {
      reviewsOfRoom = jsonResponse['success'];
    });
    if (reviewsOfRoom.isNotEmpty) {
      print("reviewsOfRoom: " + reviewsOfRoom.toString());
      getCredentialsofEveryReview();
    } else {
      print("reviews EMPTY");
    }
  }

  void getCredentialsofEveryReview() async {
    List<dynamic> allCredentialContent = [];
    for (var review in reviewsOfRoom) {
      String userId = review['userId'];
      var response = await http.get(
        Uri.parse('$getCredentialss?userId=$userId'),
        headers: {"Content-Type": "application/json"},
      );
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      allCredentialContent.addAll(jsonResponse['success']);
      setState(() {
        reviewCredential = allCredentialContent;
      });
      print(reviewCredential);
    }
  }
  void getAverageReviewRating(){
    num total = 0;
    for (var review in reviewsOfRoom){
      total = total + review['rating'];
    }
    averageRating = total/(reviewsOfRoom.length);
  }

  //final ScrollController _scrollController = ScrollController(); ...not working
  // @override
  // void dispose() {
  //   _scrollController.dispose();
  //   super.dispose();
  // }
  @override
  Widget build(BuildContext context) {
    int TotalnoOfReviews = reviewsOfRoom.length;
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
                MainImageInViewRoom(
                    UserIdM: widget.UserIdV,
                    currentRoomId: widget.currentRoom['_id'].toString(),
                    currentRoomName: widget.currentRoom['roomName'].toString(),
                    currentFloorNo: widget.currentRoom['floorNo'],
                  mainImage:(widget.currentRoom['gallery']!= null && widget.currentRoom['gallery'].isNotEmpty)
                      ?widget.currentRoom['gallery'][0].toString():"https://t4.ftcdn.net/jpg/04/73/25/49/360_F_473254957_bxG9yf4ly7OBO5I0O5KABlN930GwaMQz.jpg",
                ),
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
                  child: ImageListWithPlusFunctionality(
                    currentRoom: widget.currentRoom,
                  ),
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
                      bedrooms: widget.currentRoom['beds'],
                      bathrooms: widget.currentRoom['bathrooms'],
                      roomSize: widget.currentRoom['size']),
                ),
                ViewRoomHeadingStyle(
                  heading: "Facilities",
                ),
                FacilitiesBlock(
                  size: size,
                  faclitiesIds: widget.currentRoom['facilities'],
                ),
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
                      averageRating.toString(),
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
                          reviewsVisible = !reviewsVisible;
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
                _isLoading
                    ? Center(
                  child:
                  CircularProgressIndicator(
                    color: Colors.grey,
                  ), // Showing circular progress indicator while loading
                )
                    :ReviewsBlock(
                    reviewsOfRoom: reviewsOfRoom,
                    reviewCredential: reviewCredential,
                    reviewsVisible: reviewsVisible,
                    size: size),
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
              Text(
                "\$${widget.currentRoom['price'].toString()}",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Color(0xFF17203A),
                ),
              ),
              Text(
                " /night",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
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
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 4),
                        blurRadius: 5,
                      )
                    ]),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SelectDateForBooking(
                                  UserIdS: widget.UserIdV,
                                  currentRoom: widget.currentRoom,
                                )));
                  },
                  child: Text(
                    "Book Now",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.only(
                            top: 12, bottom: 12, left: 24, right: 24)),
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
