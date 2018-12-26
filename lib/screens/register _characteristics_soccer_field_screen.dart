import 'package:Pichanga/screens/Inicio/menu.dart';
import 'package:flutter/material.dart';
import 'package:Pichanga/utils/colors.dart';
import 'package:flutter/services.dart';

class RegisterCharacteristicsSoccerFieldScreen extends StatefulWidget {
  @override
  RegisterCharacteristicsSoccerFieldState createState() => new RegisterCharacteristicsSoccerFieldState();
}
class RegisterCharacteristicsSoccerFieldState extends State<RegisterCharacteristicsSoccerFieldScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: canchaPrimary, //or set color with: Color(0xFF0000FF)
    ));
    return new Scaffold(
      appBar: new AppBar(
          backgroundColor:Colors.transparent,
          elevation: 0.0,
          iconTheme: new IconThemeData(color: canchaPrimary)),
      body: Container(
        width: double.infinity,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //new StakedIcons(),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 80.0),
                  child: new Text(
                    "Caracteristicas",
                    style: new TextStyle(fontSize: 25.0),
                  ),
                )
              ],
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
              child: new TextField(
                decoration: new InputDecoration(labelText: 'Nombre'),
              ),
            ),
            new SizedBox(
              height: 15.0,
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
              child: new TextField(
                obscureText: true,
                decoration: new InputDecoration(labelText: 'Icono'),
              ),
            ),
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
                          builder: (context) => Menu(),
                        ));
                      },
                      child: new Container(
                          alignment: Alignment.center,
                          height: 60.0,
                          decoration: new BoxDecoration(
                              color: canchaPrimary,
                              borderRadius: new BorderRadius.circular(9.0)),
                          child: new Text("Registrar",
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

  List<DropdownMenuItem<int>>listDrop = [];
  void LoadData(){
    listDrop = [];
    listDrop.add(new DropdownMenuItem(
      child: new Text('Activo'),
      value:1,
    ));
    listDrop.add(new DropdownMenuItem(
      child: new Text('Inactivo'),
      value:0,
    ));
  }
}


