import 'package:flutter/material.dart';
import 'package:hotel_app/customer/currentroom.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'booking_name.dart';

class SelectDateForBooking extends StatefulWidget {
  final int currentRoomPrice;
  const SelectDateForBooking({Key? key, required this.currentRoomPrice}) : super(key: key);

  @override
  State<SelectDateForBooking> createState() => _SelectDateForBookingState();
}

class _SelectDateForBookingState extends State<SelectDateForBooking> {
  int noOfGuests = 1;
  DateTimeRange selectedDates =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());

  DateTime? start;
  DateTime? end;

  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';
  String _rangeStart = '';
  String _rangeEnd = '';

  /// The method for [DateRangePickerSelectionChanged] callback, which will be
  /// called whenever a selection changed on the date picker widget.
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    /// The argument value will return the changed date as [DateTime] when the
    /// widget [SfDateRangeSelectionMode] set as single.
    ///
    /// The argument value will return the changed dates as [List<DateTime>]
    /// when the widget [SfDateRangeSelectionMode] set as multiple.
    ///
    /// The argument value will return the changed range as [PickerDateRange]
    /// when the widget [SfDateRangeSelectionMode] set as range.
    ///
    /// The argument value will return the changed ranges as
    /// [List<PickerDateRange] when the widget [SfDateRangeSelectionMode] set as
    /// multi range.
    setState(() {
      if (args.value is PickerDateRange) {
        start = args.value.startDate;
        end = args.value.endDate ?? args.value.startDate;
        _rangeStart =
            '${DateFormat('dd/MM/yyyy').format(args.value.startDate)}';
        _rangeEnd =
            ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';

        _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
            // ignore: lines_longer_than_80_chars
            ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
      } else if (args.value is DateTime) {
        _selectedDate = args.value.toString();
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
    });
  }

  int getNumberOfSelectedDays() {
    if (start != null && end != null) {
      Duration difference = end!.difference(start!);
      return difference.inDays + 1; // Adding 1 to include both start and end dates
    }
    return 0; // Return 0 if either start or end is null
  }

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
          "Select Date",
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Color(0xFF17203A),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Color(0xffe6f1f7),
                  //color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 3),
                      blurRadius: 8,
                    ),
                  ]),
              child: SfDateRangePicker(
                //backgroundColor: Color(0xFF17203A),
                headerStyle: DateRangePickerHeaderStyle(
                  textStyle: TextStyle(
                    color: Color(0xFF17203A),
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold,
                  ),
                ),
                monthCellStyle: DateRangePickerMonthCellStyle(
                  textStyle: TextStyle(
                    color: Color(0xFF17203A),
                    fontFamily: "Poppins",
                    fontSize: 14,
                  ),
                  todayTextStyle: TextStyle(
                    color: Color(0xFF17203A),
                    fontFamily: "Poppins",
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                startRangeSelectionColor: Color(0xFF17203A),
                endRangeSelectionColor: Color(0xFF17203A),
                selectionTextStyle: TextStyle(
                  color: Colors.white,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                rangeSelectionColor: Color(0xFF757F9E),
                rangeTextStyle: TextStyle(
                  color: Colors.white,
                  fontFamily: "Poppins",
                  fontSize: 14,
                ),
                view: DateRangePickerView.month,
                onSelectionChanged: _onSelectionChanged,
                selectionMode: DateRangePickerSelectionMode.range,
                initialSelectedRange:
                    PickerDateRange(DateTime.now(), DateTime.now()),
              ),
            ),
            CheckInCheckOut(
                size: size, rangeStart: _rangeStart, rangeEnd: _rangeEnd),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Text(
                "Guests",
                style: TextStyle(
                  color: Color(0xFF17203A),
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Color(0xffEDEDEE),
                    width: 1.0, // Adjust the width as needed
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(),
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color(0xffe6f1f7),
                        ),
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                noOfGuests = noOfGuests+1;
                              });
                            },
                            icon: Icon(
                              Icons.add,
                              size: 20,
                            ))),
                    Spacer(),
                    Text(
                      '$noOfGuests',
                      style: TextStyle(
                        color: Color(0xFF17203A),
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Spacer(),
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color(0xffe6f1f7),
                        ),
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                if(noOfGuests>1) {
                                  noOfGuests = noOfGuests - 1;
                                }
                              });
                            },
                            icon: Icon(
                              Icons.remove,
                              size: 20,
                            ))),
                    Spacer(),
                  ],
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  "Total : \$${widget.currentRoomPrice * getNumberOfSelectedDays()}",//*noOfdays
                  style: TextStyle(
                    color: Color(0xFF17203A),
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
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
                  currentOrderGloabl.checkIn = _rangeStart;
                  currentOrderGloabl.checkOut = _rangeEnd;
                  currentOrderGloabl.noOfDays = getNumberOfSelectedDays();
                  currentOrderGloabl.noOfGuests = noOfGuests;
                  currentOrderGloabl.totalPrice = widget.currentRoomPrice * getNumberOfSelectedDays();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NameOfBooking()));
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

            // Column(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   mainAxisSize: MainAxisSize.min,
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: <Widget>[
            //     Text('Selected date: $_selectedDate'),
            //     Text('Selected date count: $_dateCount'),
            //     Text('Selected range: $_range'),
            //     Text('Selected ranges count: $_rangeCount')
            //   ],
            // ),
          ],
        ),
      ),
    );

  }
}

class CheckInCheckOut extends StatelessWidget {
  const CheckInCheckOut({
    super.key,
    required this.size,
    required String rangeStart,
    required String rangeEnd,
  })  : _rangeStart = rangeStart,
        _rangeEnd = rangeEnd;

  final Size size;
  final String _rangeStart;
  final String _rangeEnd;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0, bottom: 20),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Check in",
                style: TextStyle(
                  color: Color(0xFF17203A),
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              SizedBox(
                width: size.width * 0.27, //105,
              ),
              Text(
                "Check out",
                style: TextStyle(
                  color: Color(0xFF17203A),
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  height: size.height * 0.06,
                  width: size.width * 0.4,
                  decoration: BoxDecoration(
                    color: Color(0xffe6f1f7),
                    //color: Colors.white,
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Text(
                      _rangeStart,
                      style: TextStyle(
                        color: Color(0xFF17203A),
                        fontFamily: "Poppins",
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
              Icon(
                Icons.play_arrow_rounded,
                color: Color(0xFF17203A),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  height: size.height * 0.06,
                  width: size.width * 0.4,
                  decoration: BoxDecoration(
                    color: Color(0xffe6f1f7),
                    //color: Colors.white,
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Text(
                      _rangeEnd,
                      style: TextStyle(
                        color: Color(0xFF17203A),
                        fontFamily: "Poppins",
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
