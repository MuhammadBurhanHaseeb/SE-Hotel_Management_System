//import 'dart:html';

import 'package:flutter/material.dart';

import '../home/rooms_in_category.dart';
import '../customerBL/housesBL.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.07,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
                // yay IconButton ki jagan app ka logo lagana hai yahan
                // IconButton(
                //   onPressed: () {},
                //   icon: Icon(Icons.chevron_left),
                //   style: ButtonStyle(
                //     //shape: MaterialStateProperty.all<OutlinedBorder>(OutlinedBorder()),
                //   ),
                // ),
                // SizedBox(
                //   width: size.width*0.14,
                // ),
                Text(
                  "My Favorites",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF17203A),
                  ),
                ),
            //   ],
            // ),
            // SizedBox(
            //   height: size.height * 0.06,
            // ),
            RoomsInCategory(
              isInFavScreen: true,
              buttonbackColor: Color(0xFF17203A),
              icon_req: ImageIcon(
                AssetImage("assets/images/filledheart.png"),
                color: Colors.white,
                size: size.height * 0.02,//10
              ),
              houses: [
                HouseTrailers(
                    name: 'Orchad House',
                    price: 2500000000,
                    bedrooms: 6,
                    bathrooms: 4,size: 4000),
                HouseTrailers(
                    name: 'Orchad House',
                    price: 2500000000,
                    bedrooms: 6,
                    bathrooms: 4,size: 4000),
                HouseTrailers(
                    name: 'Orchad House',
                    price: 2500000000,
                    bedrooms: 6,
                    bathrooms: 4,size: 4000),
                HouseTrailers(
                    name: 'Orchad House',
                    price: 2500000000,
                    bedrooms: 6,
                    bathrooms: 4,size: 4000),
                HouseTrailers(
                    name: 'Orchad House',
                    price: 2500000000,
                    bedrooms: 6,
                    bathrooms: 4,size: 4000),
                HouseTrailers(
                    name: 'Orchad House',
                    price: 2500000000,
                    bedrooms: 6,
                    bathrooms: 4,size: 4000),
                HouseTrailers(
                    name: 'Orchad House',
                    price: 2500000000,
                    bedrooms: 6,
                    bathrooms: 4,size: 4000),
                HouseTrailers(
                    name: 'Orchad House',
                    price: 2500000000,
                    bedrooms: 6,
                    bathrooms: 4,size: 4000),
                HouseTrailers(
                    name: 'Orchad House',
                    price: 2500000000,
                    bedrooms: 6,
                    bathrooms: 4,size: 4000),
                HouseTrailers(
                    name: 'Orchad House',
                    price: 2500000000,
                    bedrooms: 6,
                    bathrooms: 4,size: 4000),
                HouseTrailers(
                    name: 'Orchad House',
                    price: 2500000000,
                    bedrooms: 6,
                    bathrooms: 4,size: 4000),
                HouseTrailers(
                    name: 'Orchad House',
                    price: 2500000000,
                    bedrooms: 6,
                    bathrooms: 4,size: 4000),

                HouseTrailers(
                    name: 'House', price: 2500000000, bedrooms: 6, bathrooms: 4,size: 4000),
                HouseTrailers(
                    name: 'The Hollies House',
                    price: 2000000000,
                    bedrooms: 5,
                    bathrooms: 2,size: 4000),
              ],
              //icon
            ),
          ],
        ),
      ),
    );
  }
}
