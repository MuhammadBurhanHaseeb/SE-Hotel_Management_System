import 'package:flutter/material.dart';

import 'heading_row_of_reviews.dart';



class ReviewsBlock extends StatefulWidget {
  final bool reviewsVisible;
  final Size size;
  final List reviewsOfRoom;
  final List reviewCredential;
  const ReviewsBlock({
    super.key,
    required this.reviewsVisible,
    required this.size, required this.reviewsOfRoom, required this.reviewCredential,
  });

  @override
  State<ReviewsBlock> createState() => _ReviewsBlockState();
}

class _ReviewsBlockState extends State<ReviewsBlock> {
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
          itemCount: widget.reviewsOfRoom!.length,
          itemBuilder: (context, index) {
            final currentReview = widget.reviewsOfRoom![index];
            final currentCredential = widget.reviewCredential![index];
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
                      rating: currentReview['rating'] != null ?currentReview['rating'].toString():"",
                      userName: currentCredential['fullName'] != null ?currentCredential['fullName']:"",
                      userPic: currentCredential['profilePicture'] != null ?currentCredential['profilePicture']:"",
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
