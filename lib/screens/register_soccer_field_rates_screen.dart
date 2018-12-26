import 'package:Pichanga/screens/Inicio/menu.dart';
import 'package:flutter/material.dart';
import 'package:Pichanga/utils/colors.dart';
import 'package:flutter/services.dart';

class RegisterFootballFieldRatesScreen extends StatefulWidget {
  @override
  RegisterFootballFieldRatesScreenState createState() => new RegisterFootballFieldRatesScreenState();
}

class RegisterFootballFieldRatesScreenState extends State<RegisterFootballFieldRatesScreen> {
  @override
  Widget build(BuildContext context) {
    loadListSportsFields();
    loadListTypeOfCurrency();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: canchaPrimary, //or set color with: Color(0xFF0000FF)
    ));
    return new Scaffold(
      appBar: new AppBar(
          backgroundColor: Colors.transparent,
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
                    "Tarifas",
                    style: new TextStyle(fontSize: 25.0),
                  ),
                )
              ],
            ),
            Container(
              width: 300.0,
              child: DropdownButtonHideUnderline(
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: new DropdownButton(
                    hint: new Text("Canchas"),
                    items: listSportsFields,
                    onChanged: (value) =>print("$value"),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
              child: new TextField(
                decoration: new InputDecoration(labelText: 'Costo x Hora'),
              ),
            ),
            Container(
              width: 300.0,
              child: DropdownButtonHideUnderline(
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: new DropdownButton(
                    hint: new Text("Tipo de Moneda"),
                    items: listTypeOfCurrency,
                    onChanged: (value) =>print("$value"),
                  ),
                ),
              ),
            ),
            new SizedBox(
              height: 15.0,
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


  List<DropdownMenuItem<int>>listSportsFields = [];
  void loadListSportsFields(){
    listSportsFields = [];
    listSportsFields.add(new DropdownMenuItem(
      child: new Text('Cancha 1'),
      value:1,
    ));
    listSportsFields.add(new DropdownMenuItem(
      child: new Text('Cancha 2'),
      value:0,
    ));
  }
  List<DropdownMenuItem<int>>listTypeOfCurrency = [];
  void loadListTypeOfCurrency(){
    listTypeOfCurrency = [];
    listTypeOfCurrency.add(new DropdownMenuItem(
      child: new Text('Soles'),
      value:1,
    ));
    listTypeOfCurrency.add(new DropdownMenuItem(
      child: new Text('Dolares'),
      value:0,
    ));
  }
}


