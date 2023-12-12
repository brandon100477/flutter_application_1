// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, empty_constructor_bodies

import 'package:flutter/material.dart';
//Importaciones de faribase
/* import 'package:firebase_core/firebase_core.dart'; */
import 'package:flutter_application_1/services/firebase.dart';
/* import 'package:cloud_firestore/cloud_firestore.dart'; */

// ignore: camel_case_types
class table extends StatelessWidget {
  const table({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //Es el encavezado o navegador.
        title: const Text(
          "Welcome to My app of homework",
          style: TextStyle(
              color: Color.fromARGB(
                  255, 255, 255, 255)), //Color del texto de encabezado
        ),
        backgroundColor: const Color.fromARGB(199, 7, 7, 7),
        /* titleTextStyle: Color.fromARGB(0, 255, 255, 255), */
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(children: [
          titulo(),
          SizedBox(height: 40),
          cuerpo(context),
          SizedBox(height: 40),
          MediaQuery.removePadding(
              context: context,
              removeLeft: true,
              removeTop: true,
              removeRight: true,
              removeBottom: true,
              child: tabla())
        ]),
      ),
    );
  }
}

Widget titulo() {
  return Center(
    child: Text(
      "Tareas resueltas",
      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    ),
  );
}

Widget cuerpo(BuildContext context) {
  return Column(
    children: [
      id(),
      SizedBox(
        height: 30.0,
      ),
    ],
  );
}

Widget id() {
  return Row(
    children: [
      Text(
        "Tabla ",
        textAlign: TextAlign.justify,
      ),
      Expanded(
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
              child: TextField(
                decoration: InputDecoration(
                    hintText: "Identificación",
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                    filled: true),
              )))
    ],
  );
}

void alerta(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text("Terminos y condiciones"),
            content: Text("Según las politicas de la desarrolladora..."),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Estoy de acuerdo.")),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("No estoy de acuerdo."))
            ]);
      });
}

Widget tabla() {
  return Center(
      child: Padding(
    padding: const EdgeInsets.all(0.0),
    child: FutureBuilder(
        future: getcombinedData(),
        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error:  ${snapshot.error}');
          } else {
            List<Map<String, dynamic>> data = snapshot.data!;
            data.sort((a, b) => a['id'].compareTo(b['id']));
            return Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                defaultColumnWidth: FixedColumnWidth(90),
                children: [
                  TableRow(
                    children: [
                      Text("#"),
                      Text("Titulo"),
                      Text("Fecha solicitud"),
                      Text("Fecha realizada"),
                      Text("Solucionada por"),
                    ],
                  ),
                  for (var personData in data)
                    TableRow(
                      children: [
                        Text(personData['id'].toString()),
                        Text(personData['titulo'].toString()),
                        Text(personData['fecha_solicitud'].toString()),
                        Text(personData['fecha_realizada'].toString()),
                        Text(personData['name'].toString()),
                      ],
                    )
                ]);
          }
        }),
  ));
}
