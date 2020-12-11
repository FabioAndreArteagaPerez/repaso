import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PracticaFinal',
      home: Operacion(),
    );
  }
}

class Operacion extends StatefulWidget {
  Operacion({Key key}) : super(key: key);

  @override
  _OperacionState createState() => _OperacionState();
}

class _OperacionState extends State<Operacion> {
  String mensaje = "";
  final TextEditingController parametrocontroller = new TextEditingController();

  Future obtenerOperacion(String valor) async {
    var response = await http.get(Uri.http(
        "practicafinalfabio.azurewebsites.net", "/api/Operacion/" + valor));
    print(response.body);
    setState(() {
      mensaje = response.body;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text("Operacion", style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              width: MediaQuery.of(context).size.width,
              child: TextFormField(
                controller: parametrocontroller,
                decoration: InputDecoration(
                  labelText: "Numero",
                  labelStyle: TextStyle(color: Colors.grey[600]),
                  border: UnderlineInputBorder(),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              )),
          Container(
            margin: EdgeInsets.fromLTRB(0, 30.0, 0, 0),
            padding: EdgeInsets.symmetric(horizontal: 13.5, vertical: 5),
            height: 30,
            child: Text(
              "$mensaje",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Center(
              child: RaisedButton(
            onPressed: () async {
              await obtenerOperacion(parametrocontroller.text);
            },
            color: Colors.blue[900],
            splashColor: Color(0xFF356859),
            child: Text(
              "Ingresar numero",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )),
        ],
      ),
    );
  }
}
