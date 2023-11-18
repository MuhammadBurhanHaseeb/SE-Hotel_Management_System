import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import '../bookinghistory/booking_his.dart';
import '../favorites/fav.dart';
import '../home/main_customer_home.dart';
import '../profile/profile_page.dart';

class FinalBottomNav extends StatefulWidget {
  @override
  _FinalBottomNavState createState() => _FinalBottomNavState();
}

class _FinalBottomNavState extends State<FinalBottomNav> {
  int _selectedIndex = 0;
  // static const TextStyle optionStyle =
  // TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static const List<Widget> _widgetOptions = <Widget>[
  MainCustomerHomeScreen(),
  FavouritesPage(),
  BookingHistory(),
  ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Stack(
          children: [
            _widgetOptions.elementAt(_selectedIndex),
            Positioned(
              bottom: 5,
              left: 5,
              right: 5,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                    //color: Colors.white,
                    color:Color(0xFF17203A),
                   borderRadius: BorderRadius.circular(20),
                    boxShadow:[BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 3),
                      blurRadius: 8,
                    )],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
                    child: GNav(
                      rippleColor: Colors.grey[300]!,
                      hoverColor: Colors.grey[100]!,
                      gap: 8,
                      activeColor: Colors.white,
                      iconSize: size.height*0.03,
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      duration: Duration(milliseconds: 400),
                      //tabBackgroundColor: Colors.red,
                      tabBackgroundGradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0xff0A8ED9),
                            Color(0xffA0DAFB),
                          ]
                      ),
                      color: Colors.grey,
                      tabs: [
                        GButton(
                          leading: Image(
                            image: AssetImage("assets/bottomicons/white_home.png"),
                            height: 28,
                            width: 28,
                            color: _selectedIndex == 0? Colors.white:Colors.grey,
                          ),
                          //leading: Image.asset("assets/bottomicons/white_home.png"),
                          icon: Icons.home,
                          text: 'Home',
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontFamily: "Poppins",
                          ),
                        ),
                        GButton(
                          leading: Image(
                            image: AssetImage("assets/bottomicons/white_dil.png"),
                            height: 24,
                            width: 24,
                            color: _selectedIndex == 1? Colors.white:Colors.grey,
                          ),
                          //leading: Image.asset("assets/bottomicons/white_dil.png"),
                          icon: Icons.favorite_border_outlined,
                          text: 'Fav',
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontFamily: "Poppins",
                          ),
                        ),
                        GButton(
                          leading: Image(
                              image: AssetImage("assets/bottomicons/white_booking.png"),
                            height: 24,
                            width: 24,
                            color: _selectedIndex == 2? Colors.white:Colors.grey,
                          ),
                          icon: Icons.search,
                          text: 'History',
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontFamily: "Poppins",
                          ),
                        ),
                        GButton(
                          leading: Image(
                            image: AssetImage("assets/bottomicons/white_user.png"),
                            height: 24,
                            width: 24,
                            color: _selectedIndex == 3? Colors.white:Colors.grey,
                          ),
                          icon: Icons.person,
                          text: 'Profile',
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ],
                      selectedIndex: _selectedIndex,
                      onTabChange: (index) {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        //child: _widgetOptions.elementAt(_selectedIndex),
      ),
      // bottomNavigationBar: Container(
      //   height:size.height*0.08,//70 ,
      //   decoration: BoxDecoration(
      //     color: Colors.red,
      //     // boxShadow: [
      //     //   BoxShadow(
      //     //     blurRadius: 20,
      //     //     color: Colors.black.withOpacity(.1),
      //     //   )
      //     // ],
      //   ),
      //   child: SafeArea(
      //     child: Padding(
      //       padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
      //       child: GNav(
      //         rippleColor: Colors.grey[300]!,
      //         hoverColor: Colors.grey[100]!,
      //         gap: 8,
      //         activeColor: Colors.white,
      //         iconSize: 24,
      //         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      //         duration: Duration(milliseconds: 400),
      //         //tabBackgroundColor: Colors.red,
      //         tabBackgroundGradient: LinearGradient(
      //             begin: Alignment.centerLeft,
      //             end: Alignment.centerRight,
      //             colors: [
      //               Color(0xff0A8ED9),
      //               Color(0xffA0DAFB),
      //             ]
      //         ),
      //         color: Colors.grey,
      //         tabs: [
      //           GButton(
      //             icon: Icons.home,
      //             text: 'Home',
      //           ),
      //           GButton(
      //             icon: Icons.favorite_border_outlined,
      //             text: 'Fav',
      //           ),
      //           GButton(
      //             icon: Icons.search,
      //             text: 'History',
      //           ),
      //           GButton(
      //             icon: Icons.person,
      //             text: 'Profile',
      //           ),
      //         ],
      //         selectedIndex: _selectedIndex,
      //         onTabChange: (index) {
      //           setState(() {
      //             _selectedIndex = index;
      //           });
      //         },
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}