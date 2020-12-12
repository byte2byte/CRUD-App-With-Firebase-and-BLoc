import 'package:crud_firestore_bloc_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'blocs/data_bloc.dart';
import 'blocs/data_bloc_provider.dart';
import 'blocs/login_bloc_provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoginBlocProvider(
      child: DataBlocProvider(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            accentColor: Colors.white,
            primaryColor: Colors.grey,
          ),
          home: Scaffold(
            appBar: AppBar(
              title: Text(
                "CRUD- FireStore with BLoc Pattern",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.grey,
              elevation: 0.0,
            ),
            body: LoginScreen(),
          ),
        ),
      ),
    );
  }
}
