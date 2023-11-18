import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';

class CircleProfilePicture extends StatefulWidget {
  const CircleProfilePicture({
    super.key,
  });

  @override
  State<CircleProfilePicture> createState() => _CircleProfilePictureState();
}

class _CircleProfilePictureState extends State<CircleProfilePicture> {
  final controller = TextEditingController();
  int gvalue = 0;
  File? _imgFile;
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        CircleAvatar(
          radius: size.height * 0.08,
          backgroundImage: _imgFile == null
              ? AssetImage("assets/images/noimageuser.png")
              : FileImage(File(_imgFile!.path)) as ImageProvider,
        ),
        Positioned(
          bottom: 0,
          right: 5,
          child: Container(
            height: size.height * 0.039, //29
            width: size.height * 0.039,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
                bottomLeft:
                    Radius.circular(0.0), // No radius for the bottom left
              ),
              color: Color(0xffA0DAFB), // Background color
            ),
            child: GestureDetector(
              onTap: () {
                // Handle button tap here
                //open bottom popup with camera, gallery option
                showModalBottomSheet(
                  context: context,
                  builder: ((builder) => bottomSheet()),
                );
              },
              child: Icon(
                Icons.edit,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(children: <Widget>[
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ElevatedButton.icon(
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Color(0xFF17203A))),
                icon: Icon(Icons.camera_alt,color: Colors.white,),
                label: Text(
                  "Camera",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    color: Colors.white,
                  ),
                )),
            ElevatedButton.icon(
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Color(0xFF17203A))),
                icon: Icon(Icons.image,color: Colors.white,),
                label: Text(
                  "Gallery",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    color: Colors.white,
                  ),
                )),
          ],
        )
      ]),
    );
  }

  void takePhoto(ImageSource source) async {
    final ifile = await _picker.pickImage(
      source: source,
    );
    if (ifile == null) {
      print("khali");
      return;
    }
    final temp = File(ifile.path);
    setState(() {
      _imgFile = temp;
    });
  }
}
