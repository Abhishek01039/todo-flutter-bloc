import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todolist/model/todo.dart';

class TodoServices {
  Firestore _firestore = Firestore.instance;

  getData() async {}

  Future<String> insertData(Todo todo) async {
    DocumentReference docReference = _firestore.collection("Todos").document();
    await docReference.setData({
      "title": todo.note,
      "desc": todo.task,
      "complete": false,
      "id": docReference.documentID,
    }).then((value) {
      print('hop ${docReference.documentID}');
      return docReference.documentID;
    }).catchError((e) {
      print(e);
    }).whenComplete(() {});
    return docReference.documentID;
    // print(data);
  }

  Future<void> deleteData(String id) async {
    DocumentReference docReference =
        _firestore.collection("Todos").document(id);
    await docReference.delete();
  }
}
