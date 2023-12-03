import 'package:flutter/material.dart';
import 'package:hotel_app/customer/home/rooms_under_category.dart';

import '../customerBL/housesBL.dart';
import 'rooms_card.dart';
import 'rooms_in_category.dart';
import 'search.dart';

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:hotel_app/nodejs_routes.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCategoryId = '';
  List roomsInCurrentCategory= [];
  @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   getRoomsInCurrentCategoryFunction();
  // }

  // @override
  void getRoomsInCurrentCategoryFunction() async {
    var response = await http.get(
      Uri.parse('$getRoomsInACategory?categoryId=$selectedCategoryId'),
      headers: {"Content-Type": "application/json"},
    );
    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse);
    setState(() {
      roomsInCurrentCategory = jsonResponse['success'];
    });
    if(roomsInCurrentCategory.isNotEmpty) {
      print(roomsInCurrentCategory);
    }
    else
    {
      print("rooms EMPTY");
    }
    //setState(() {});
  }
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //SizedBox(height: size.height*0.05),
                Padding(
                  padding: const EdgeInsets.only(top:60,bottom:20,left: 25 , right: 20),
                  child: Text(
                    "Find Your Comfortable Place",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                      fontSize: size.height*0.04,//30
                      color: Color(0xFF17203A),
                    ),
                    //style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        //color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                SearchOption(press:(){}),
                RoomTypesCard(
                  currentCategoryId: (value){
                    print(value);
                    setState(() {
                      selectedCategoryId = value;
                      getRoomsInCurrentCategoryFunction();
                    });
                  },
                ),
                //RoomsOptions(size: size),
                RoomsInCategory(
                  isInFavScreen: false,
                  buttonbackColor: Colors.transparent,
                  icon_req: Icon(
                      Icons.remove_red_eye,
                      color: Color(0xffA0DAFB),//Colors.white, // Initial icon color (black)
                      size: size.height * 0.02,//10
                    ),
                  rooms: roomsInCurrentCategory,
                  // houses: [
                  //   HouseTrailers(name: 'Orchad House', price: 4500, bedrooms: 6, bathrooms: 4,size: 6000),
                  //   HouseTrailers(name: 'House', price: 5000, bedrooms: 6, bathrooms: 4,size: 1000),
                  //   HouseTrailers(
                  //       name: 'The Hollies House',
                  //       price: 10000,
                  //       bedrooms: 5,
                  //       bathrooms: 2,size: 4000),
                  // ],
                ),

        //         Padding(
        //           padding: const EdgeInsets.all(20),
        //           child: Text(
        //             "Recent",
        //             style: Theme.of(context).textTheme.headlineSmall!.copyWith(
        //                 color: Colors.black, fontWeight: FontWeight.bold),
        //           ),
        //         ),
        //         ...recentCourses
        //             .map((course) => Padding(
        //                   padding: const EdgeInsets.only(
        //                       left: 20, right: 20, bottom: 20),
        //                   child: SecondaryCourseCard(
        //                     title: course.title,
        //                     iconsSrc: course.iconSrc,
        //                     colorl: course.color,
        //                   ),
        //                 ))
        //             .toList(),
              ],
            ),
          ),
        ),
      )
    );
  }
}

//..................................not is use..........................//
// class RoomsOptions extends StatelessWidget {
//   const RoomsOptions({
//     super.key,
//     required this.size,
//   });
//
//   final Size size;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(left: 20, top: 20),
//       child: Container(
//         color: Colors.red,
//         height:size.height*0.1 ,
//         width: size.width*0.86,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Container(
//               //padding: EdgeInsets.only(left: 5),
//               height: size.height*0.08, //70
//               width: size.width*0.2,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 image: DecorationImage(
//                   image: AssetImage("assets/images/standardroom_1878.jpg"),
//                   fit: BoxFit.fill,
//                 ),
//               ),
//             ),
//             Container(
//               color: Colors.yellow,
//               height: size.height*0.06, //50
//               width: size.width*0.5,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Standard Room 1",
//                     style: TextStyle(
//                       fontFamily: "Poppins",
//                       fontSize: 16,
//                     ),
//                   ),
//                   Text("Rp. 2.500.000.000 / Month",style: TextStyle(
//                     color: Color(0xff0A8ED9),
//                     fontFamily: "PoppinsThin",
//                     fontSize: 12,
//                   ),),
//                 ],
//
//               ),
//             ),
//             Row(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       height: size.height*0.02, //70
//                       width: size.width*0.05,
//                       decoration: BoxDecoration(
//                         color: Colors.blue,
//                         image: DecorationImage(
//                           image: AssetImage("assets/images/img.png"),
//                           fit: BoxFit.fill,
//                         ),
//                       ),
//                     ),
//                     Text(
//                       "6 bedrooms",
//                       style: TextStyle(
//                           fontFamily: "Poppins",fontSize: 12),),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       height: size.height*0.02, //70
//                       width: size.width*0.05,
//                       decoration: BoxDecoration(
//                         color: Colors.blue,
//                         image: DecorationImage(
//                           image: AssetImage("assets/images/img.png"),
//                           fit: BoxFit.fill,
//                         ),
//                       ),
//                     ),
//                     Text("6 bedrooms",
//                       style: TextStyle(
//                         fontFamily: "Poppins",
//                         fontSize: 12,
//                       ),),
//                   ],
//                 ),
//               ],
//             ),
//             Container(
//               color: Colors.green,
//               height: size.height*0.08, //70
//               width: size.width*0.1,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

//..................................





