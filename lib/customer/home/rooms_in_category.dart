import 'package:flutter/material.dart';

import '../currentroom.dart';
import '../customerBL/housesBL.dart';
import 'view_room_components/view_room.dart';

class RoomsInCategory extends StatefulWidget {
  final bool isInFavScreen;
  final Color buttonbackColor;
  final Widget icon_req;
  final List rooms;
  const RoomsInCategory({Key? key, required this.rooms, required this.icon_req, required this.buttonbackColor, required this.isInFavScreen}) : super(key: key);

  @override
  State<RoomsInCategory> createState() => _RoomsInCategoryState();
}

class _RoomsInCategoryState extends State<RoomsInCategory> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(20),
      child: ListView.builder(
        //...increase list size according to the list length
        physics: NeverScrollableScrollPhysics(), // Disable scrolling for the ListView
        shrinkWrap: true,
        //...
        itemCount: widget.rooms.length,
        itemBuilder: (context, index) {
          // Get the current house.
          final currentRoom = widget.rooms[index];

          // Return a list item for the house.
          return Stack(
            children: [
              ListTile(
                //tileColor:Colors.yellow ,
                leading: Container(
                  //padding: EdgeInsets.only(left: 5),
                  height: size.height * 0.08, //70
                  width: size.width * 0.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 3),
                        blurRadius: 8,
                      ),
                    ],
                    image: DecorationImage(
                      image:
                          AssetImage("assets/images/standardroom_1878.jpg"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                title: Text(
                  currentRoom['roomName'].toString(),
                  style: TextStyle(
                    fontFamily: "Poppins",
                    color: Color(0xFF17203A),
                    //fontSize: 16,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.height * 0.003,
                    ),
                    Text(
                      '\$${currentRoom['price'].toString()} / day',
                      style: TextStyle(
                        color: Color(0xff0A8ED9),
                        fontFamily: "PoppinsThin",
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.003,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.hotel,
                          size: size.height * 0.025,
                          color: Colors.grey,
                        ),
                        Text(
                          '${currentRoom['beds'].toString()} Bedroom',
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: "PoppinsThin",
                            //color: Colors.grey,
                          ),
                        ),
                        Icon(
                          Icons.shower,
                          size: size.height * 0.025,
                          color: Colors.grey,
                        ),
                        Text(
                          '${currentRoom['bathrooms'].toString()} Bathroom',
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: "PoppinsThin",
                            //color: Colors.grey,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                //trailing: Icon(Icons.ice_skating),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: SizedBox(
                  height: size.height * 0.035, //20
                  width: size.width*0.07,
                  child: IconButton(
                    onPressed: (){
                      if(widget.isInFavScreen)
                        {
                          //remove current house from the fav list
                          print("remove current house from the fav list");
                        }
                      else {
                        currentOrderGloabl.name = currentRoom['roomName'].toString();
                        currentOrderGloabl.price = currentRoom['price'];
                        currentOrderGloabl.bedrooms = currentRoom['beds'];
                        currentOrderGloabl.bathrooms = currentRoom['bathrooms'];
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) =>
                                ViewRoomPage(
                                  currentRoom: currentRoom,
                                )
                        ));
                      }
                    },
                    icon:widget.icon_req,
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(0.0)),
                      backgroundColor: MaterialStateProperty.all<Color>(widget.buttonbackColor),
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
