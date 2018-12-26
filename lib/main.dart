import 'package:flutter/material.dart';
import 'package:Pichanga/screens/Inicio/login.dart';
import 'package:Pichanga/screens/Inicio/splash.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context) => LoginPage(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //Titulo de la app en segundo plano
      title: 'Canchas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Raleway',
      ),
      //Se carga primero el Splash
      home: SplashPage(),
      //routes: routes,
    );
  }
}

