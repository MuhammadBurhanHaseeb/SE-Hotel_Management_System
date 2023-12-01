import 'package:flutter/material.dart';

import 'profile_pic.dart';

class ProfileFirstInfo extends StatelessWidget {
  final String userName;
  final String userEmail;
  const ProfileFirstInfo({
    super.key, required this.userName, required this.userEmail,
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
                userName,
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
                userEmail,
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