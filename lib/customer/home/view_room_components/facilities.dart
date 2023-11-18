import 'package:flutter/material.dart';

import '../../customerBL/facilityBL.dart';


class FacilitiesBlock extends StatelessWidget {
  const FacilitiesBlock({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      child: GridView.builder(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        physics:
            NeverScrollableScrollPhysics(), // Disable scrolling for the ListView
        shrinkWrap: true,
        itemCount: faclitiesList.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) {
          final currenFacility = faclitiesList[index];
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Color(0xffe6f1f7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      currenFacility.icon,
                      color: Color(0xFF17203A),
                    )),
                Text(
                  currenFacility.name,
                  style: TextStyle(
                    fontFamily: "Poppins",
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
