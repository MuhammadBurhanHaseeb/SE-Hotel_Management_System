import 'package:flutter/material.dart';

class SearchOption extends StatelessWidget {
  final VoidCallback press;
  const SearchOption({
    super.key, required this.press,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 20 , right: 20, bottom: 20),
      child: Stack(
        children: [
          SizedBox(
          height: size.height*0.07,
          child: TextField(
            style: TextStyle(
              fontFamily: "Poppins",
            ),
            decoration: InputDecoration(
              hintText: "Search",
              filled: true,
              fillColor: Color(0xffF7F7F7),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
          Positioned(
            right: 5,
            top: 7,
            child: SizedBox(
              height: size.height * 0.05, //50
              width: size.width*0.1,
              child: TextButton(
                onPressed: press,
                child: Image(
                  image:
                  AssetImage("assets/images/searchfinal.png"),
                  height: 24,
                  width: 24,
                ),
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(0.0)),
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF17203A)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}