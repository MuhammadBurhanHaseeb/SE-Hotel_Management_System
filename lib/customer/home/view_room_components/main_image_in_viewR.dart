import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hotel_app/nodejs_routes.dart';

class MainImageInViewRoom extends StatefulWidget {
  final String UserIdM;
  final String currentRoomId;
  final String currentRoomName;
  final String currentFloorNo;
  final String mainImage;
  const MainImageInViewRoom({
    // super.key,
    required this.currentRoomName, required this.currentFloorNo, required this.UserIdM, required this.currentRoomId, required this.mainImage,
  });

  @override
  State<MainImageInViewRoom> createState() => _MainImageInViewRoomState();
}

class _MainImageInViewRoomState extends State<MainImageInViewRoom> {

  var userCredentials;
  bool _isLoading = false;
  bool alreadyFav = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //to show loading circle while things are loading otherwise it wil show error for a short while
    _fetchFavData();
  }
  @override
  Future<void> _fetchFavData() async {
    setState(() {
      _isLoading = true; // Set loading state to true while fetching data
    });

    // data fetching
    getCredentialsFunction(widget.UserIdM);

    // Simulating a delay of 1 seconds or 0.5 sec(500 milliseconds) to fetch data
    await Future.delayed(Duration(milliseconds: 500));

    setState(() {
      // Set loading state to false after data is fetched
      _isLoading = false;
      // Updating data fields based on fetched data
      checkIfCurrentRoomInUserFav();

    });
  }
  @override
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
    print("USER CREDENTIALS IN MAIN IMAGE    " + userCredentials.toString());
  }

  void checkIfCurrentRoomInUserFav(){
    List favIds = userCredentials[0]['favorites'];
    setState(() {
      alreadyFav = favIds.contains(widget.currentRoomId);
    });
  }

  void addFavToCredentialFunction() async {
    print("FAVVVV"+widget.UserIdM+"  "+widget.currentRoomId);
    if (widget.UserIdM.isNotEmpty && widget.currentRoomId.isNotEmpty ) {
      var regBody = {
        "userId":widget.UserIdM,
        "favoritesIds":[widget.currentRoomId],
      };

      var response = await http.post(Uri.parse(addFavToCredential),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regBody));

      var jsonResponse = jsonDecode(response.body);

      print(jsonResponse);

      if (jsonResponse['status']) {
        print("ALL GOOD FAV");
      } else {
        print("SomeThing Went Wrong inadding FAV");
      }
    } else {
      print("ONE OF PARAMETERS EMPTY in FAV");
    }
  }

  void deleteFavToCredentialFunction() async {
    print("FAVVVV"+widget.UserIdM+"  "+widget.currentRoomId);
    if (widget.UserIdM.isNotEmpty && widget.currentRoomId.isNotEmpty ) {
      var regBody = {
        "userId":widget.UserIdM,
        "roomId":widget.currentRoomId,
      };

      var response = await http.post(Uri.parse(deleteFavFromCredentials),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regBody));

      var jsonResponse = jsonDecode(response.body);

      print(jsonResponse);

      if (jsonResponse['status']) {
        print("ALL GOOD FAV REMOVE");
      } else {
        print("SomeThing Went Wrong in deleting FAV");
      }
    } else {
      print("ONE OF PARAMETERS EMPTY in REMOVE FAV");
    }
  }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Stack(
        children: [
          Stack(children: [
            Container(
              height: size.height * 0.35,
              width: size.width * 1.2,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 4),
                      blurRadius: 5,
                    )
                  ],
                  image: DecorationImage(
                    image: NetworkImage(
                        widget.mainImage),
                    fit: BoxFit.fill,
                  )),
            ),
            Container(
              height: size.height * 0.35,
              width: size.width * 1.2,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.transparent,
                        Colors.black54,
                      ])),
            )
          ]),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: IconButton(
              icon: Icon(Icons.chevron_left),
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.black26)),
            ),
          ),
          Positioned(
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: IconButton(
                icon: alreadyFav?Icon(Icons.favorite_rounded):Icon(Icons.favorite_border_outlined),
                color: Colors.white,
                onPressed: () {
                  if(alreadyFav)
                    {
                      deleteFavToCredentialFunction();///delete current room from favs
                      setState(() {
                        alreadyFav = false;
                      });
                    }
                  else{
                    addFavToCredentialFunction();  /// adding thecurrent room to logined user favs
                    setState(() {
                      alreadyFav = true;
                    });
                  }
                  // alreadyFav
                  //     ?deleteFavToCredentialFunction()///delete current room from favs
                  //     :addFavToCredentialFunction();  /// adding thecurrent room to logined user favs
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.black26)),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.currentRoomName,
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Color(0xffA0DAFB),
                      ),
                      Text(
                        widget.currentFloorNo + " floor",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Poppins",
                          fontSize: 12,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}