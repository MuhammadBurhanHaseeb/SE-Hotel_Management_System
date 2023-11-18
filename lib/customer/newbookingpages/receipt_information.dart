import 'package:flutter/material.dart';
import 'package:hotel_app/customer/currentroom.dart';

class ReceiptInfo extends StatelessWidget {
  const ReceiptInfo({
    super.key,
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
              Text("0839784364",textAlign: TextAlign.end,style: TextStyle(
                color: Colors.white,
                fontFamily: "Poppins",
                fontSize: 17,
              ),),
              SizedBox(
                height: 5,
              ),
              //.....................................................
              Text("Areeba Waheed",textAlign: TextAlign.end,style: TextStyle(
                color: Colors.white,
                fontFamily: "Poppins",
                fontSize: 17,
              ),),
              SizedBox(
                height: 5,
              ),
              //.....................................................
              Text("+92839784364",textAlign: TextAlign.end,style: TextStyle(
                color: Colors.white,
                fontFamily: "Poppins",
                fontSize: 17,
              ),),
              SizedBox(
                height: 5,
              ),
              //.....................................................
              Text(currentOrderGloabl.name,textAlign: TextAlign.end,style: TextStyle(
                color: Colors.white,
                fontFamily: "Poppins",
                fontSize: 17,
              ),),
              SizedBox(
                height: 5,
              ),
              //.....................................................
              Text(currentOrderGloabl.checkIn,textAlign: TextAlign.end,style: TextStyle(
                color: Colors.white,
                fontFamily: "Poppins",
                fontSize: 17,
              ),),
              SizedBox(
                height: 5,
              ),
              //.....................................................
              Text(currentOrderGloabl.checkOut,textAlign: TextAlign.end,style: TextStyle(
                color: Colors.white,
                fontFamily: "Poppins",
                fontSize: 17,
              ),),
              SizedBox(
                height: 5,
              ),
              //.....................................................
              Text(currentOrderGloabl.noOfGuests.toString(),textAlign: TextAlign.end,style: TextStyle(
                color: Colors.white,
                fontFamily: "Poppins",
                fontSize: 17,
              ),),
              SizedBox(
                height: 5,
              ),
              //.....................................................
              Text('\$${currentOrderGloabl.totalPrice.toString()}',textAlign: TextAlign.end,style: TextStyle(
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