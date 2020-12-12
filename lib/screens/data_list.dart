import 'package:crud_firestore_bloc_app/screens/add_data.dart';
import 'package:crud_firestore_bloc_app/src/blocs/upload_image_to_firebase.dart';
import 'package:crud_firestore_bloc_app/utilities/strings.dart';
import 'package:flutter/material.dart';
import 'widgets/my_data_list.dart';

class DataList extends StatefulWidget {
  final String _emailAddress;

  DataList(this._emailAddress);

  @override
  DataListState createState() {
    return DataListState();
  }
}

class DataListState extends State<DataList>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Data List",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.grey,
        elevation: 0.0,
      ),
      body: MyDataListScreen(widget._emailAddress),
      floatingActionButton: _bottomButtons(),
    );
  }

  Widget _bottomButtons() {
    if (true) {
      return FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        UploadingImageToFirebaseStorage(widget._emailAddress)));
          });
    }
  }
}
