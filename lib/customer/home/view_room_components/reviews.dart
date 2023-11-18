import 'package:flutter/material.dart';

import 'heading_row_of_reviews.dart';

class ReviewsBlock extends StatelessWidget {
  const ReviewsBlock({
    super.key,
    required this.reviewsVisible,
    required this.size,
  });

  final bool reviewsVisible;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: reviewsVisible,
      child: Container(
        width: size.width,
        child: ListView.builder(
          //controller: _scrollController, not working
          physics: NeverScrollableScrollPhysics(),// Disable scrolling for the ListView
          shrinkWrap: true,
          itemCount: 3,
          itemBuilder: (context, index) {
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
                    HeadingRowOfReview(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Very nice and comfortable hotel, thank you for accompanying my vacation!",style: TextStyle(
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
