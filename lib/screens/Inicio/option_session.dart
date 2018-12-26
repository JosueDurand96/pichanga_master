
import 'package:flutter/material.dart';
import 'package:Pichanga/utils/colors.dart';
import 'package:Pichanga/model/user_controller.dart';
import 'package:Pichanga/model/user.dart';
import 'package:Pichanga/screens/Registrar/register.dart';
import 'package:Pichanga/screens/Inicio/login.dart';
import 'package:Pichanga/screens/Registrar/SmsPageState.dart';

class OptionSessionPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _OptionSessionPageState createState() => new _OptionSessionPageState();
}

class _OptionSessionPageState extends State<OptionSessionPage> {
  //Creacion de los nombres de los campos de texto lo cual se alamcena la data
  final emailcontrol = TextEditingController();
  final passcontrol = TextEditingController();

  UserController obj1= new UserController();
  User objuuser = new User();
  String tok;
  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/logo_oficial.jpeg'),
      ),
    );

    final login = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        color: canchaPrimaryLight,
        shadowColor: Colors.green.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()),
          ),
          // color: canchaPrimaryLight,
          child: Text('Ingresar', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
    final session_activation = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        color: canchaPrimaryLight,
        shadowColor: Colors.green.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed:
          //Se llama la funcion de la Clase user_controller
              () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => SmsPageState()),
          ),
          // color: canchaPrimaryLight,
          child: Text('Registrarse', style: TextStyle(color: Colors.white)),
        ),
      ),
    );

    //Orden la los campos de texto y botoners
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ));
                      },
                      child: new Container(
                          alignment: Alignment.center,
                          height: 60.0,
                          decoration: new BoxDecoration(
                              color: canchaPrimary,
                              borderRadius: new BorderRadius.circular(9.0)),
                          child: new Text("LOGIN",
                              style: new TextStyle(
                                  fontSize: 20.0, color: Colors.white))),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => SmsPageState(),
                        ));
                      },
                      child: new Container(
                          alignment: Alignment.center,
                          height: 60.0,
                          decoration: new BoxDecoration(
                              color: canchaPrimary,
                              borderRadius: new BorderRadius.circular(9.0)),
                          child: new Text("REGISTRARSE",
                              style: new TextStyle(
                                  fontSize: 20.0, color: Colors.white))),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
