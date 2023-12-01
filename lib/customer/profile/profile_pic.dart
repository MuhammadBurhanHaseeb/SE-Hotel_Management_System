import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:hotel_app/nodejs_routes.dart';

class CircleProfilePicture extends StatefulWidget {
  final String UserId;
  final String UserPicPath;
  const CircleProfilePicture({
    super.key, required this.UserId, required this.UserPicPath,
  });

  @override
  State<CircleProfilePicture> createState() => _CircleProfilePictureState();
}

class _CircleProfilePictureState extends State<CircleProfilePicture> {
  final controller = TextEditingController();
  int gvalue = 0;
  File? _imgFile;
  final ImagePicker _picker = ImagePicker();
  String? imageUrl; // Image URL fetched from the backend

  @override
  void initState() {
    super.initState();
    String imageURLForFlutter = widget.UserPicPath.replaceAll(r'\', '/');
    setState(() {
      imageUrl = url+ imageURLForFlutter;
    });
    print(imageUrl);
  }

  void storeImage(File imageFile, String userId) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(addProfilePic),
    );

    request.fields['userId'] = userId; // Add userId as a field in the request

    // Attaching the image file to the request
    request.files.add(
      await http.MultipartFile.fromPath('profilePicture', imageFile.path),
    );

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        print('Image uploaded successfully');
      } else {
        print('Failed to upload image');
      }
    } catch (error) {
      print('Error uploading image: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        CircleAvatar(
          radius: size.height * 0.08,
          backgroundImage: _imgFile == null
          /// if user doesn't select image from camera or gallery Display the image using imageUrl and if there is no image
          /// in backend show the dummy image from assets
            ?(imageUrl != null ? NetworkImage(imageUrl!) as ImageProvider: AssetImage("assets/images/noimageuser.png"))
          /// But if user select image from camera or gallery show that image
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
                icon: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                ),
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
                icon: Icon(
                  Icons.image,
                  color: Colors.white,
                ),
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
    storeImage(_imgFile!,widget.UserId);
  }
}
