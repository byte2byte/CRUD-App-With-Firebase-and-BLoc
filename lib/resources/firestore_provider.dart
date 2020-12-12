import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firestore_bloc_app/utilities/strings.dart';

class FirestoreProvider {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final firestoreInstance = FirebaseFirestore.instance;

  Future<int> authenticateUser(String email, String password) async {
    final QuerySnapshot result = await _firestore
        .collection("users")
        .where("email", isEqualTo: email)
        .get();
    final List<DocumentSnapshot> docs = result.docs;
    if (docs.length == 0) {
      return 0;
    } else {
      return 1;
    }
  }

  Future<void> registerUser(String email, String password) async {
    return _firestore.collection("users").doc(email).set({
      'email': email,
      'password': password,
      'dataAdded': false,
      'title': email,
      'url': GlobalData.URL,
      'number': '+919546784125',
      'address': "Default Address"
    });
  }

  Future<void> uploadData(
      String title, String documentId, String data, String number) async {
    return firestoreInstance.collection("users").doc(documentId).set({
      "title": title,
      "url": GlobalData.URL,
      "number": number,
      "address": data,
      "email": documentId,
    });
  }

  Stream<DocumentSnapshot> myDataList(String documentId) {
    return _firestore.collection("users").doc(documentId).snapshots();
  }

  Future<void> removeData(String title, String documentId) async {
    await firestoreInstance.collection("users").doc(documentId).delete();
    print("Sucessfully Deleted");
  }
}
