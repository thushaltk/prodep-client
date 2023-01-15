import 'package:cloud_firestore/cloud_firestore.dart';

class ProdepvisionService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  initialise() {
    firestore = FirebaseFirestore.instance;
  }

  Future<void> saveVisionData(
      String username, String date, String emotion, String earValue) async {
    try {
      await firestore.collection('prodepvisiondb').add({
        'username': username,
        'date': date,
        'emotion': emotion,
        'earValue': earValue
      });
    } catch (error) {
      print(error);
    }
  }

  Future<List> getAllVisionData() async {
    QuerySnapshot querySnapshot;
    List<Map> docs = [];
    try {
      querySnapshot = await firestore.collection("prodepvisiondb").get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          Map temp = {
              "id": doc.id,
              "date": doc['date'],
              "username": doc['username'],
              "earValue": doc['earValue'],
              "emotion": doc['emotion']
            };
            docs.add(temp);
        }
        return docs;
      }
    } catch (error) {
      print(error);
    }
    return docs;
  }

  
}
