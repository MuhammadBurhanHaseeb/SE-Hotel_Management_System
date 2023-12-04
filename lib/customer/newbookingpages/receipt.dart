import 'package:flutter/material.dart';
import 'package:hotel_app/customer/currentroom.dart';

import '../components/final_bottom_bar.dart';
import '../home/main_customer_home.dart';
import 'receipt_information.dart';

import 'package:pdf/pdf.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'dart:io';

class FinalReceiptPdfGenerator {
  static Future<pw.Document> generatePdf({
    required String bookingId,
    required String reservName,
    required String bookingphoneNo,
    required String roomName,
    required String checkInDateToDisplay,
    required String checkOutDateToDisplay,
    required num noOfGuest,
    required num totalPrice,
  }) async {
    final pdf = pw.Document();

    // Add a font to the PDF document
    final fontData = await rootBundle.load("fonts/Poppins/Poppins-Regular.ttf");
    final ttf = pw.Font.ttf(fontData.buffer.asByteData());

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Text('Booking ID: $bookingId', style: pw.TextStyle(font: ttf)),
                pw.Text('Reservation Name: $reservName', style: pw.TextStyle(font: ttf)),
                pw.Text('Phone Number: $bookingphoneNo', style: pw.TextStyle(font: ttf)),
                pw.Text('Room Name: $roomName', style: pw.TextStyle(font: ttf)),
                pw.Text('Check-In: $checkInDateToDisplay', style: pw.TextStyle(font: ttf)),
                pw.Text('Check-Out: $checkOutDateToDisplay', style: pw.TextStyle(font: ttf)),
                pw.Text('Number of Guests: $noOfGuest', style: pw.TextStyle(font: ttf)),
                pw.Text('Total Price: $totalPrice', style: pw.TextStyle(font: ttf)),
                // Add other widgets from your FinalReceipt here
              ],
            ),
          );
        },
      ),
    );

    return pdf;
  }
}

class FinalReceipt extends StatefulWidget {
  final String UserIdFR;
  final String BookingId;
  final String reservName;
  final String BookingphoneNo;
  final String RoomName;
  final String checkInDateToDisplay;
  final String checkOutDateToDisplay;
  final num noOfGuest;
  final num TotalPrice;
  const FinalReceipt(
      {Key? key,
      required this.BookingId,
      required this.reservName,
      required this.BookingphoneNo,
      required this.RoomName,
      required this.checkInDateToDisplay,
      required this.checkOutDateToDisplay,
      required this.noOfGuest,
      required this.TotalPrice,
      required this.UserIdFR})
      : super(key: key);

  @override
  State<FinalReceipt> createState() => _FinalReceiptState();
}

class _FinalReceiptState extends State<FinalReceipt> {
  Color inkColor = Colors.transparent;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: BackButton(
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //   ),
      //   title: Text(
      //     "Receipt",
      //     style: TextStyle(
      //       fontFamily: "Poppins",
      //       fontSize: 25,
      //       fontWeight: FontWeight.bold,
      //       color: Color(0xFF17203A),
      //     ),
      //   ),
      // ),
      body: Padding(
        padding:
            const EdgeInsets.only(bottom: 20.0, left: 20, right: 20, top: 50),
        child: Center(
          child: Column(
            children: [
              // Padding(
              //   padding: const EdgeInsets.only(bottom: 20.0),
              //   child: IconButton(
              //       onPressed: () {
              //         Navigator.pop(context);
              //       },
              //     icon: Icon(Icons.close),
              //     ),
              // ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 600,
                    // width: 500,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xFF17203A),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 13.32),
                          blurRadius: 39.97,
                        )
                      ],
                    ),
                  ),

                  ///...............................left ticket shape circle
                  Positioned(
                      left: -5,
                      top: 170,
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: const BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                      )),

                  ///.............................right ticket shape circle
                  Positioned(
                      right: -5,
                      top: 170,
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: const BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                      )),
                  Positioned(
                      top: 180,
                      left: 20,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0, left: 8),
                        child: DottedLine(),
                      )),

                  TickBlock(),
                  Positioned(
                    top: 125,
                    child: Text(
                      "Booking Confirmed",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "PoppinsBold",
                        //fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),

                  ReceiptInfo(
                    BookingId: widget.BookingId,
                    reservName: widget.reservName,
                    BookingphoneNo: widget.BookingphoneNo,
                    RoomName: widget.RoomName,
                    checkInDateToDisplay: widget.checkInDateToDisplay,
                    checkOutDateToDisplay: widget.checkOutDateToDisplay,
                    noOfGuest: widget.noOfGuest,
                    TotalPrice: widget.TotalPrice,
                  ),

                  ///......................... download receipt button .........................///
                  Positioned(
                    bottom: 30,
                    child: Material(
                      color: Colors.transparent,
                      child: Ink(
                        decoration: BoxDecoration(
                          color: Colors.transparent, // Set the initial color
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.white,
                            width: 1.0,
                          ),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () async {
                            final pdf =
                                await FinalReceiptPdfGenerator.generatePdf(
                              bookingId: widget.BookingId,
                              reservName: widget.reservName,
                              bookingphoneNo: widget.BookingphoneNo,
                              roomName: widget.RoomName,
                              checkInDateToDisplay: widget.checkInDateToDisplay,
                              checkOutDateToDisplay:
                                  widget.checkOutDateToDisplay,
                              noOfGuest: widget.noOfGuest,
                              totalPrice: widget.TotalPrice,
                            );

                            // Save the generated PDF to a file
                            final String dir =
                                (await getApplicationDocumentsDirectory()).path;
                            final String path = '$dir/receipt.pdf';
                            final File file = File(path);
                            await file.writeAsBytes(await pdf.save());

                            // Open the PDF file
                            OpenFile.open(path);
                          },
                          onHighlightChanged: (value) {
                            // Change the color when the button is pressed or released
                            if (value) {
                              // When pressed
                              inkColor = Colors.blue.withOpacity(0.5);
                            } else {
                              // When released
                              inkColor = Colors.transparent;
                            }
                          },
                          child: Container(
                            height: 50,
                            width: 270,
                            padding: EdgeInsets.only(left: 30, right: 30),
                            decoration: BoxDecoration(
                              color: inkColor, // Set the color dynamically
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.white,
                                width: 0.3,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.download, color: Colors.white),
                                Text(
                                  "Download Receipt",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Poppins",
                                    fontSize: 17,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  ///......................... download receipt button .........................///
                ],
              ),
              Spacer(),

              ///............................ back to home button .......................///
              DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFF17203A),
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
                            builder: (context) => FinalBottomNav(
                                  UserId: widget.UserIdFR,
                                )));
                  },
                  child: Text(
                    "Back to home",
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
      ),
    );
  }
}

class TickBlock extends StatelessWidget {
  const TickBlock({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 30,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              color: Color(0xff656B7C),
              borderRadius: BorderRadius.circular(50),
              //     boxShadow: [
              //     BoxShadow(
              //     color: Colors.grey,
              //     offset: Offset(0, 0),
              //     blurRadius: 5,
              //   )
              // ]
            ),
          ),
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Color(0xffA0DAFB),
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: Colors.white,
                width: 1.0, // Adjust the width as needed
              ),
            ),
            child: Icon(
              Icons.done,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class DottedLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 1, // Adjust the height of the line as needed
      child: CustomPaint(
        painter: DottedLinePainter(),
      ),
    );
  }
}

class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey // Set the color of the dots
      ..strokeWidth = 2; // Set the size of the dots

    final double dashWidth = 5; // Set the width of each dot
    final double dashSpace = 5; // Set the space between dots

    double startX = 0;
    while (startX < size.width * 1.5) {
      canvas.drawLine(
        Offset(startX, size.height / 2),
        Offset(startX + dashWidth, size.height / 2),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
