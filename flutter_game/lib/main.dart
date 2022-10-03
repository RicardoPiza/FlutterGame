import 'package:flutter/material.dart';
import 'dragg_plane.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Raptor: call of the USF'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final imgdata = Image.asset(
    'assets/images/aeroplane-transport-svgrepo-com.png',
    height: 60,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [
              0.1,
              0.4,
              0.7,
              1,
            ],
            colors: [
              Color.fromARGB(255, 228, 88, 54),
              Color.fromARGB(255, 207, 148, 92),
              Color.fromARGB(255, 238, 197, 84),
              Color.fromARGB(0, 223, 220, 18),
            ],
          ),
        ),
        child: DragablePlane(
          child: imgdata,
        ),
      ),
    );
  }
}
