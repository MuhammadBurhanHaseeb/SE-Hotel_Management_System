//import 'dart:html';

import 'package:flutter/material.dart';

import '../home/rooms_in_category.dart';
import '../customerBL/housesBL.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hotel_app/nodejs_routes.dart';

class FavouritesPage extends StatefulWidget {
  final String UserId;
  const FavouritesPage({Key? key, required this.UserId,}) : super(key: key);

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  List rooms = [];
  bool _isLoading = false;
  var userCredentials;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //to show loading circle while things are loading otherwise it wil show error for a short while
    _fetchFavData();
    // getFavRoomsByIdsFunction(widget.UserCredentials[0]["_id"],widget.UserCredentials[0]['favorites']);
  }

  @override
  Future<void> _fetchFavData() async {
    setState(() {
      _isLoading = true; // Set loading state to true while fetching data
    });

    // data fetching
    getCredentialsFunction(widget.UserId);

    // Simulating a delay of 1 seconds or 0.5 sec(500 milliseconds) to fetch data
    await Future.delayed(Duration(milliseconds: 500));

    setState(() {
      // Set loading state to false after data is fetched
      _isLoading = false;
      // Updating data fields based on fetched data

    });
  }

  void getCredentialsFunction(userId) async {
    var response = await http.get(
      Uri.parse('$getCredentialss?userId=$userId'),
      headers: {"Content-Type": "application/json"},
    );
    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse);
    setState(() {
      userCredentials = jsonResponse['success'];
    });
    print("profile    " + userCredentials.toString());
    getFavRoomsByIdsFunction(userCredentials[0]['favorites']);
  }

  void getFavRoomsByIdsFunction(favids) async {
    List<dynamic> allFavContent = [];
    List hehe = favids;
    print("HEHE : "+ hehe.toString());
    for(int i=0 ; i<hehe.length ; i++) {
      var favId=hehe[i];
      var response = await http.get(
        Uri.parse('$getaroombyid?id=$favId'),
        headers: {"Content-Type": "application/json"},
      );
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      allFavContent.add(jsonResponse['success']);
      setState(() {
        rooms = allFavContent;
      });
      print("rooms: " +rooms.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.07,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
                // yay IconButton ki jagan app ka logo lagana hai yahan
                // IconButton(
                //   onPressed: () {},
                //   icon: Icon(Icons.chevron_left),
                //   style: ButtonStyle(
                //     //shape: MaterialStateProperty.all<OutlinedBorder>(OutlinedBorder()),
                //   ),
                // ),
                // SizedBox(
                //   width: size.width*0.14,
                // ),
                Text(
                  "My Favorites",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF17203A),
                  ),
                ),
            //   ],
            // ),
            // SizedBox(
            //   height: size.height * 0.06,
            // ),

            _isLoading
                ? Center(
              child:
              CircularProgressIndicator(
                color: Colors.grey,
              ), // Showing circular progress indicator while loading
            )
                :
            RoomsInCategory(
              isInFavScreen: true,
              buttonbackColor: Color(0xFF17203A),
              icon_req: ImageIcon(
                AssetImage("assets/images/filledheart.png"),
                color: Colors.white,
                size: size.height * 0.02,//10
              ),
              rooms: rooms!,
              //icon
            ),

            /// added this because while loading and if the rooms are less in
            /// no then the screen becomes short bcz of singleChildscrollview
            Container(
              //color: Colors.red,
              height: 700,
            )
          ],
        ),
      ),
    );
  }
}
