import 'package:flutter/material.dart';

class DetailsBlock extends StatelessWidget {
  const DetailsBlock({
    super.key,
    required this.bedrooms,
    required this.bathrooms,
    required this.roomSize,
  });

  final int bedrooms;
  final int bathrooms;
  final int roomSize;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.1,
      // width: 100,
      decoration: BoxDecoration(
        color: Color(0xffe6f1f7),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                "assets/images/double-bed.png",
                height: 20,
                width: 20,
                color: Color(0xFF17203A),
              ),
              Text('$bedrooms Bedrooms',
                  style: TextStyle(fontFamily: "Poppins"))
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                "assets/images/bath.png",
                height: 20,
                width: 20,
                color: Color(0xFF17203A),
              ),
              Text('$bathrooms Baths', style: TextStyle(fontFamily: "Poppins"))
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                "assets/images/ruler.png",
                height: 20,
                width: 20,
                color: Color(0xFF17203A),
              ),
              Text(
                '$roomSize sqft',
                style: TextStyle(fontFamily: "Poppins"),
              )
            ],
          ),
        ],
      ),
    );
  }
}