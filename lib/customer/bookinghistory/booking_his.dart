import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';


class BookingHistory extends StatefulWidget {
  const BookingHistory({Key? key}) : super(key: key);

  @override
  State<BookingHistory> createState() => _BookingHistoryState();
}

class _BookingHistoryState extends State<BookingHistory> {
  double increasedScreenSize = 1.0;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDate;

  Map<String, List> mySelectedEvents = {};

  final titleController = TextEditingController();
  final descpController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedDate = _focusedDay;
    loadPreviousEvents();
  }

  loadPreviousEvents() {
    mySelectedEvents = {
      "2023-08-13": [
        {"noOfDays": "02", "roomName": "standard room 03", "payment": "900"},
        {"noOfDays": "01", "roomName": "suit 04", "payment": "10,000"},
        {"noOfDays": "02", "roomName": "standard room 03", "payment": "900"},
        {"noOfDays": "01", "roomName": "suit 04", "payment": "10,000"},
        {"noOfDays": "02", "roomName": "standard room 03", "payment": "900"},
        {"noOfDays": "01", "roomName": "suit 04", "payment": "10,000"}
      ],
      "2023-09-30": [
        {"noOfDays": "05", "roomName": "delux room 01", "payment": "100"}
      ],
      "2023-09-20": [
        {"noOfDays": "10", "roomName": "family room 02", "payment": "200"}
      ]
    };
  }

  List _listOfDayEvents(DateTime dateTime) {
    if (mySelectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)] != null) {
      return mySelectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)]!;
    } else {
      return [];
    }
  }
  samplecheckerfunction(){
    final selectedEvents = _listOfDayEvents(_selectedDate!);
    if(selectedEvents.length > 3)
      {
        if(selectedEvents.length == 4)
          {
            increasedScreenSize = 1.2;
          }
        else {
          increasedScreenSize = (selectedEvents.length / 5);
        }

      }
    else{
      increasedScreenSize = 1.0;

    }
    //print(increasedScreenSize);
  }
//................to add events by clicking button.............//
  // _showAddEventDialog() async {
  //   await showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: const Text(
  //         'Add New Event',
  //         textAlign: TextAlign.center,
  //       ),
  //       content: Column(
  //         crossAxisAlignment: CrossAxisAlignment.stretch,
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           TextField(
  //             controller: titleController,
  //             textCapitalization: TextCapitalization.words,
  //             decoration: const InputDecoration(
  //               labelText: 'Title',
  //             ),
  //           ),
  //           TextField(
  //             controller: descpController,
  //             textCapitalization: TextCapitalization.words,
  //             decoration: const InputDecoration(labelText: 'Description'),
  //           ),
  //         ],
  //       ),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.pop(context),
  //           child: const Text('Cancel'),
  //         ),
  //         TextButton(
  //           child: const Text('Add Event'),
  //           onPressed: () {
  //             if (titleController.text.isEmpty &&
  //                 descpController.text.isEmpty) {
  //               ScaffoldMessenger.of(context).showSnackBar(
  //                 const SnackBar(
  //                   content: Text('Required title and description'),
  //                   duration: Duration(seconds: 2),
  //                 ),
  //               );
  //               //Navigator.pop(context);
  //               return;
  //             } else {
  //               print(titleController.text);
  //               print(descpController.text);
  //
  //               setState(() {
  //                 if (mySelectedEvents[
  //                 DateFormat('yyyy-MM-dd').format(_selectedDate!)] !=
  //                     null) {
  //                   mySelectedEvents[
  //                   DateFormat('yyyy-MM-dd').format(_selectedDate!)]
  //                       ?.add({
  //                     "eventTitle": titleController.text,
  //                     "eventDescp": descpController.text,
  //                   });
  //                 } else {
  //                   mySelectedEvents[
  //                   DateFormat('yyyy-MM-dd').format(_selectedDate!)] = [
  //                     {
  //                       "eventTitle": titleController.text,
  //                       "eventDescp": descpController.text,
  //                     }
  //                   ];
  //                 }
  //               });
  //
  //               print(
  //                   "New Event for backend developer ${json.encode(mySelectedEvents)}");
  //               titleController.clear();
  //               descpController.clear();
  //               Navigator.pop(context);
  //               return;
  //             }
  //           },
  //         )
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // Call samplecheckerfunction() after _selectedDate is set
    samplecheckerfunction();
    return SingleChildScrollView(
      child: Container(
        height: size.height * increasedScreenSize,
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.07,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     // yay IconButton ki jagan app ka logo lagana hai yahan
            //     IconButton(
            //         onPressed: () {},
            //         icon: Icon(Icons.chevron_left),
            //       style: ButtonStyle(
            //         //shape: MaterialStateProperty.all<OutlinedBorder>(OutlinedBorder()),
            //       ),
            //     ),
                // SizedBox(
                //   width: size.width*0.14,
                // ),
                Text(
                  "Booking History",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF17203A),
                  ),
                ),
            //   ],
            // ),
            SizedBox(
              height: size.height * 0.06,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20, top: 20, bottom: 30),
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xFF17203A),
                    //color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 3),
                        blurRadius: 8,
                      ),
                    ]),
                child: TableCalendar(
                  firstDay: DateTime(2023),
                  lastDay: DateTime(2025),
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                  //startingDayOfWeek: StartingDayOfWeek.monday,

                  //................... Calender Header Style...............//
                  headerStyle: HeaderStyle(
                    titleTextStyle: TextStyle(
                        color: Colors.white,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold),
                    formatButtonTextStyle:
                        TextStyle(color: Colors.white, fontFamily: "Poppins"),
                    formatButtonDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    leftChevronIcon: Icon(
                      Icons.chevron_left,
                      color: Colors.white,
                    ),
                    rightChevronIcon: Icon(
                      Icons.chevron_right,
                      color: Colors.white,
                    ),
                  ),

                  //.................... Days of week style.................//
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle:
                        TextStyle(color: Colors.white, fontFamily: "Poppins"),
                    weekendStyle:
                        TextStyle(color: Colors.white, fontFamily: "Poppins"),
                  ),

                  //..................... Overall Calender Style...............//
                  calendarStyle: CalendarStyle(
                    markerDecoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    outsideTextStyle: TextStyle(
                        color: Colors.grey,
                        fontFamily: "PoppinsThin",
                        fontWeight: FontWeight.bold),
                    defaultTextStyle: TextStyle(
                        color: Colors.white,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold),
                    weekendTextStyle:
                        TextStyle(color: Colors.white, fontFamily: "Poppins"),
                    todayDecoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    ),
                    selectedDecoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0xff0A8ED9),
                            Color(0xffA0DAFB),
                          ]),
                    ),
                  ),
                  onDaySelected: (selectedDay, focusedDay) {
                    if (!isSameDay(_selectedDate, selectedDay)) {
                      // Call `setState()` when updating the selected day
                      setState(() {
                        _selectedDate = selectedDay;
                        _focusedDay = focusedDay;
                      });
                    }
                  },
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDate, day);
                  },
                  onFormatChanged: (format) {
                    if (_calendarFormat != format) {
                      // Call `setState()` when updating calendar format
                      setState(() {
                        _calendarFormat = format;
                      });
                    }
                  },
                  onPageChanged: (focusedDay) {
                    // No need to call `setState()` here
                    _focusedDay = focusedDay;
                  },
                  eventLoader: _listOfDayEvents,
                ),
              ),
            ),
            ..._listOfDayEvents(_selectedDate!).map(
              (myEvents) => Padding(
                padding: const EdgeInsets.only(
                    left: 30.0, right: 30.0, bottom: 10.0, top: 0.0),
                child: Container(
                  height: size.height*0.06,//50
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color:  Color(0xffd9effc),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                    Text(
                      '${myEvents['noOfDays']} days',
                      style: TextStyle(
                          fontFamily: "Poppins",
                        fontSize: 16,
                      ),
                    ),
                    Text(
                        '${myEvents['roomName']}',
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                      Text(
                        '\$${myEvents['payment']}',
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //.............add event button
            // FloatingActionButton.extended(
            //   onPressed: () => _showAddEventDialog(),
            //   label: const Text('Add Event'),
            // ),
          ],
        ),
      ),
    );
  }
}
