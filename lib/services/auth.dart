import 'package:cloud_firestore/cloud_firestore.dart';

Future<DocumentSnapshot> getUser(String documento) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  QuerySnapshot querySnapshot = await firestore
      .collection('person')
      .where('documento', isEqualTo: documento)
      .get();
  if (querySnapshot.docs.isNotEmpty) {
    return querySnapshot.docs.first;
  }
  throw Exception('El usuario no existe');
}
