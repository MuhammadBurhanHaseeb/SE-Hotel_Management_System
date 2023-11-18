import 'package:flutter/material.dart';

import 'receipt.dart';

class AlertBox extends StatelessWidget {
  const AlertBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      title: Center(
        child: Column(
          children: [
            // Stack(
            //   children: [
            Image.asset(
              "assets/images/confetti2.png",
              height: 200,
              width: 200,
            ),
            // Positioned(
            //   top: 70,
            //     left: 50,
            //     child: Image.asset(
            //   "assets/images/tick.png",
            //   height: 100,
            //   width: 100,
            //   color: Color(0xFF17203A),
            // )),
            //   ],
            // ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0,left: 10,right: 10),
              child: Text("Payment Successful!",style: TextStyle(
                fontFamily: "PoppinsBold",
                fontSize: 20,
                color: Color(0xFF17203A),
              ),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Successfully made payment and hotel booking",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 17,
                  color: Color(0xFF17203A),
                ),),
            ),
          ],
        ),
      ),
      // content: const Text(
      //      "Successfully made payment and hotel booking"),
      actions: [
        Center(
          child: Column(
            children: [
              ElevatedButton(
                style: ButtonStyle(
                    padding:
                    MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.only(
                            top: 15,
                            bottom: 15,
                            left: 80,
                            right: 80)),
                    backgroundColor:
                    MaterialStateProperty.all<Color>(
                        Color(0xFF17203A))),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FinalReceipt()));

                },
                child: const Text(
                  "View Receipt",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 14.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    padding:
                    MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.only(
                            top: 15,
                            bottom: 15,
                            left: 100,
                            right: 100)),
                    //backgroundColor: MaterialStateProperty.all<Color>(Color(0xffA0DAFB))
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14,
                      color: Color(0xFF17203A),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}