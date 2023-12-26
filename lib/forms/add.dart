// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/welcome.dart';
import 'package:flutter_application_1/services/firebase.dart';

// ignore: camel_case_types
class add extends StatelessWidget {
  final DocumentSnapshot userDoc;
  const add(this.userDoc, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //Es el encavezado o navegador.
        title: const Text(
          "New Homework",
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
          cuerpo(context, userDoc),
        ]),
      ),
    );
  }
}

Widget titulo() {
  return Center(
    child: Text(
      "Añadir una nueva tarea",
      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    ),
  );
}

Widget cuerpo(BuildContext context, DocumentSnapshot userDoc) {
  return Column(
    children: [
      title(),
      SizedBox(
        height: 30.0,
      ),
      campo(),
      SizedBox(
        height: 30.0,
      ),
      descrip(),
      SizedBox(
        height: 30.0,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: guardar(context, userDoc),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: cancelar(context),
            ),
          ),
        ],
      ),
    ],
  );
}

Widget guardar(context, DocumentSnapshot userDoc) {
  return Center(
    child: ElevatedButton(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(const Size(150, 40)),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return Color.fromARGB(255, 26, 70, 26);
            }
            return Color.fromARGB(255, 35, 151, 31);
          },
        ),
      ),
      onPressed: () {
        if (kDebugMode) {
          alerta(context, userDoc);
        }
      },
      child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(Icons.inventory_rounded, color: Color.fromARGB(255, 0, 0, 0)),
            SizedBox(
              width: 5,
            ),
            Text(
              "Guardar",
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
          ]),
    ),
  );
}

Widget cancelar(context) {
  return Center(
    child: ElevatedButton(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(const Size(150, 40)),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return Color.fromARGB(255, 70, 26, 26);
            }
            return Color.fromARGB(255, 151, 31, 31);
          },
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(Icons.cancel, color: Color.fromARGB(255, 53, 20, 20)),
            SizedBox(
              width: 5,
            ),
            Text(
              "Cancelar",
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
          ]),
    ),
  );
}

TextEditingController tituloController = TextEditingController(text: "");
TextEditingController campoController = TextEditingController(text: "");
TextEditingController descripController = TextEditingController(text: "");

Widget title() {
  return Row(
    children: [
      Text(
        "1.* ",
        textAlign: TextAlign.justify,
      ),
      Expanded(
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
              child: TextField(
                controller: tituloController,
                decoration: InputDecoration(
                    hintText: "Titulo de la tarea",
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                    filled: true),
              )))
    ],
  );
}

Widget campo() {
  return Row(
    children: [
      Text(
        "2.  * ",
        textAlign: TextAlign.justify,
      ),
      Expanded(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
            child: TextField(
              controller: campoController,
              decoration: InputDecoration(
                  hintText: "Lugar donde se realizará",
                  fillColor: const Color.fromARGB(255, 255, 255, 255),
                  filled: true),
            )),
      )
    ],
  );
}

Widget descrip() {
  return Row(
    children: [
      Text(
        "3. Descripción: * ",
        textAlign: TextAlign.justify,
      ),
      Expanded(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
            child: TextField(
              controller: descripController,
              decoration: InputDecoration(
                  hintText: "Objetivo de la tarea",
                  fillColor: const Color.fromARGB(255, 255, 255, 255),
                  filled: true),
            )),
      ),
    ],
  );
}

void alerta(BuildContext context, DocumentSnapshot userDoc) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text("Perfecto"),
            content: Text("Tarea guardada con éxito"),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => welcome(userDoc)));
                    addhomework(tituloController.text, campoController.text,
                        descripController.text);
                  },
                  child: Text("De acuerdo.")),
            ]);
      });
}
