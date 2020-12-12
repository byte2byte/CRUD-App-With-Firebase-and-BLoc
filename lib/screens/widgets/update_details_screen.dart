import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firestore_bloc_app/src/app.dart';
import 'package:crud_firestore_bloc_app/src/blocs/update_image.dart';
import 'package:flutter/material.dart';

import '../data_list.dart';

class UpdateDetailsScreen extends StatefulWidget {
  final String name;
  final String number;
  final String address;
  final String avatar;
  final String email;

  UpdateDetailsScreen(
      this.name, this.number, this.address, this.avatar, this.email);
  @override
  _UpdateDetailsScreenState createState() => _UpdateDetailsScreenState();
}

class _UpdateDetailsScreenState extends State<UpdateDetailsScreen> {
  final firestoreInstance = FirebaseFirestore.instance;

  TextEditingController nameController = TextEditingController();

  TextEditingController numberController = TextEditingController();

  TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = widget.name;
    numberController.text = widget.number;
    addressController.text = widget.address;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Details"),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DataList(widget.email)));
            }),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UpdateImage(
                            widget.name,
                            widget.number,
                            widget.address,
                            widget.avatar,
                            widget.email)));
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                clipBehavior: Clip.hardEdge,
                child: Image.network(
                  widget.avatar,
                  fit: BoxFit.fitHeight,
                  height: MediaQuery.of(context).size.height * .30,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                  hintText: 'Enter Your Name',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                controller: numberController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Number',
                  hintText: 'Enter Your Number',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                controller: addressController,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Address',
                  hintText: 'Enter Your Address',
                ),
              ),
            ),
            Center(
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width / 2.2,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(30.0)),
                child: FlatButton(
                  onPressed: () => {
                    firestoreInstance
                        .collection("users")
                        .doc(widget.email)
                        .update({
                      "title": nameController.text,
                      "number": numberController.text,
                      "address": addressController.text
                    }).then((_) {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => MyApp()));
                      print("success!");
                      print("success!");
                    })
                  },
                  child: Text(
                    "Update Details",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
