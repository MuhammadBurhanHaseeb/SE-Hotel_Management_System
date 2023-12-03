import 'package:flutter/material.dart';
import 'package:hotel_app/customer/currentroom.dart';
import 'package:velocity_x/velocity_x.dart';

import 'alertboxi.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hotel_app/nodejs_routes.dart';

class FinalizingPage extends StatefulWidget {
  final String UserIdF;
  final currentRoom;
  final String checkInDateToDisplay;
  final String checkOutDateToDisplay;
  final num noOfDays;
  final num noOfGuest;
  final num midPrice;
  final String reservName;
  final String reservCountrycode;
  final String reservPhoneno;
  final String paymentId;
  final DateTime checkInDatetoStore;
  final DateTime checkOutDatetoStore;
  const FinalizingPage({
    Key? key, required this.UserIdF, this.currentRoom, required this.checkInDateToDisplay, required this.checkOutDateToDisplay, required this.noOfDays, required this.noOfGuest, required this.midPrice, required this.reservName, required this.reservCountrycode, required this.reservPhoneno, required this.paymentId, required this.checkInDatetoStore, required this.checkOutDatetoStore,
  }) : super(key: key);

  @override
  State<FinalizingPage> createState() => _FinalizingPageState();
}

class _FinalizingPageState extends State<FinalizingPage> {

  num price_after_tax = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    calculatePriceAfterTax();
  }

  void calculatePriceAfterTax(){
    /// using dummy tax =10% bcz no room has tax right now so change it to widget.currentRoom['tax']
    num tax = widget.midPrice *(10/100);
    setState(() {
      price_after_tax = widget.midPrice+tax;
    });
  }

  void createBookingFunction() async {
    print("pppppppp"+widget.UserIdF+"  "+widget.currentRoom.toString()+"  "+widget.checkInDatetoStore.toString()+"  "+widget.checkOutDatetoStore.toString()+"  "+widget.noOfDays.toString()+"  "+widget.noOfGuest.toString()+"  "+price_after_tax.toString()+"  "+widget.reservName+"  "+widget.reservCountrycode+"   "+widget.reservPhoneno+"   "+widget.paymentId);
    if (
    widget.UserIdF.isNotEmpty &&
    widget.currentRoom.isNotEmpty &&
    widget.checkInDatetoStore != null &&
    widget.checkOutDatetoStore != null &&
        widget.noOfDays != null &&
        widget.noOfGuest != null &&
        price_after_tax != null &&
    widget.reservName.isNotEmpty &&
    widget.reservCountrycode.isNotEmpty &&
    widget.reservPhoneno.isNotEmpty &&
    widget.paymentId.isNotEmpty ) {
      var regBody = {
        "userId":widget.UserIdF,
        "roomId":widget.currentRoom['_id'].toString(),
        "checkIn":widget.checkInDatetoStore.toIso8601String(),
        "checkOut":widget.checkOutDatetoStore.toIso8601String(),
        "noOfDays":widget.noOfDays,
        "noOfGuests":widget.noOfGuest,
        "reservationName":widget.reservName,
        "reservationCountryCode":widget.reservCountrycode,
        "reservationPhoneNo":widget.reservPhoneno,
        "reservationPaymentMethod":widget.paymentId,
        "totalPrice": price_after_tax
      };

      var response = await http.post(Uri.parse(createNewBooking),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regBody));

      var jsonResponse = jsonDecode(response.body);

      print(jsonResponse['status']);

      if (jsonResponse['status']) {
        print("ALL GOOD");
        await showDialog(
          context: context,
          builder: (context) {
            return AlertBox();
          },
        );
      } else {
        print("SomeThing Went Wrong");
      }
    } else {
      print("ONE OF PARAMETERS EMPTY");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Finalizing Booking",
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Color(0xFF17203A),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
        child: Column(
          children: [
            /// booking info block
            Container(
              color: Color(0xffE8F8EF),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          leading: Container(
                            //padding: EdgeInsets.only(left: 5),
                            height: size.height * 0.08, //70
                            width: size.width * 0.2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0, 3),
                                  blurRadius: 8,
                                ),
                              ],
                              image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/standardroom_1878.jpg"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          title: Text(
                            widget.currentRoom['roomName'],
                            style: TextStyle(
                              fontFamily: "Poppins",
                              color: Color(0xFF17203A),
                              //fontSize: 16,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: size.height * 0.003,
                              ),
                              Text(
                                '\$${widget.currentRoom['price'].toString()} / day',
                                style: TextStyle(
                                  color: Color(0xff0A8ED9),
                                  fontFamily: "PoppinsThin",
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.003,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.hotel,
                                    size: size.height * 0.025,
                                    color: Colors.grey,
                                  ),
                                  Text(
                                    '${widget.currentRoom['beds'].toString()} Bedroom',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: "PoppinsThin",
                                      //color: Colors.grey,
                                    ),
                                  ),
                                  Icon(
                                    Icons.shower,
                                    size: size.height * 0.025,
                                    color: Colors.grey,
                                  ),
                                  Text(
                                    '${widget.currentRoom['bathrooms'].toString()} Bathroom',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: "PoppinsThin",
                                      //color: Colors.grey,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),

                      ///second block
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Check in",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 17,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 11,
                                    ),
                                    Text(
                                      "Check out",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 17,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 11,
                                    ),
                                    Text(
                                      "Guests",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 17,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      widget.checkInDateToDisplay,
                                      style: TextStyle(
                                        fontFamily: "PoppinsBold",
                                        fontSize: 17,
                                        //fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 11,
                                    ),
                                    Text(
                                      widget.checkOutDateToDisplay,
                                      style: TextStyle(
                                        fontFamily: "PoppinsBold",
                                        fontSize: 17,
                                        //fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 11,
                                    ),
                                    Text(
                                      widget.noOfGuest.toString(),
                                      style: TextStyle(
                                        fontFamily: "PoppinsBold",
                                        fontSize: 17,
                                        //fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      ///third block
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "No of Days",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 17,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 11,
                                    ),
                                    Text(
                                      "Taxes",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 17,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 11,
                                    ),
                                    Text(
                                      "Price of "+widget.noOfDays.toString()+" days",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 17,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 11,
                                    ),
                                    Container(
                                      height: 2,
                                      width: 200,
                                      color: Color(0xffE8F8EF),
                                    ),
                                    SizedBox(
                                      height: 11,
                                    ),
                                    Text(
                                      "Total",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 17,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      widget.noOfDays.toString(),
                                      style: TextStyle(
                                        fontFamily: "PoppinsBold",
                                        fontSize: 17,
                                        //fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 11,
                                    ),
                                    Text(
                                      "10 %",  //widget.currentRoom['tax']
                                      style: TextStyle(
                                        fontFamily: "PoppinsBold",
                                        fontSize: 17,
                                        //fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 11,
                                    ),
                                    Text(
                                      widget.midPrice.toString(),  //widget.currentRoom['tax']
                                      style: TextStyle(
                                        fontFamily: "PoppinsBold",
                                        fontSize: 17,
                                        //fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 11,
                                    ),
                                    Container(
                                      height: 2,
                                      width: 110,
                                      color: Color(0xffE8F8EF),
                                    ),
                                    SizedBox(
                                      height: 11,
                                    ),
                                    Text(
                                      price_after_tax.toString(),
                                      style: TextStyle(
                                        fontFamily: "PoppinsBold",
                                        fontSize: 17,
                                        //fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      ///fourth Block
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  "assets/paymentIcons/paypal.png",
                                  width: size.height * 0.03,
                                  height: size.height * 0.03,
                                ),
                                Spacer(),
                                Text(
                                  "4865291325274",
                                  style: TextStyle(
                                    fontFamily: "PoppinsBold",
                                    fontSize: 17,
                                    //fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Spacer(),
                                Spacer(),
                                Spacer(),
                                Spacer(),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "Change",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 17,
                                        color: Color(0xff0A8ED9),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            ///button
            Spacer(),
            DecoratedBox(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
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
                onPressed: ()  {
                  createBookingFunction();
                },
                child: Text(
                  "Complete Booking",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(50),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.only(
                          top: 15, bottom: 15, left: 110, right: 110)),
                  //backgroundColor: MaterialStateProperty.all<Color>(Color(0xffA0DAFB))
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


