import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firestore_bloc_app/screens/data_list.dart';
import 'package:crud_firestore_bloc_app/screens/widgets/my_data_list.dart';
import 'package:crud_firestore_bloc_app/screens/widgets/update_details_screen.dart';
import 'package:crud_firestore_bloc_app/src/app.dart';
import 'package:crud_firestore_bloc_app/src/blocs/data_bloc_provider.dart';
import 'package:flutter/material.dart';

class UserDetailsScreen extends StatefulWidget {
  final String name;
  final String number;
  final String address;
  final String avatar;
  final String email;

  UserDetailsScreen(
      this.name, this.number, this.address, this.avatar, this.email);

  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final firestoreInstance = FirebaseFirestore.instance;

  DataBloc _bloc;

  // @override
  // void dispose() {
  //   _bloc.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DataList(widget.email)));
            }),
        title: Text(
          "User Details",
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          //    crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
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
            Container(
              padding: EdgeInsets.fromLTRB(20, 15, 0, 5),
              child: Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Name:- ",
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Text(
                    widget.name,
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 5),
              child: Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Number:- ",
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Text(
                    widget.number,
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),

            // padding: EdgeInsets.fromLTRB(20, 0, 0, 5),

            Container(
              child: Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Address:- ",
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Flexible(
                    child: new Container(
                      child: new Text(
                        widget.address,
                        overflow: TextOverflow.visible,
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width / 2.2,
                  // padding:
                  //     const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
                  // margin: const EdgeInsets.only(
                  //     top: 30, left: 20.0, right: 20.0, bottom: 20.0),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(30.0)),
                  child: FlatButton(
                    onPressed: () => {
                      print(widget.email),
                      firestoreInstance
                          .collection("users")
                          .doc(widget.email)
                          .delete()
                          .then((_) {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => MyApp()));
                        print("success!");
                      })
                      //   _bloc.removeData(widget.name, widget.email)
                    },
                    child: Text(
                      "Delete User",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width / 2.2,
                  // padding:
                  //     const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
                  // margin: const EdgeInsets.only(
                  //     top: 30, left: 20.0, right: 20.0, bottom: 20.0),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(30.0)),
                  child: FlatButton(
                    onPressed: () => {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UpdateDetailsScreen(
                                  widget.name,
                                  widget.number,
                                  widget.address,
                                  widget.avatar,
                                  widget.email)))
                    },
                    child: Text(
                      "Update Details",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
