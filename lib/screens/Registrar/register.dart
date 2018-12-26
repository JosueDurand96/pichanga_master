import 'package:flutter/material.dart';
import 'package:Pichanga/screens/Registrar/SmsPageState.dart';
import 'package:Pichanga/utils/colors.dart';

class RegisterPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _RegisterPageState createState() => new _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final correovalidation3 = TextEditingController();

  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  String  email, mobile;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Scaffold(
        body: new Center(
          child: new Container(
            margin: new EdgeInsets.only(left: 10.0,right: 10.0,top: 100.0,bottom: 10.0),
            padding: new  EdgeInsets.only(left: 10.0,right: 10.0,top: 100.0,bottom: 0.0),
            child: new Form(
              key: _key,

              autovalidate: _validate,
              child: FormUI(),
            ),
          ),
        ),
      ),
    );
  }
  Widget FormUI() {
    return new Column(
      children: <Widget>[
        new CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 48.0,
          child: Image.asset('assets/correo.png'),
        ),

        new TextFormField(

            decoration: new InputDecoration(hintText: 'Correo'),
            keyboardType: TextInputType.emailAddress,
            controller: correovalidation3,
            maxLength: 32,
            validator: validateEmail,
            onSaved: (String val) {
              email = val;
            }),

        new SizedBox(height: 50.0),

        new Padding(
          padding: EdgeInsets.symmetric(vertical: 14),

          child: Material(
            borderRadius: BorderRadius.circular(30.0),

            color: canchaPrimaryLight,
            shadowColor: Colors.green.shade100,
            elevation: 5.0,
            child: MaterialButton(
              minWidth: 400.0,
              height: 50.0,
              onPressed: (){
                _sendToServer();
              },
              child: Text('SIGUIENTE', style: TextStyle(color: Colors.white,fontSize: 22)),
            ),
          ),
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

      print("Email $email");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => (SmsPageState())),
      );
    } else {
      // validation error
      setState(() {
        _validate = true;
      });
    }
  }
}





