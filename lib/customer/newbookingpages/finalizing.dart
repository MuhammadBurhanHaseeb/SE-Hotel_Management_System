import 'package:flutter/material.dart';
import 'package:hotel_app/customer/currentroom.dart';

import 'alertboxi.dart';

class FinalizingPage extends StatelessWidget {
  const FinalizingPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
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
                            currentOrderGloabl.name,
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
                                '\$${currentOrderGloabl.price.toString()} / day',
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
                                    '${currentOrderGloabl.bedrooms.toString()} Bedroom',
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
                                    '${currentOrderGloabl.bathrooms.toString()} Bathroom',
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
                                      currentOrderGloabl.checkIn,
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
                                      currentOrderGloabl.checkOut,
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
                                      currentOrderGloabl.noOfGuests.toString(),
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
                                      currentOrderGloabl.noOfDays.toString(),
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
                                      "10 %",
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
                                      "\$${currentOrderGloabl.totalPrice}",
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
                onPressed: () async {
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return AlertBox();
                    },
                  );
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


