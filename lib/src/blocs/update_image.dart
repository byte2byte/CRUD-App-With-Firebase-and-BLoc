import 'dart:io';

import 'package:crud_firestore_bloc_app/screens/add_data.dart';
import 'package:crud_firestore_bloc_app/screens/widgets/update_details_screen.dart';
import 'package:crud_firestore_bloc_app/utilities/strings.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

final Color yellow = Color(0xfffbc31b);
final Color orange = Color(0xfffb6900);

class UpdateImage extends StatefulWidget {
  final String _emailAddress;
  final String name;
  final String number;
  final String address;
  final String avatar;
  //final String email;

  UpdateImage(
    this.name,
    this.number,
    this.address,
    this.avatar,
    this._emailAddress,
  );
  @override
  _UpdateImage createState() => _UpdateImage();
}

class _UpdateImage extends State<UpdateImage> {
  final firestoreInstance = FirebaseFirestore.instance;

  File _image;

  final picker = ImagePicker();

  Future getCamImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      _image = File(pickedFile.path);
    });
  }

  Future getGalleryImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile.path);
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        getGalleryImage();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      getCamImage();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future uploadImageToFirebase(BuildContext context) async {
    print(widget._emailAddress);
    FirebaseStorage storage = FirebaseStorage.instance;

    String fileName = basename(_image.path);
    Future<String> url;
    Reference ref = storage.ref().child("uploads/$fileName");
    UploadTask uploadTask = ref.putFile(_image);
    uploadTask.whenComplete(() async {
      var url = await ref.getDownloadURL();
      firestoreInstance
          .collection("users")
          .doc(widget._emailAddress)
          .update({"url": url}).then((_) {
        print("success!");
      });
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => UpdateDetailsScreen(widget.name,
                  widget.number, widget.address, url, widget._emailAddress)));
    }).catchError((onError) {
      print(onError);
    });
    print(url);
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 80),
            child: Column(
              children: <Widget>[
                Flexible(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "You Will be Automatically Redirected to next Page after Successful Upload",
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "*Please click on Icon below to select Image",
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: double.infinity,
                        margin: const EdgeInsets.only(
                            left: 30.0, right: 30.0, top: 10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: _image != null
                              ? Image.file(_image)
                              : FlatButton(
                                  child: Icon(
                                    Icons.add_a_photo,
                                    size: 50,
                                  ),
                                  onPressed: () {
                                    _showPicker(context);
                                  }),
                        ),
                      ),
                    ],
                  ),
                ),
                uploadImageButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget uploadImageButton(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
            margin: const EdgeInsets.only(
                top: 30, left: 20.0, right: 20.0, bottom: 20.0),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [yellow, orange],
                ),
                borderRadius: BorderRadius.circular(30.0)),
            child: FlatButton(
              onPressed: () => uploadImageToFirebase(context),
              child: Text(
                "Upload Image",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
