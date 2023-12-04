import 'package:flutter/material.dart';

import 'heading_row_of_reviews.dart';
import 'package:http/http.dart' as http;
import 'package:hotel_app/nodejs_routes.dart';
import 'dart:convert';


class ReviewsBlock extends StatefulWidget {
  final currentRoom;
  const ReviewsBlock({
    super.key,
    required this.reviewsVisible,
    required this.size, required this.currentRoom,
  });

  final bool reviewsVisible;
  final Size size;

  @override
  State<ReviewsBlock> createState() => _ReviewsBlockState();
}

class _ReviewsBlockState extends State<ReviewsBlock> {

  List reviewsOfRoom= [];
  List reviewCredential = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getReviewsOfRoomFunction();
    getCredentialsofEveryReview();
  }
  void getReviewsOfRoomFunction() async {
    String cRoomId = widget.currentRoom['_id'];
    var response = await http.get(
      Uri.parse('$getReviewsOfRoom?roomId=$cRoomId'),
      headers: {"Content-Type": "application/json"},
    );
    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse);
    setState(() {
      reviewsOfRoom = jsonResponse['success'];
    });
    if(reviewsOfRoom.isNotEmpty) {
      print("reviewsOfRoom: "+reviewsOfRoom.toString());
    }
    else
    {
      print("reviews EMPTY");
    }
  }

  void getCredentialsofEveryReview()async{
    List<dynamic> allCredentialContent = [];
    for(var review in reviewsOfRoom)
      {
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

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.reviewsVisible,
      child: Container(
        width: widget.size.width,
        child: ListView.builder(
          //controller: _scrollController, not working
          physics: NeverScrollableScrollPhysics(),// Disable scrolling for the ListView
          shrinkWrap: true,
          itemCount: reviewsOfRoom.length,
          itemBuilder: (context, index) {
            final currentReview = reviewsOfRoom[index];
            final currentCredential = reviewCredential[index];
            return Padding(
              padding: const EdgeInsets.only(top: 8.0,bottom: 8.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 4),
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    HeadingRowOfReview(
                      rating: currentReview['rating'],
                      userName: currentCredential['fullName'],
                      userPic: currentCredential['profilePicture'],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text( currentReview['reviewDetail'],style: TextStyle(
                        color:  Color(0xFF17203A),
                        fontFamily: "Poppins",
                      ),),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
