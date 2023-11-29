import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;
import 'package:hotel_app/nodejs_routes.dart';
import 'dart:convert';


Map<String, IconData> iconDataMapping = {
  'wifi': Icons.wifi,
  "pool": Icons.pool,
  "cleaning_services": Icons.cleaning_services,
  "tv": Icons.tv,
  "chair_outlined": Icons.chair_outlined,
  "iron": Icons.iron,
  // Add other icon names and their corresponding IconData here
};
class FacilitiesBlock extends StatefulWidget {
  final List faclitiesIds;
  const FacilitiesBlock({
    super.key,
    required this.size, required this.faclitiesIds,
  });

  final Size size;

  @override
  State<FacilitiesBlock> createState() => _FacilitiesBlockState();
}

class _FacilitiesBlockState extends State<FacilitiesBlock> {

  List facilitiesContent = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFacilitiesContentFunction();
  }

  // @override
  void getFacilitiesContentFunction() async {
    List hehe = widget.faclitiesIds;
    for(int i=0 ; i<hehe.length ; i++) {
      var facId=hehe[i];
      var response = await http.get(
        Uri.parse('$getfacilitiesInfoById?id=$facId'),
        headers: {"Content-Type": "application/json"},
      );
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      setState(() {
        facilitiesContent = jsonResponse['success'];
      });
    }
  }
  Widget build(BuildContext context) {
    print("FACILITIES"+"${widget.faclitiesIds}");
    return Container(
      width: widget.size.width,
      child: GridView.builder(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        physics:
            NeverScrollableScrollPhysics(), // Disable scrolling for the ListView
        shrinkWrap: true,
        itemCount: facilitiesContent.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) {
          final currenFacility = facilitiesContent[index];
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
                      iconDataMapping[currenFacility['facilityIcon']],
                      color: Color(0xFF17203A),
                    )),
                Text(
                  currenFacility['facilityName'].toString(),
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
