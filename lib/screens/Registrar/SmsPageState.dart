import 'package:flutter/material.dart';
import 'package:Pichanga/utils/colors.dart';
import 'package:Pichanga/screens/Registrar/RegisterDetailPageState.dart';

class SmsPageState extends StatefulWidget {
  @override
  _SmsPageState createState() => new _SmsPageState();

}
class _SmsPageState extends State<SmsPageState>{
  TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = new TextEditingController(text: '+51');
  }
  @override
  Widget build(BuildContext context) {
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
                    "Validación SMS",
                    style: new TextStyle(fontSize: 30.0),
                  ),
                )
              ],
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
              child: new TextFormField (
                decoration: new InputDecoration(labelText: 'Pais'),
              ),
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                    child: new TextFormField (
                      controller: _controller,
                      textAlign: TextAlign.center,
                      decoration: new InputDecoration(
                        labelText: 'Prefijo',
                        //hintText: '+51',
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                    child: new TextFormField (
                      decoration: new InputDecoration(labelText: 'Numero Celular'),
                    ),
                  ),
                ),
              ],
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
                          builder: (context) => RegisterDetailPageState(),
                        ));
                      },
                      child: new Container(
                          alignment: Alignment.center,
                          height: 60.0,
                          decoration: new BoxDecoration(
                              color: canchaPrimary,
                              borderRadius: new BorderRadius.circular(9.0)),
                          child: new Text("VALIDAR NUMERO",
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