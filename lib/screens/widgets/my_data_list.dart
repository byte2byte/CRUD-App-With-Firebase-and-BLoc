import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firestore_bloc_app/screens/widgets/user_details_screen.dart';
import 'package:crud_firestore_bloc_app/src/blocs/data_bloc.dart';
import 'package:crud_firestore_bloc_app/src/blocs/data_bloc_provider.dart';
import 'package:crud_firestore_bloc_app/utilities/strings.dart';
import 'package:flutter/material.dart';
import '../../models/data.dart';

class MyDataListScreen extends StatefulWidget {
  final String _emailAddress;

  MyDataListScreen(this._emailAddress);

  @override
  _MyDataListState createState() {
    return _MyDataListState();
  }
}

class _MyDataListState extends State<MyDataListScreen> {
  DataBloc _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = DataBlocProvider.of(context);
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0.0, 0.0),
      child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              return ListView(
                children: snapshot.data.docs.map((document) {
                  return Dismissible(
                    key: UniqueKey(),
                    onDismissed: (direction) {
                      //    _bloc.removeData(document['title'], widget._emailAddress);
                    },
                    //
                    background: Container(
                      color: Colors.red,
                    ),

                    child: GridViews(
                      cell_name: document['title'],
                      cell_avatar: document['url'],
                      cell_number: document['number'],
                      cell_address: document['address'],
                      cell_email: document['email'],
                    ),
                  );
                }).toList(),
              );
            }
          }),
    );
  }
}

class GridViews extends StatelessWidget {
  static const String screen_name = 'gridview_cell_screen';
  final cell_name;
  final cell_number;
  final cell_email;
  final cell_address;
  final cell_avatar;

  GridViews(
      {this.cell_name,
      this.cell_number,
      this.cell_email,
      this.cell_address,
      this.cell_avatar});
  @override
  Widget build(BuildContext context) {
    return Card(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        child: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                children: [
                  Hero(
                    tag: checkForNull(cell_name),
                    child: Material(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15))),
                        clipBehavior: Clip.antiAlias,
                        child: InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserDetailsScreen(
                                        cell_name,
                                        cell_number,
                                        cell_address,
                                        cell_avatar,
                                        cell_email)));
                          },
                          child: CircleAvatar(
                            radius: 54,
                            backgroundColor: Color(0xfffbcacb),
                            child: CircleAvatar(
                              radius: 50,
                              backgroundColor: Color(0xfff69c9e),
                              child: CircleAvatar(
                                radius: 47,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 45,
                                  backgroundImage: NetworkImage(cell_avatar),
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                            ),
                          ),
                        )),
                  )
                ],
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      // width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.all(2),
                      child: Text(
                        checkForNull("Name:-" + cell_name),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
//                          softWrap: true,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Number:-" + cell_number,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: new Text(
                        "Address:-" + cell_address,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                        //    maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              )
            ]));
  }
}
