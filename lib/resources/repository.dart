import 'package:cloud_firestore/cloud_firestore.dart';

import 'firestore_provider.dart';

class Repository {
  final _firestoreProvider = FirestoreProvider();
  //final _mlkitProvider = MLkitProvider();

  Future<int> authenticateUser(String email, String password) =>
      _firestoreProvider.authenticateUser(email, password);

  Future<void> registerUser(String email, String password) =>
      _firestoreProvider.registerUser(email, password);

  Future<void> uploadData(
          String email, String title, String data, String number) =>
      _firestoreProvider.uploadData(title, email, data, number);

  Stream<DocumentSnapshot> myDataList(String email) =>
      _firestoreProvider.myDataList(email);

  void removeData(String title, email) =>
      _firestoreProvider.removeData(title, email);
}
