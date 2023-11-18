import 'package:flutter/material.dart';

import 'profile_pic.dart';

class ProfileFirstInfo extends StatelessWidget {
  const ProfileFirstInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Center(
        child: Column(
          children: [
            CircleProfilePicture(),
            Padding(
              padding: const EdgeInsets.only(top: 14.0),
              child: Text(
                "Louis Pastridge",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6.0),
              child: Text(
                "LouisPastridge123@gmail.com",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}