import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firestore_bloc_app/src/blocs/data_bloc.dart';
import 'package:flutter/material.dart';
import 'package:crud_firestore_bloc_app/src/blocs/data_bloc_provider.dart';
import 'package:crud_firestore_bloc_app/src/blocs/upload_image_to_firebase.dart';
import 'package:image_picker/image_picker.dart';

class AddDataScreen extends StatefulWidget {
  final String _emailAddress;

  AddDataScreen(this._emailAddress);

  @override
  AddDataState createState() {
    return AddDataState();
  }
}

class AddDataState extends State<AddDataScreen> {
  final firestoreInstance = FirebaseFirestore.instance;

  DataBloc _bloc;
  TextEditingController myController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = DataBlocProvider.of(context);
  }

  @override
  void dispose() {
    myController.dispose();
    _bloc.dispose();
    super.dispose();
  }

  //Handing back press
  Future<bool> _onWillPop() {
    Navigator.pop(context, false);
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Add Data",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.grey,
          elevation: 0.0,
        ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          alignment: Alignment(0.0, 0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              nameField(),
              Container(margin: EdgeInsets.only(top: 5.0, bottom: 5.0)),
              numberField(),
              Container(margin: EdgeInsets.only(top: 5.0, bottom: 5.0)),
              datafield(),
              Container(margin: EdgeInsets.only(top: 5.0, bottom: 5.0)),
              buttons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget nameField() {
    return StreamBuilder(
        stream: _bloc.name,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          return TextField(
            onChanged: _bloc.changeName,
            decoration: InputDecoration(
                hintText: "Enter name", errorText: snapshot.error),
          );
        });
  }

  Widget numberField() {
    return StreamBuilder(
        stream: _bloc.number,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          return TextField(
            onChanged: _bloc.changeNumber,
            decoration: InputDecoration(
                hintText: "Enter Number", errorText: snapshot.error),
          );
        });
  }

  Widget datafield() {
    return StreamBuilder(
        stream: _bloc.addr,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          myController.value = myController.value.copyWith(text: snapshot.data);
          return TextField(
            controller: myController,
            keyboardType: TextInputType.multiline,
            maxLines: 3,
            onChanged: _bloc.changeaddr,
            decoration: InputDecoration(
                hintText: "Enter your Address here", errorText: snapshot.error),
          );
        });
  }

  Widget buttons() {
    return StreamBuilder(
        stream: _bloc.showProgress,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                submitButton(),
                Container(margin: EdgeInsets.only(left: 5.0, right: 5.0)),
                // scanButton(),
              ],
            );
          } else {
            if (!snapshot.data) {
              //hide progress bar
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  submitButton(),
                  Container(margin: EdgeInsets.only(left: 5.0, right: 5.0)),
                  //  scanButton(),
                ],
              );
            } else {
              return CircularProgressIndicator();
            }
          }
        });
  }

  Widget submitButton() {
    return RaisedButton(
        textColor: Colors.white,
        color: Colors.grey,
        child: Text("Submit"),
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)),
        onPressed: () {
          _bloc.submit(widget._emailAddress);
          Navigator.of(context).pop();
        });
  }
}
