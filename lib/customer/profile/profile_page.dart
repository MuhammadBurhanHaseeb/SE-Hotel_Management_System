import 'package:flutter/material.dart';

import 'available_options.dart';
import 'edit_pro_page.dart';
import 'name_etc.dart';
import 'payment.dart';
import 'profile_pic.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hotel_app/nodejs_routes.dart';

class ProfilePage extends StatefulWidget {
  final String UserIdp;
  const ProfilePage({Key? key, required this.UserIdp}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var userCredentials;
  var user;
  bool _isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    setState(() {
      _isLoading = true; // Set loading state to true while fetching data
    });

    // data fetching
    getCredentialsFunction(widget.UserIdp);
    getUserByIdFunction(widget.UserIdp);
    // Simulating a delay of 1 seconds or 0.5 sec(500 milliseconds) to fetch data
    await Future.delayed(Duration(milliseconds: 500));

    setState(() {
      // Set loading state to false after data is fetched
      _isLoading = false;
      // Update user data fields based on fetched data
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
  }

  void getUserByIdFunction(id) async {
    print("ID" + id);
    var reqBody = {
      "id": id,
    };
    var response = await http.post(Uri.parse(getUserById),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody));
    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse);
    setState(() {
      user = jsonResponse['success'];
    });
    print("main Info    " + user.toString());
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      child:
          _isLoading
              ? Center(
                  child:
                      CircularProgressIndicator(
                        color: Colors.grey,
                      ), // Showing circular progress indicator while loading
                )
              : Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.07,
                    ),
                    // Row(
                    //   children: [
                    //     // yay IconButton ki jagan app ka logo lagana hai yahan
                    //     IconButton(
                    //       onPressed: () {},
                    //       icon: Icon(Icons.chevron_left),
                    //     ),
                    Text(
                      "My Profile",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF17203A),
                      ),
                    ),
                    //   ],
                    // ),
                    ProfileFirstInfo(
                      userEmail: user != null ? user['email'].toString() : '',
                      userName: userCredentials != null
                          ? userCredentials[0]['fullName'].toString()
                          : '',
                      userId: widget.UserIdp,
                      userPicture:
                          userCredentials[0]['profilePicture'].toString(),
                    ),
                    SizedBox(
                      height: size.height * 0.037,
                    ),
                    Options(
                      iconn: Icon(Icons.person_outline),
                      optionText: "Edit Profile",
                      textColor: Colors.black,
                      press: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditProfilePage(
                                      User: user,
                                      UserCredentials: userCredentials,
                                    )));
                      },
                    ),
                    Options(
                      iconn: Icon(Icons.payment),
                      optionText: "Payment",
                      textColor: Colors.black,
                      press: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PaymentMethodPage(
                                  UserIdP: user['_id'].toString(),
                                      isnewBookingPage: false,
                                    )));
                      },
                    ),
                    Options(
                      iconn: Icon(Icons.security),
                      optionText: "Security",
                      textColor: Colors.black,
                      press: () {},
                    ),
                    Options(
                      iconn: Icon(Icons.help),
                      optionText: "Help",
                      textColor: Colors.black,
                      press: () {},
                    ),
                    Options(
                      iconn: Icon(
                        Icons.logout,
                        color: Colors.red,
                      ),
                      optionText: "LogOut",
                      textColor: Colors.red,
                      press: () {},
                    ),
                  ],
                ),
    );
  }
}
