import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddDataPage extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addData() async {
    try {
      await firestore.collection('testCollection').add({
        'name': 'John Doe',
        'timestamp': FieldValue.serverTimestamp(),
      });
      print("Data added to Firebase!");
    } catch (e) {
      print("Failed to add data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Data to Firebase"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: addData,
          child: Text("Add Data"),
        ),
      ),
    );
  }
}
