import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';


import '../bookinghistory/booking_his.dart';
import '../favorites/fav.dart';
import '../home/main_customer_home.dart';
import '../profile/profile_page.dart';

//not in use
// also add app bar to it only body will change bottom/appbar will remain same
class AppBarCurvedBottom extends StatefulWidget {
  const AppBarCurvedBottom({
    Key? key,
  }) : super(key: key);

  @override
  State<AppBarCurvedBottom> createState() => _AppBarCurvedBottomState();
}

class _AppBarCurvedBottomState extends State<AppBarCurvedBottom> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      bottomNavigationBar: CurvedNavigationBar(
          height: size.height *0.062,
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: Color(0xffF7F7F7),
          color: Color(0xffF7F7F7),
          animationDuration: Duration(milliseconds: 300),
          onTap: (selectedIndex) {
            setState(() {
              index = selectedIndex;
            });
          },
          items: [
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Image.asset(
                "assets/bottombaricons/home.png",
                height: size.height * 0.06,
                width: size.width * 0.06,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Image.asset("assets/bottombaricons/favourite.png",
                height: size.height * 0.06,
                width: size.width * 0.06,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Image.asset("assets/bottombaricons/history.png",
                height: size.height * 0.06,
                width: size.width * 0.06,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Image.asset("assets/bottombaricons/account.png",
                height: size.height * 0.06,
                width: size.width * 0.06,
              ),
            ),
          ]
      ),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          child: getSelectedPage(index: index)),
    );
  }


//................................navigating btw pages....................//

  Widget getSelectedPage({required int index}) {
    Widget page;
    switch (index) {
      case 0:
        page = MainCustomerHomeScreen();
        break;
      case 1:
        page = FavouritesPage();
        break;
      case 2:
        page = BookingHistory();
        break;
      case 3:
        page = ProfilePage(UserIdp: "12345",);
        break;
      default:
        page = MainCustomerHomeScreen();
        break;
    }
    return page;
  }
}


