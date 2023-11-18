import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';

import '../newbookingpages/finalizing.dart';

class PaymentTypes {
  final String name;
  final String IconImage;
  bool isSelected;
  PaymentTypes(
      {required this.name, required this.IconImage, required this.isSelected});
}

List<PaymentTypes> paymentMethods = [
  PaymentTypes(
      name: "Paypal",
      IconImage: "assets/paymentIcons/paypal.png",
      isSelected: true),
  PaymentTypes(
      name: "Google pay",
      IconImage: "assets/paymentIcons/google.png",
      isSelected: false),
  PaymentTypes(
      name: "Apple pay",
      IconImage: "assets/paymentIcons/apple-logo.png",
      isSelected: false),
];

class PaymentMethodPage extends StatefulWidget {
  final bool isnewBookingPage;
  const PaymentMethodPage({Key? key, required this.isnewBookingPage}) : super(key: key);

  @override
  State<PaymentMethodPage> createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  @override
  String currentPayment(List<PaymentTypes> p) {
    for (PaymentTypes pIndex in p) {
      if (pIndex.isSelected == true) {
        return pIndex.name;
      }
    }
    return p[0].name;
  }

  @override
  Widget build(BuildContext context) {
    PaymentTypes currentOption = paymentMethods[0];
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.07,
              ),
              Row(
                children: [
                  BackButton(
                    onPressed: () {
                      // store the current payment method on pressing this
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    width: 19,
                  ),
                  Text(
                    "Payment",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF17203A),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.07,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Payment Methods",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 17,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          // add new credit/debit card
                        },
                        child: Text(
                          "Add new Card",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 17,
                            color: Color(0xff0A8ED9),
                          ),
                        )),
                  ],
                ),
              ),
              //........................ add the list here which will get image +payment method name+ the active method
              Container(
                //height: size.height * 0.09 * paymentMethods.length,
                //height:paymentMethods.length > 6? size.height+paymentMethods.length: (paymentMethods.length == 6? size.height:size.height*(paymentMethods.length/9)),
                width: size.width,
                color: Color(0xffE8F8EF),
                child: ListView.builder(
                  //...increase list size according to the list length
                  physics: NeverScrollableScrollPhysics(), // Disable scrolling for the ListView
                  shrinkWrap: true,
                  //...
                  scrollDirection: Axis.vertical,
                  itemCount: paymentMethods.length,
                  itemBuilder: (context, index) {
                    final paymentMethod = paymentMethods[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20.0,left: 10.0,right: 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: ListTile(
                          onTap: () {
                            setState(() {
                              paymentMethods[index].isSelected = true;
                              paymentMethods.forEach((element) {
                                if (element != paymentMethods[index]) {
                                  element.isSelected = false;
                                }
                              });
                            });
                          },
                          title: Padding(
                            padding: const EdgeInsets.only(left: 30.0,right: 30.0,top: 0.0,bottom: 0.0),
                            child: Row(
                              children: [
                                // Add your icon here as a prefix
                                Image.asset(
                                    paymentMethod.IconImage,
                                  width: size.height*0.03,
                                  height: size.height*0.03,
                                ),


                                SizedBox(width: size.height*0.026), // Adjust the spacing as needed

                                Text(paymentMethod.name),

                                Spacer(), // Adds space between text and radio button

                                Radio<PaymentTypes>(
                                  activeColor: Color(0xff0A8ED9),
                                  value: paymentMethod,
                                  groupValue: paymentMethods
                                      .firstWhere((element) => element.isSelected),
                                  onChanged: (value) {
                                    setState(() {
                                      paymentMethods[index].isSelected = true;
                                      paymentMethods.forEach((element) {
                                        if (element != paymentMethods[index]) {
                                          element.isSelected = false;
                                        }
                                      });
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: size.height*0.22,
              ),
              Visibility(
                visible: widget.isnewBookingPage,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: DecoratedBox(
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => FinalizingPage()));
                      },
                      child: Text(
                        "Continue",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 17,
                          color:Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(50),
                        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.only(top: 15,bottom: 15,left: 134,right: 134)),
                        //backgroundColor: MaterialStateProperty.all<Color>(Color(0xffA0DAFB))
                      ),
                    ),
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
