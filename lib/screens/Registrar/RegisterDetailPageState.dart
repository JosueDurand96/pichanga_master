import 'package:flutter/material.dart';
import 'package:Pichanga/screens/Inicio/option_session.dart';
import 'package:Pichanga/utils/colors.dart';
import 'package:Pichanga/screens/Inicio/menu.dart';

class RegisterDetailPageState extends StatefulWidget {
  static String tag2 = 'login-page';
  @override
  _RegisterDetailPageState createState() => new _RegisterDetailPageState();
}

class _RegisterDetailPageState extends State<RegisterDetailPageState> {
  //Creacion de los nombres de los campos de texto lo cual se alamcena la data
  final nombreControl = TextEditingController();
  final apellidoPaternoControl = TextEditingController();
  final apellidoMaternoControl = TextEditingController();
  final emailcontrol = TextEditingController();
  final celularcontrol = TextEditingController();
  final usuarioControl = TextEditingController();
  final passcontrol = TextEditingController();

  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  String  email, mobile;

  String name,apellidopat,apellidomat, usuario, password;

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
                    "Datos Personales",
                    style: new TextStyle(fontSize: 30.0),
                  ),
                )
              ],
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
              child: new TextFormField (
                decoration: new InputDecoration(labelText: 'Nombres'),
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
              child: new TextFormField (
                decoration: new InputDecoration(labelText: 'Correo'),
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
              child: new TextFormField (
                decoration: new InputDecoration(labelText: 'Password'),
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
                          child: new Text("REGISTRAR",
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
  Widget FormUI() {
    return new Column(
      children: <Widget>[
        new TextFormField(

          decoration: new InputDecoration(hintText: 'Nombres'),
          maxLength: 32,
          controller: nombreControl,
          validator: validateName,
          onSaved: (String val) {
            name = val;
          },
        ),
        new TextFormField(
          decoration: new InputDecoration(hintText: 'Apellido Paterno'),
          maxLength: 32,
          controller: apellidoPaternoControl,
          validator: validateName,
          onSaved: (String val) {
            apellidopat = val;
          },
        ),
        new TextFormField(
          decoration: new InputDecoration(hintText: 'Apellido Materno'),
          maxLength: 32,
          controller: apellidoMaternoControl,
          validator: validateName,
          onSaved: (String val) {
            apellidomat = val;
          },
        ),
        new TextFormField(
            decoration: new InputDecoration(hintText: 'Celular'),
            keyboardType: TextInputType.phone,
            controller: celularcontrol,
            maxLength: 9,
            validator: validateMobile,
            onSaved: (String val) {
              mobile = val;
            }),
        new TextFormField(
            decoration: new InputDecoration(hintText: 'Correo o Usuario'),
            keyboardType: TextInputType.emailAddress,
            controller: usuarioControl,
            maxLength: 32,
            validator: validateEmail,
            onSaved: (String val) {
              email = val;
            }),
        new TextFormField(
            decoration: new InputDecoration(hintText: 'Password'),
            keyboardType: TextInputType.text,
            maxLength: 6,
            controller: passcontrol,
            validator: validateName,
            onSaved: (String val) {
              mobile = val;
            }),
        new SizedBox(height: 15.0),
        new RaisedButton(
          onPressed: _sendToServer,
          child: new Text('Send'),
        )
      ],
    );
  }


  String validateEmail(String value) {
    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Email is Required";
    } else if(!regExp.hasMatch(value)){
      return "Correo Incorrecto";
    }else {
      return null;
    }
  }

  _sendToServer() {
    if (_key.currentState.validate()) {
      // No any error in validation
      _key.currentState.save();
      print("Name $name");
      print("Mobile $apellidopat");
      print("Email $apellidomat");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => (OptionSessionPage())),
      );
    } else {
      // validation error
      setState(() {
        _validate = true;
      });
    }
  }



  String validateName(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Name is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Name must be a-z and A-Z";
    }
    return null;
  }

  String validateMobile(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Mobile is Required";
    } else if(value.length != 9){
      return "Mobile number must 10 digits";
    }else if (!regExp.hasMatch(value)) {
      return "Mobile Number must be digits";
    }
    return null;
  }
}


