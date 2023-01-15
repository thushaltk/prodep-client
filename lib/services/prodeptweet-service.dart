import 'package:cloud_firestore/cloud_firestore.dart';

class ProdepTweetService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  initialise() {
    firestore = FirebaseFirestore.instance;
  }

  Future<void> saveTweetData(
      String username, String date, String sentimentValue) async {
    try {
      await firestore.collection('prodeptweetdb').add({
        'username': username,
        'date': date,
        'sentimentValue': sentimentValue
      });
    } catch (error) {
      print(error);
    }
  }

  Future<List> getAllTweetData() async {
    QuerySnapshot querySnapshot;
    List<Map> docs = [];
    try {
      querySnapshot = await firestore.collection("prodeptweetdb").get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          Map temp = {
              "id": doc.id,
              "date": doc['date'],
              "username": doc['username'],
              "sentimentValue": doc['sentimentValue']
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
