import 'package:flutter/material.dart';

//not in use
class TextContainers extends StatelessWidget {
  final String image;
  final Widget textfield;
  const TextContainers({Key? key,  required this.image, required this.textfield}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        margin:  EdgeInsets.all(10.0),
        padding:  EdgeInsets.all(10.0),
        width: size.width *0.8,
        height: size.height * 0.08,
        decoration: BoxDecoration(
          color: Colors.white, // Container color
          borderRadius: BorderRadius.circular(20), // Optional: Border radius
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5), // Shadow color
              offset: Offset(0, 4), // Shadow position, x = 0, y = 4
              blurRadius: 4, // Blur radius
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment:  CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: size.width *0.02,
            ),
            Container(
              height: 25,
              width: 25,
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: size.width *0.06,
            ),
            Container(
                height: size.height * 0.08,
                width: size.width *0.6,
                child:textfield),
          ],
        ),
      ),
    );
  }
}
