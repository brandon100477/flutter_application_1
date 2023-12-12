// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
//Importaciones de faribase

import 'package:flutter_application_1/services/firebase.dart';

// ignore: camel_case_types
class register extends StatelessWidget {
  const register({super.key});

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
      "Registrar un nuevo ususario.",
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
      nombre(),
      SizedBox(
        height: 30.0,
      ),
      sede(),
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
      onPressed: () {
        if (kDebugMode) {
          alerta(context);
        }
      },
      child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(Icons.add, color: Color.fromARGB(255, 43, 35, 180)),
            SizedBox(
              width: 5,
            ),
            Text(
              "Registrar",
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
          ]),
    ),
  );
}

//Controladores para guardar los registros del usuario
TextEditingController idController = TextEditingController(text: "");
TextEditingController nombreController = TextEditingController(text: "");
TextEditingController sedeController = TextEditingController(text: "");

Widget id() {
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
                controller: idController, //Puesto del controlador.
                decoration: InputDecoration(
                    hintText: "Identificación",
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                    filled: true),
              )))
    ],
  );
}

Widget nombre() {
  return Row(
    children: [
      Text(
        "2.* ",
        textAlign: TextAlign.justify,
      ),
      Expanded(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
            child: TextField(
              controller: nombreController,
              decoration: InputDecoration(
                  hintText: "Nombre y apellido",
                  fillColor: const Color.fromARGB(255, 255, 255, 255),
                  filled: true),
            )),
      )
    ],
  );
}

Widget sede() {
  return Row(
    children: [
      Text(
        "3.* ",
        textAlign: TextAlign.justify,
      ),
      Expanded(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
            child: TextField(
              controller: sedeController,
              decoration: InputDecoration(
                  hintText: "Sede principal",
                  fillColor: const Color.fromARGB(255, 255, 255, 255),
                  filled: true),
            )),
      ),
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
                  onPressed: () async {
                    Navigator.pop(context);
                    alertaSi(context);
                  },
                  child: Text("Estoy de acuerdo.")),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    alertaNo(context);
                  },
                  child: Text("No estoy de acuerdo."))
            ]);
      });
}

void alertaNo(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text("Error"),
            content: Text("Lo sentimos, su cuenta no se ha registrado."),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Ok")),
            ]);
      });
}

void alertaSi(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text("Perfecto"),
            content: Text("Registro guardado con éxito."),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => inicio()));
                    addperson(idController.text, nombreController.text,
                        sedeController.text);
                  },
                  child: Text("Gracias")),
            ]);
      });
}
