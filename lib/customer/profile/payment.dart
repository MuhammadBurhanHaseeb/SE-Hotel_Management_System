import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';

import '../newbookingpages/finalizing.dart';
import 'package:http/http.dart' as http;
import 'package:hotel_app/nodejs_routes.dart';
import 'dart:convert';

class PaymentsTypeContaingStoredUserCards {
  String paymentId;
  final String id_of_payOption;
  final String name_of_payOption;
  final String image_of_payOption;
  String? cardsNo_of_payOption;
  bool isChoosen;
  PaymentsTypeContaingStoredUserCards({
    required this.id_of_payOption,
    required this.name_of_payOption,
    required this.image_of_payOption,
    required this.isChoosen,
    required this.paymentId,
    this.cardsNo_of_payOption,
  });
}

class PaymentMethodPage extends StatefulWidget {
  final bool isnewBookingPage;
  final String UserIdP;
  final userCredentials;
  final currentRoom;
  final checkInDatetoDisplay;
  final checkOutDatetoDisplay;
  final noOfDays;
  final noOfGuest;
  final midPrice;
  final reservName;
  final reservCountrycode;
  final reservPhoneno;
  final checkInDatetoStore;
  final checkOutDatetoStore;
  const PaymentMethodPage(
      {Key? key,
      required this.isnewBookingPage,
      required this.UserIdP,
      this.currentRoom,
      this.checkInDatetoDisplay,
      this.checkOutDatetoDisplay,
      this.noOfDays,
      this.noOfGuest,
      this.midPrice,
      this.reservName,
      this.reservCountrycode,
      this.reservPhoneno,
      this.checkInDatetoStore,
      this.checkOutDatetoStore,
      required this.userCredentials})
      : super(key: key);

  @override
  State<PaymentMethodPage> createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  bool _isLoading = false;
  List paymentOptions = [];
  List allCardsOfUser = [];
  String choosenPaymentId = '';
  List<PaymentsTypeContaingStoredUserCards> paymentTypesWithCardsList = [];
  String currentRoomImage = '';
  String currentRoomCardNo = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    choosenPaymentId = widget.userCredentials[0]['paymentMethod'].toString();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true; // Set loading state to true while fetching data
    });

    // data fetching
    getPaymentOptionsFunction();
    getAllCardsOfUserFunction(widget.UserIdP);
    // Simulating a delay of 1 seconds or 0.5 sec(500 milliseconds) to fetch data
    await Future.delayed(Duration(milliseconds: 500));

    setState(() {
      // Set loading state to false after data is fetched
      _isLoading = false;
      // Updating data fields based on fetched data
      populatingPaymentList();
      addingCardsToPaymentList();
    });
  }

  @override
  void getPaymentOptionsFunction() async {
    var response = await http.get(
      Uri.parse(getAllPaymentOptions),
      headers: {"Content-Type": "application/json"},
    );
    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse);
    setState(() {
      paymentOptions = jsonResponse['success'];
    });
    if (paymentOptions.isNotEmpty) {
      print("PAYMENT OPTIONS: " + paymentOptions.toString());
    } else {
      print("PAYMENT OPTIONS EMPTY");
    }
  }

  @override
  void getAllCardsOfUserFunction(userId) async {
    var response = await http.get(
      Uri.parse('$getAllpayCardsOfUser?userId=$userId'),
      headers: {"Content-Type": "application/json"},
    );
    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse);
    setState(() {
      allCardsOfUser = jsonResponse['success'];
    });
    print("ALL CARDS    " + allCardsOfUser.toString());
  }

  void populatingPaymentList() {
    int i = 0;

    ///............adding values to the paymentTypesWithCardsList list
    for (var payOption in paymentOptions) {
      PaymentsTypeContaingStoredUserCards object =
          PaymentsTypeContaingStoredUserCards(
              id_of_payOption: payOption['_id'].toString(),
              name_of_payOption: payOption['paymentOptionName'].toString(),
              image_of_payOption: payOption['PaymentOptionImage'].toString(),
              cardsNo_of_payOption: '',
              isChoosen: false,
              paymentId: "");
      paymentTypesWithCardsList.add(object);

      ///............ printing to double check to avoid errors
      print(
        "POPULATED PAYMENT LIST : " +
            paymentTypesWithCardsList[i].id_of_payOption +
            paymentTypesWithCardsList[i].name_of_payOption +
            paymentTypesWithCardsList[i].image_of_payOption +
            paymentTypesWithCardsList[i].name_of_payOption +
            paymentTypesWithCardsList[i].cardsNo_of_payOption! +
            paymentTypesWithCardsList[i].paymentId
      );
      i++;
    }
  }

  void addingCardsToPaymentList() {
    int i = 0;
    for (var populatedOption in paymentTypesWithCardsList) {
      for (var cardOfUser in allCardsOfUser) {
        ///............if the user has added some card to the current paymentOption e.g paypal then it will add that card no to the cardNo of the current paymentoption in loop
        if (populatedOption.id_of_payOption == cardOfUser['paymentOptionId'].toString()) {
          populatedOption.cardsNo_of_payOption = cardOfUser['cardNo'].toString();
          populatedOption.paymentId = cardOfUser['_id'].toString();

          ///............if the current paymentId is stored in the current user's payment method then the
          if (choosenPaymentId == cardOfUser['_id'].toString()) {
            populatedOption.isChoosen = true;
            currentRoomImage = populatedOption.image_of_payOption;
            currentRoomCardNo = populatedOption.cardsNo_of_payOption.toString();
          }
        }
      }

      ///............ printing to double check to avoid errors
      print(
        "POPULATED PAYMENT LIST WITH CARDS AND CHOOSEN OPTION : " +
            paymentTypesWithCardsList[i].id_of_payOption +
            paymentTypesWithCardsList[i].name_of_payOption +
            paymentTypesWithCardsList[i].image_of_payOption +
            paymentTypesWithCardsList[i].cardsNo_of_payOption! +
            paymentTypesWithCardsList[i].isChoosen.toString()+
            paymentTypesWithCardsList[i].paymentId
      );

      i++;
    }
  }

  @override
  void updatePaymentIdInCredentials(paymentId) async {
    var reqBody = {"userId": widget.UserIdP, "paymentId": paymentId};
    var response = await http.post(Uri.parse(updateUserPaymentMethodId),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody));
    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse);
  }

  @override
  String currentPayment(List<PaymentsTypeContaingStoredUserCards> p) {
    for (PaymentsTypeContaingStoredUserCards pIndex in p) {
      if (pIndex.isChoosen == true) {
        return pIndex.name_of_payOption;
      }
    }
    return p[0].name_of_payOption;
  }

  @override
  Widget build(BuildContext context) {
    //PaymentTypes currentOption = paymentMethods[0];
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

              ///........................ add the list here which will get image +payment method name+ the active method
              _isLoading
                  ? Container(
                    height: size.height*0.45,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.grey,
                      ),
                    ),
                  )
                  :
              Container(
                //height: size.height * 0.09 * paymentMethods.length,
                //height:paymentMethods.length > 6? size.height+paymentMethods.length: (paymentMethods.length == 6? size.height:size.height*(paymentMethods.length/9)),
                width: size.width,
                color: Color(0xffE8F8EF),
                child: ListView.builder(
                  //...increase list size according to the list length
                  physics:
                      NeverScrollableScrollPhysics(), // Disable scrolling for the ListView
                  shrinkWrap: true,
                  //...
                  scrollDirection: Axis.vertical,
                  itemCount: paymentTypesWithCardsList.length,
                  itemBuilder: (context, index) {
                    final paymentMethod = paymentTypesWithCardsList[index];
                    return Padding(
                      padding: const EdgeInsets.only(
                          bottom: 20.0, left: 10.0, right: 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: ListTile(
                          onTap: () {
                            setState(() {
                              paymentTypesWithCardsList[index].isChoosen = true;
                              paymentTypesWithCardsList.forEach((element) {
                                if (element !=
                                    paymentTypesWithCardsList[index]) {
                                  element.isChoosen = false;
                                }
                              });

                              /// change the paymentMethodId in credentials
                              //currentRoomImage = paymentTypesWithCardsList[index].image_of_payOption;
                              //updatePaymentIdInCredentials(paymentTypesWithCardsList[index].paymentId);
                            });
                          },
                          title: Padding(
                            padding: const EdgeInsets.only(
                                left: 30.0, right: 30.0, top: 0.0, bottom: 0.0),
                            child: Column(
                              children: [
                                /// showing names and images of payment options with a radio button
                                Row(
                                  children: [
                                    // Add your icon here as a prefix
                                    Image.asset(
                                      paymentMethod.image_of_payOption,
                                      width: size.height * 0.03,
                                      height: size.height * 0.03,
                                    ),

                                    SizedBox(width: size.height * 0.026),

                                    Text(paymentMethod.name_of_payOption,
                                        style:
                                            TextStyle(fontFamily: "Poppins")),

                                    Spacer(),

                                    /// Adds space between text and radio button

                                    Radio<PaymentsTypeContaingStoredUserCards>(
                                      activeColor: Color(0xff0A8ED9),
                                      value: paymentMethod,
                                      groupValue:
                                          paymentTypesWithCardsList.firstWhere(
                                              (element) => element.isChoosen),
                                      onChanged: (value) {
                                        setState(() {
                                          paymentTypesWithCardsList[index].isChoosen = true;
                                          paymentTypesWithCardsList.forEach((element) {
                                            if (element != paymentTypesWithCardsList[index]) {
                                              element.isChoosen = false;
                                            }
                                          });
                                        });
                                        /// change the paymentMethodId in credentials
                                        updatePaymentIdInCredentials(paymentTypesWithCardsList[index].paymentId);

                                        ///updating image of paymentId
                                        currentRoomImage = paymentTypesWithCardsList[index].image_of_payOption;

                                        ///updating currentRoomCardNo to selected paymentmethod card no
                                        currentRoomCardNo = paymentTypesWithCardsList[index].cardsNo_of_payOption.toString();

                                      },
                                    ),
                                  ],
                                ),

                                /// to show the card number of selected option
                                Visibility(
                                  visible: paymentMethod.isChoosen,
                                  child: Row(
                                    children: [
                                      Text(
                                        "Card No:  ",
                                        style: TextStyle(
                                          fontSize: 13,
                                          //color: Colors.grey,
                                          fontFamily: "Poppins",
                                        ),
                                      ),
                                      Text(
                                        paymentMethod.cardsNo_of_payOption == ""
                                            ? "none"
                                            : paymentMethod
                                                .cardsNo_of_payOption!,
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey,
                                          fontFamily: "Poppins",
                                        ),
                                      ),
                                    ],
                                  ),
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
                height: size.height * 0.09,
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
                                builder: (context) => FinalizingPage(
                                      UserIdF: widget.UserIdP,
                                      currentRoom: widget.currentRoom,
                                      checkInDateToDisplay:
                                          widget.checkInDatetoDisplay,
                                      checkOutDateToDisplay:
                                          widget.checkOutDatetoDisplay,
                                      noOfDays: widget.noOfDays,
                                      noOfGuest: widget.noOfGuest,
                                      midPrice: widget.midPrice,
                                      reservName: widget.reservName,
                                      reservCountrycode:
                                          widget.reservCountrycode,
                                      reservPhoneno: widget.reservPhoneno,
                                      paymentCardNo:currentRoomCardNo,
                                      checkInDatetoStore:
                                          widget.checkInDatetoStore,
                                      checkOutDatetoStore:
                                          widget.checkOutDatetoStore,
                                  paymentImage: currentRoomImage,
                                  paymentMethodId: widget.userCredentials[0]['paymentMethod'].toString(),
                                  roomImage: (widget.currentRoom['gallery']!= null && widget.currentRoom['gallery'].isNotEmpty)
                                    ?widget.currentRoom['gallery'][1].toString():"https://t4.ftcdn.net/jpg/04/73/25/49/360_F_473254957_bxG9yf4ly7OBO5I0O5KABlN930GwaMQz.jpg",
                                    )));
                      },
                      child: Text(
                        "Continue",
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
                                top: 15, bottom: 15, left: 134, right: 134)),
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
