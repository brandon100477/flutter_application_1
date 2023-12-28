// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, overridden_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/welcome.dart';
import 'package:flutter_application_1/services/firebase.dart';

// ignore: camel_case_types
class homework extends StatelessWidget {
  final int taskId;
  @override
  final Key key;
  final DocumentSnapshot userDoc;
  const homework(
      {required this.taskId, required this.key, required this.userDoc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //Es el encavezado o navegador.
        title: const Text(
          "Carry out",
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
          cuerpo(context, userDoc, taskId),
        ]),
      ),
    );
  }
}

Widget titulo() {
  return Center(
    child: Text(
      "Descripción de la Tarea",
      style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    ),
  );
}

Widget cuerpo(BuildContext context, DocumentSnapshot userDoc, int taskId) {
  return Column(
    children: [
      title(taskId),
      SizedBox(
        height: 30.0,
      ),
      descrip(taskId),
      SizedBox(
        height: 30.0,
      ),
      lugar(taskId),
      SizedBox(
        height: 30.0,
      ),
      id(),
      SizedBox(
        height: 30.0,
      ),
      hecho(context, userDoc, taskId),
    ],
  );
}

Widget hecho(context, DocumentSnapshot userDoc, int taskId) {
  return Center(
    child: ElevatedButton(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(const Size(100, 20)),
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
        update(nameController.text, taskId);
        alerta(context, userDoc);
      },
      child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(Icons.check, color: Color.fromARGB(255, 43, 35, 180)),
            SizedBox(
              width: 5,
            ),
            Text(
              "Cumplido",
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
          ]),
    ),
  );
}

TextEditingController nameController = TextEditingController(text: "");

Widget id() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
    child: TextField(
      controller: nameController,
      decoration: InputDecoration(
        hintText: "",
        labelText: "Identificación: ${nameController.text}",
        fillColor: const Color.fromARGB(255, 255, 255, 255),
        filled: true,
      ),
    ),
  );
}

Widget title(int taskId) {
  return StreamBuilder(
      stream: gettarea(),
      builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); //Widget para simbolo de carga
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}'); //Controlador de error
        } else {
          List<Map<String, dynamic>> data =
              snapshot.data!; //Enlistado de los datos
          Map<String, dynamic>? matchingTask = data.firstWhere(
            (task) =>
                task['id'] == taskId, //Declaracion y comparacion de variables
            orElse: () => {},
          );
          // ignore: unnecessary_null_comparison
          return Text(
            matchingTask.isNotEmpty ? matchingTask['titulo'].toString() : '',
            style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ); // especificacion del campo que se quiere mostrar
        }
      });
}

Widget descrip(int taskId) {
  return StreamBuilder(
      stream: gettarea(),
      builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); //Widget para simbolo de carga
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}'); //Controlador de error
        } else {
          List<Map<String, dynamic>> data =
              snapshot.data!; //Enlistado de los datos
          Map<String, dynamic>? matchingTask = data.firstWhere(
            (task) =>
                task['id'] == taskId, //Declaracion y comparacion de variables
            orElse: () => {},
          );
          return Text(
            matchingTask.isNotEmpty ? matchingTask.toString() : '',
            style:
                TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 16.0),
            textAlign: TextAlign.justify,
          );
        }
      });
}

Widget lugar(int taskId) {
  return StreamBuilder(
      stream: gettarea(),
      builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); //Widget para simbolo de carga
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}'); //Controlador de error
        } else {
          List<Map<String, dynamic>> data =
              snapshot.data!; //Enlistado de los datos
          Map<String, dynamic>? matchingTask = data.firstWhere(
            (task) =>
                task['id'] == taskId, //Declaracion y comparacion de variables
            orElse: () => {},
          );
          return Text(
            matchingTask.isNotEmpty ? matchingTask['campo'].toString() : '',
            style:
                TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 16.0),
            textAlign: TextAlign.left,
          );
        }
      });
}

void alerta(BuildContext context, DocumentSnapshot userDoc) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text("Perfecto"),
            content: Text("Tarea realizada con éxito"),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => welcome(userDoc)));
                  },
                  child: Text("De acuerdo.")),
            ]);
      });
}
