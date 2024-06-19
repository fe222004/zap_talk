import 'package:flutter/material.dart';
import 'package:zap_talk/src/pages/firstPage.dart';
import 'package:zap_talk/src/widget/navbar.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drawer App',
      initialRoute: "/",
      routes: {
        "/HomePage": (context) => FirstPage(),
      },
      home: Scaffold(
        drawer: const Navbar (),
        appBar: AppBar(
          title: const Text('Navegador drawer App'),
          backgroundColor: Colors.red,
        ),
        body: const Center(
          child: Text('Página principal',
           style: TextStyle(fontSize: 40.0),),
        ),
      ),
    );
  }
}