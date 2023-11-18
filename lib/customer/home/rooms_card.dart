import 'package:flutter/material.dart';

class RoomTypesCard extends StatefulWidget {
  const RoomTypesCard({Key? key}) : super(key: key);

  @override
  State<RoomTypesCard> createState() => _RoomTypesCardState();
}

class _RoomTypesCardState extends State<RoomTypesCard> {
  List<String> room_categories = [
    "Standard Rooms",
    "Suites",
    "Deluxe Rooms",
    "Family Rooms",
    "Connecting Rooms",
    "Penthouse",
    "Business Rooms",
    "Event Rooms"
  ];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      height: size.height * 0.06, //50
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: room_categories.length,
        itemBuilder: ((context, index) =>
            buildRoomCategoryItem(index, context)),
      ),
    );
  }

  Widget buildRoomCategoryItem(int index, BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        height: size.height * 0.06, //50
        width: IntrinsicWidth().stepWidth,
        alignment: Alignment.center,
        margin: EdgeInsets.all(4),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          boxShadow: [
            selectedIndex == index
                ? BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 3),
                    blurRadius: 8,
                  )
                : BoxShadow(
                    color: Colors.black.withOpacity(0), // Shadow color
                    offset: Offset(0, 0), // Shadow position, x = 0, y = 4
                    blurRadius: 0, // Blur radius
                  ),
          ],
          // gradient: selectedIndex == index
          //     ? LinearGradient(
          //         begin: Alignment.centerLeft,
          //         end: Alignment.centerRight,
          //         colors: [
          //             Color(0xff0A8ED9),
          //             Color(0xffA0DAFB),
          //           ])
          //     // ? LinearGradient(
          //     //     begin: Alignment.topCenter,
          //     //     end: Alignment.bottomCenter,
          //     //     colors: [
          //     //       Color(0xffA0DAFB),
          //     //       Color(0xff0A8ED9),
          //     //     ],
          //     //   )
          //     : LinearGradient(
          //         begin: Alignment.topCenter,
          //         end: Alignment.bottomCenter,
          //         colors: [
          //           Color(0xffF7F7F7),
          //           Color(0xffF7F7F7),
          //         ],
          //       ),

          color: selectedIndex == index ? Color(0xFF17203A) : Color(0xffF3F5F7),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Text(
          room_categories[index],
          style: TextStyle(
            //fontWeight: FontWeight.bold,
            color: selectedIndex == index ? Colors.white : Colors.grey,
            fontFamily: "Poppins",
          ),
        ),
      ),
    );
  }
}
