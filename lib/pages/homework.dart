// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

// ignore: camel_case_types
class homework extends StatelessWidget {
  const homework(userDoc, {super.key});

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
        ]),
      ),
    );
  }
}

Widget titulo() {
  return Center(
    child: Text(
      "Aquí se mostrará la descripción de cualquier tarea",
      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    ),
  );
}

Widget cuerpo(BuildContext context) {
  return Column(
    children: [
      Text(
        "Descripción de la tarea 1. Descripción de la tarea 1 Descripción de la tarea 1 Descripción de la tarea 1 Descripción de la tarea 1Descripción de la tarea 1",
        textAlign: TextAlign.justify,
      ),
      SizedBox(
        height: 30.0,
      ),
      Text(
        "Lugar: Un ejemplo de la sede donde está el problema. ",
        textAlign: TextAlign.justify,
      ),
      SizedBox(
        height: 30.0,
      ),
      Text(
        "Realizado por: ",
        textAlign: TextAlign.justify,
      ),
      id(),
      SizedBox(
        height: 30.0,
      ),
      hecho(context),
    ],
  );
}

Widget hecho(context) {
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
      onPressed: () {},
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

Widget id() {
  return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
      child: TextField(
        decoration: InputDecoration(
            hintText: "Identificación",
            fillColor: const Color.fromARGB(255, 255, 255, 255),
            filled: true),
      ));
}
