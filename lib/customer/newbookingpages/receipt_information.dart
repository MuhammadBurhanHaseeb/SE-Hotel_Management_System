import 'package:flutter/material.dart';
import 'package:hotel_app/customer/currentroom.dart';

class ReceiptInfo extends StatelessWidget {
  final String BookingId;
  final String reservName;
  final String BookingphoneNo;
  final String RoomName;
  final String checkInDateToDisplay;
  final String checkOutDateToDisplay;
  final num noOfGuest;
  final num TotalPrice;
  const ReceiptInfo({
    super.key, required this.BookingId, required this.reservName, required this.BookingphoneNo, required this.RoomName, required this.checkInDateToDisplay, required this.checkOutDateToDisplay, required this.noOfGuest, required this.TotalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      //left: 20,
      top: 225,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //.....................................................
              Text("Order Number",textAlign: TextAlign.start,style: TextStyle(
                color: Colors.grey,
                fontFamily: "Poppins",
                fontSize: 17,
              ),),
              SizedBox(
                height: 5,
              ),

              //.....................................................
              Text("Name",textAlign: TextAlign.start,style: TextStyle(
                color: Colors.grey,
                fontFamily: "Poppins",
                fontSize: 17,
              ),),
              SizedBox(
                height: 5,
              ),
              //.....................................................
              Text("Phone No",textAlign: TextAlign.start,style: TextStyle(
                color: Colors.grey,
                fontFamily: "Poppins",
                fontSize: 17,
              ),),
              SizedBox(
                height: 5,
              ),
              //.....................................................
              Text("Room Name",textAlign: TextAlign.start,style: TextStyle(
                color: Colors.grey,
                fontFamily: "Poppins",
                fontSize: 17,
              ),),
              SizedBox(
                height: 5,
              ),
              //.....................................................
              Text("Check in",textAlign: TextAlign.start,style: TextStyle(
                color: Colors.grey,
                fontFamily: "Poppins",
                fontSize: 17,
              ),),
              SizedBox(
                height: 5,
              ),
              //.....................................................
              Text("Check out",textAlign: TextAlign.start,style: TextStyle(
                color: Colors.grey,
                fontFamily: "Poppins",
                fontSize: 17,
              ),),
              SizedBox(
                height: 5,
              ),
              //.....................................................
              Text("Guests",textAlign: TextAlign.start,style: TextStyle(
                color: Colors.grey,
                fontFamily: "Poppins",
                fontSize: 17,
              ),),
              SizedBox(
                height: 5,
              ),
              //.....................................................
              Text("Total Payment",textAlign: TextAlign.start,style: TextStyle(
                color: Colors.grey,
                fontFamily: "Poppins",
                fontSize: 17,
              ),),

            ],
          ),


          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(BookingId,textAlign: TextAlign.end,style: TextStyle(
                color: Colors.white,
                fontFamily: "Poppins",
                fontSize: 17,
              ),),
              SizedBox(
                height: 5,
              ),
              //.....................................................
              Text(reservName,textAlign: TextAlign.end,style: TextStyle(
                color: Colors.white,
                fontFamily: "Poppins",
                fontSize: 17,
              ),),
              SizedBox(
                height: 5,
              ),
              //.....................................................
              Text(BookingphoneNo,textAlign: TextAlign.end,style: TextStyle(
                color: Colors.white,
                fontFamily: "Poppins",
                fontSize: 17,
              ),),
              SizedBox(
                height: 5,
              ),
              //.....................................................
              Text(RoomName,textAlign: TextAlign.end,style: TextStyle(
                color: Colors.white,
                fontFamily: "Poppins",
                fontSize: 17,
              ),),
              SizedBox(
                height: 5,
              ),
              //.....................................................
              Text(checkInDateToDisplay,textAlign: TextAlign.end,style: TextStyle(
                color: Colors.white,
                fontFamily: "Poppins",
                fontSize: 17,
              ),),
              SizedBox(
                height: 5,
              ),
              //.....................................................
              Text(checkOutDateToDisplay,textAlign: TextAlign.end,style: TextStyle(
                color: Colors.white,
                fontFamily: "Poppins",
                fontSize: 17,
              ),),
              SizedBox(
                height: 5,
              ),
              //.....................................................
              Text(noOfGuest.toString(),textAlign: TextAlign.end,style: TextStyle(
                color: Colors.white,
                fontFamily: "Poppins",
                fontSize: 17,
              ),),
              SizedBox(
                height: 5,
              ),
              //.....................................................
              Text(TotalPrice.toString(),textAlign: TextAlign.end,style: TextStyle(
                color: Colors.white,
                fontFamily: "Poppins",
                fontSize: 17,
              ),),

            ],
          )
        ],
      ),
    );
  }
}