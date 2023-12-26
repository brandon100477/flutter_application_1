// ignore_for_file: prefer_const_constructors, duplicate_ignore, unused_local_variable
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application_1/pages/welcome.dart';
import 'package:flutter_application_1/register/register.dart';

//Importaciones de faribase
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/services/auth.dart';
/* import 'package:flutter_application_1/services/firebase.dart'; */
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Titulo", //Titulo del app que es diferente al encabezado.
        home: inicio(),
        initialRoute: '/principal',
        routes: {'/principal': (context) => inicio()});
  }
}

// ignore: camel_case_types
class inicio extends StatefulWidget {
  const inicio({super.key});
  @override
  State<inicio> createState() => _inicioState();
}

// ignore: camel_case_types
class _inicioState extends State<inicio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: cuerpo(context),
        ),
      ],
    ));
  }
}

Widget cuerpo(BuildContext context) {
  // ignore: avoid_unnecessary_containers
  return Container(
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: NetworkImage("../fondo1.jpg"),
        fit: BoxFit.cover,
      ),
    ),
    child: Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        titulo(),
        campoUsuario(),
        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: botonInicio(context),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: registrar(context),
              ),
            ),
          ],
        ),
      ],
    )),
  );
}

Widget titulo() {
  return Text("Iniciar sesión",
      style: TextStyle(
          color: Color.fromARGB(255, 255, 255, 255),
          fontSize: 37.0,
          fontWeight: FontWeight.bold));
}

TextEditingController inicioController = TextEditingController(text: "");

Widget botonInicio(context) {
  return Center(
    child: ElevatedButton(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(const Size(190, 50)),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return Color.fromARGB(255, 19, 38, 37);
            }
            return Color.fromARGB(255, 72, 130, 122);
          },
        ),
      ),
      onPressed: () async {
        String documento = inicioController.text;
        try {
          DocumentSnapshot userDoc = await getUser(documento);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => welcome(userDoc)));
        } catch (e) {
          String errorMessage;
          if (e.toString().contains('Documento no encontrado')) {
            errorMessage = 'Credenciales no correctas. Intente nuevamente';
          } else if (e.toString().contains('Documento no es válido')) {
            errorMessage = 'Credenciales no correctas. Intente nuevamente';
          } else {
            errorMessage = 'Credenciales no correctas. Intente nuevamente';
          }
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(errorMessage)));
        }
      },
      child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(Icons.key, color: Color.fromARGB(255, 43, 35, 180)),
            SizedBox(
              width: 5,
            ),
            Text(
              "Entrar",
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255), fontSize: 22),
            ),
          ]),
    ),
  );
}

Widget campoUsuario() {
  return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
      child: TextField(
        controller: inicioController,
        decoration: InputDecoration(
            hintText: "ID",
            fillColor: const Color.fromARGB(255, 255, 255, 255),
            filled: true,
            suffixIcon: (Icon(
              //Icono para el input
              Icons.verified_user,
            )),
            border: //Bordes para el input.
                OutlineInputBorder(borderRadius: BorderRadius.circular(15.0))),
      ));
}

Widget registrar(context) {
  return Center(
    child: ElevatedButton(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(const Size(190, 50)),
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
            context, MaterialPageRoute(builder: (context) => register()));
      },
      child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(Icons.account_box_outlined,
                color: Color.fromARGB(255, 0, 0, 0)),
            SizedBox(
              width: 5,
            ),
            Text(
              "Registrar",
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255), fontSize: 22),
            ),
          ]),
    ),
  );
}
