import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:hotel_app/nodejs_routes.dart';
import 'dart:convert';
class RoomTypesCard extends StatefulWidget {
  final Function(String) currentCategoryId;
  const RoomTypesCard({Key? key, required this.currentCategoryId}) : super(key: key);

  @override
  State<RoomTypesCard> createState() => _RoomTypesCardState();
}

class _RoomTypesCardState extends State<RoomTypesCard> {
  late String categoryId;
  List room_categories = [];
  int selectedIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoriesFunction();
  }

  // @override
  void getCategoriesFunction() async {
    var response = await http.get(
      Uri.parse(getCategories),
      headers: {"Content-Type": "application/json"},
    );
    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse);
    setState(() {
      room_categories = jsonResponse['success'];
      categoryId = room_categories[selectedIndex]['_id'].toString();
    });
    if(room_categories.isNotEmpty) {
      print(room_categories);
      widget.currentCategoryId(categoryId);
      print("CURRENT CATEGORY: " + categoryId);
    }
    else
      {
        print("roomcategories EMPTY");
      }
    //setState(() {});
  }

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
          categoryId = room_categories[index]['_id'].toString(); // Fetch the ID
          //widget.currentCategoryId(room_categories[selectedIndex]['id'].toString());
        });
        widget.currentCategoryId(categoryId);
        print("CURRENT CATEGORY: " + categoryId);
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
          room_categories[index]['name'].toString(),
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
