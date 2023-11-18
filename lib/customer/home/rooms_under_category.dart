import 'package:flutter/material.dart';

//not in use
class RoomsUnderCategory extends StatefulWidget {
  const RoomsUnderCategory({Key? key}) : super(key: key);

  @override
  State<RoomsUnderCategory> createState() => _RoomsUnderCategoryState();
}

class _RoomsUnderCategoryState extends State<RoomsUnderCategory> {
  List<String> rooms_available = [
    "Standard Room 1",
    "Standard Room 2",
    "Standard Room 3",
    "Standard Room 4",
    "Standard Room 5",
    "Standard Room 6",
  ];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      height: double.infinity,
      width: size.width*0.2,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: rooms_available.length,
        itemBuilder: ((context, index) =>
            buildRoomAvailableItem(index, context)),
      ),
    );
  }

  Widget buildRoomAvailableItem(int index, BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          boxShadow: [
            selectedIndex == index
                ? BoxShadow(
              color: Colors.black.withOpacity(0.1), // Shadow color
              offset: Offset(0, 7), // Shadow position, x = 0, y = 4
              blurRadius: 15, // Increased blur radius for a smoother shadow
              spreadRadius: 0, // Set spread radius to 0 for a smoother shadow
            )
                :BoxShadow(
              color: Colors.black.withOpacity(0), // Shadow color
              offset: Offset(0, 0), // Shadow position, x = 0, y = 4
              blurRadius: 0, // Blur radius
            ),

          ],
          gradient: selectedIndex == index
              ? LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xffA0DAFB),
              Color(0xff0A8ED9),
            ],
          )
              : LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xffF7F7F7),
              Color(0xffF7F7F7),
            ],
          ),

          //color: selectedIndex == index ? Colors.black : Color(0xffF3F5F7),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Text(
          rooms_available[index],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: selectedIndex == index ? Colors.white : Colors.grey,
            fontFamily: "PoppinsThin",
          ),
        ),
      ),
    );
  }
}
