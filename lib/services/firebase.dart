// ignore_for_file: unnecessary_cast, avoid_print

import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/pages/homework.dart';

FirebaseFirestore database = FirebaseFirestore.instance;

//Traer información desde la base de datos para la vista de la tabla

Future<List<Map<String, dynamic>>> getPerson() async {
  //Datos de los usuarios
  List<Map<String, dynamic>> person = [];
  CollectionReference collectionReferencePerson = database.collection('person');
  QuerySnapshot queryPerson = await collectionReferencePerson.get();
  for (var documento in queryPerson.docs) {
    person.add(documento.data() as Map<String, dynamic>);
  }
  return person;
}

Stream<List<Map<String, dynamic>>> gettarea() {
  //Datos de las tareas
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
  //mapeo que intenta combinar tareas y personas
  List<Map<String, dynamic>> person = await getPerson();
  return [...person];
}

Future<int> getPersonCount() async {
  //Contador de datos persona
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
  //Contador de datos tareas
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
    'completada': "",
  });
}

Future<void> update(String ide, int taskId) async {
  //Actualización de tareas
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  try {
    QuerySnapshot querySnapshot = await firestore
        .collection('homework')
        .where('id', isEqualTo: taskId)
        .get();
    print('QuerySnapshot: $querySnapshot');

    if (querySnapshot.docs.isEmpty) {
      print('No existen documentos de: $taskId');
    } else {
      DocumentSnapshot docSnapshot = querySnapshot.docs[0];
      await docSnapshot.reference.update({'completada': ide, 'realizada': 1});
      print('Document updated successfully');
    }
  } catch (e) {
    print('Failed to update document: $e');
  }
}
