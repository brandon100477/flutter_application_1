// ignore_for_file: unnecessary_cast

import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore database = FirebaseFirestore.instance;

//Traer información desde la base de datos para la vista de la tabla

Future<List<Map<String, dynamic>>> getPerson() async {
  List<Map<String, dynamic>> person = [];
  CollectionReference collectionReferencePerson = database.collection('person');
  QuerySnapshot queryPerson = await collectionReferencePerson.get();
  for (var documento in queryPerson.docs) {
    person.add(documento.data() as Map<String, dynamic>);
  }
  return person;
}

Stream<List<Map<String, dynamic>>> gettarea() {
  return FirebaseFirestore.instance
      .collection('homework')
      .snapshots()
      .map((snapshot) {
    return snapshot.docs
        .map((doc) => {'id': doc.id, ...doc.data()} as Map<String, dynamic>)
        .toList();
  });
}

Future<List<Map<String, dynamic>>> getcombinedData() async {
  List<Map<String, dynamic>> person = await getPerson();
  return [...person];
}

Future<int> getPersonCount() async {
  final snapshot = await database.collection("person").get();
  return snapshot.docs.length;
}

//Guardar datos a DB coleccion personas
Future<void> addperson(String documento, nombre, sede) async {
  final personCount = await getPersonCount();
  await database.collection("person").add({
    "id": personCount + 1,
    "documento": documento,
    "nombre": nombre,
    "sede": sede
  });
}

Future<int> gethwkCount() async {
  final snapshot = await database.collection("homework").get();
  return snapshot.docs.length;
}

//Guardar datos a DB coleccion tareas
Future<void> addhomework(String titulo, campo, descrip) async {
  final homework = await gethwkCount();
  await database.collection("homework").add({
    "id": homework + 1,
    "titulo": titulo,
    "campo": campo,
    "descrip": descrip,
    "realizada": 0,
  });
}

/* Future<void> update() async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  DocumentReference docRef =
      firestore.collection('tuColeccion').doc('homework');

  await docRef.update({
    'realizada': 'valorDelNuevoCampo',
  });
} */
