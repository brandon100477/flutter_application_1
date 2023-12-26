// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/forms/add.dart';
import 'package:flutter_application_1/forms/table.dart';
import 'package:flutter_application_1/pages/homework.dart';
import 'package:flutter_application_1/services/firebase.dart';

// ignore: camel_case_types
class welcome extends StatelessWidget {
  final DocumentSnapshot userDoc;
  const welcome(this.userDoc, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //Es el encavezado o navegador.
        title: Text(
          "Bienvenido, ${userDoc['nombre']}",
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
      "Aquí se mostrará la lista de tareas pendientes.",
      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    ),
  );
}

Widget cuerpo(BuildContext context, DocumentSnapshot userDoc) {
  return Container(
      child: Column(
    children: [
      tabla(userDoc),
      SizedBox(
        height: 30.0,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: registros(context),
          )),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: nuevo(context, userDoc),
          ))
        ],
      )
    ],
  ));
}

Widget provicional(context, DocumentSnapshot userDoc, int tareaId) {
  return Center(
    child: ElevatedButton(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(const Size(100, 20)),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return Color.fromARGB(255, 82, 87, 87);
            }
            return Color.fromARGB(255, 255, 255, 255);
          },
        ),
      ),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => homework(
                      taskId: tareaId,
                      key: Key('myUniqueKey'),
                      userDoc: userDoc,
                    )));
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
              "Revisar",
              style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
          ]),
    ),
  );
}

Widget registros(context) {
  return Center(
    child: ElevatedButton(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(const Size(170, 50)),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return Color.fromARGB(255, 33, 19, 38);
            }
            return Color.fromARGB(255, 113, 72, 130);
          },
        ),
      ),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => table()));
      },
      child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(Icons.checklist, color: Color.fromARGB(255, 0, 0, 0)),
            SizedBox(
              width: 5,
            ),
            Text(
              "Hechas",
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255), fontSize: 20),
            ),
          ]),
    ),
  );
}

Widget nuevo(context, DocumentSnapshot userDoc) {
  return Center(
    child: ElevatedButton(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(const Size(170, 50)),
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
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => add(userDoc)));
      },
      child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(Icons.library_add_outlined,
                color: Color.fromARGB(255, 0, 0, 0)),
            SizedBox(
              width: 5,
            ),
            Text(
              "Nueva",
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255), fontSize: 22),
            ),
          ]),
    ),
  );
}

Widget tabla(DocumentSnapshot userDoc) {
  return Center(
      child: Padding(
    padding: const EdgeInsets.all(0.0),
    child: Container(
      height: 400.0,
      width: 500.0,
      child: SingleChildScrollView(
        child: StreamBuilder(
            stream: gettarea(),
            builder:
                (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                List<Map<String, dynamic>> data = snapshot.data!;
                data.sort((a, b) => a['id'].compareTo(b['id']));
                if (data.isEmpty) {
                  return Text(
                    'Lo sentimos. Aún no hay tareas para mostrar',
                    style:
                        TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  );
                } else {
                  return Column(
                    children: [
                      for (var tareaData in data)
                        Center(
                            child: Column(
                          children: [
                            Text(
                              tareaData['titulo'].toString(),
                              style: TextStyle(
                                  fontSize: 15.0, fontWeight: FontWeight.bold),
                            ),
                            Text(tareaData['id'].toString()),
                            provicional(context, userDoc, tareaData['id']),
                            SizedBox(
                              height: 30.0,
                            ),
                          ],
                        )),
                    ],
                  );
                }
              }
            }),
      ),
    ),
  ));
}
