import 'package:flutter/material.dart';

import 'available_options.dart';
import 'edit_pro_page.dart';
import 'name_etc.dart';
import 'payment.dart';
import 'profile_pic.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      child: Column(
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
          ProfileFirstInfo(),
          SizedBox(
            height: size.height*0.037,
          ),
          Options(
            iconn:  Icon(Icons.person_outline),
            optionText: "Edit Profile",
              textColor:Colors.black,
            press: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfilePage()));
            },
          ),
          Options(
            iconn:  Icon(Icons.payment),
            optionText: "Payment",
            textColor:Colors.black,
            press: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentMethodPage(
                isnewBookingPage: false,
              )));
            },
          ),
          Options(
            iconn:  Icon(Icons.security),
            optionText: "Security",
            textColor:Colors.black,
            press: (){},
          ),
          Options(
            iconn:  Icon(Icons.help),
            optionText: "Help",
            textColor:Colors.black,
            press: (){},
          ),
          Options(
            iconn:  Icon(Icons.logout,color: Colors.red,),
            optionText: "LogOut",
            textColor:Colors.red,
            press: (){},
          ),
        ],
      ),
    );
  }
}


