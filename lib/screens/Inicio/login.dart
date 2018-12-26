import 'package:flutter/material.dart';
import 'package:Pichanga/model/user.dart';
import 'package:Pichanga/utils/colors.dart';
import 'package:Pichanga/screens/Inicio/menu.dart';
import 'dart:async';
import 'dart:convert' show json;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'DetailedScreen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:Pichanga/model/user_controller.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

GoogleSignIn _googleSignIn = new GoogleSignIn(
  scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  //Creacion de los nombres de los campos de texto lo cual se alamcena la data
  final emailcontrol01 = TextEditingController();
  final passcontrol01 = TextEditingController();
  UserController obj1 = new UserController();
  User tokuser = new User();
  String tok;

  GoogleSignInAccount _currentUser;
  String _contactText;

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        _handleGetContact();
      }
    });
    _googleSignIn.signInSilently();
  }

  Future<dynamic> _handleGetContact() async {
    setState(() {
      _contactText = "Cargando Informacion del contacto...";
    });
    final http.Response response = await http.get(
      'https://people.googleapis.com/v1/people/me/connections'
          '?requestMask.includeField=person.names',
      headers: await _currentUser.authHeaders,
    );
    if (response.statusCode != 200) {
      setState(() {
        _contactText = "People API gave a ${response.statusCode} "
            "response. Check logs for details.";
      });
      print('People API ${response.statusCode} response: ${response.body}');
      return;
    }
    final Map<String, dynamic> data = json.decode(response.body);
    final String namedContact = _pickFirstNamedContact(data);
    setState(() {
      if (namedContact != null) {
        _contactText = "I see you know $namedContact!";
      } else {
        _contactText = "o hay contactos para mostrar.";
      }
    });
  }

  String _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic> connections = data['connections'];
    final Map<String, dynamic> contact = connections?.firstWhere(
          (dynamic contact) => contact['names'] != null,
      orElse: () => null,
    );
    if (contact != null) {
      final Map<String, dynamic> name = contact['names'].firstWhere(
            (dynamic name) => name['displayName'] != null,
        orElse: () => null,
      );
      if (name != null) {
        return name['displayName'];
      }
    }
    return null;
  }

  Future<dynamic> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }


  static final FacebookLogin facebookSignIn = new FacebookLogin();

  //my code
  final FirebaseAuth _fAuth = FirebaseAuth.instance;

  //end my code
  Future<FirebaseUser> _signIn(BuildContext context) async {
    final FacebookLoginResult result =
    await facebookSignIn.logInWithReadPermissions(['email']);

    FirebaseUser user =
    await _fAuth.signInWithFacebook(accessToken: result.accessToken.token);
    //Token: ${accessToken.token}

    ProviderDetails userInfo = new ProviderDetails(
        user.providerId, user.uid, user.displayName, user.photoUrl, user.email);

    List<ProviderDetails> providerData = new List<ProviderDetails>();
    providerData.add(userInfo);

    UserInfoDetails userInfoDetails = new UserInfoDetails(
        user.providerId,
        user.uid,
        user.displayName,
        user.photoUrl,
        user.email,
        user.isAnonymous,
        user.isEmailVerified,
        providerData);

    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new DetailedScreen(detailsUser: userInfoDetails),
      ),
    );

    return user;
  }

  //TODO
  //TODO
  //TODO
  //TODO: TRABAJAR FORMULARIO AQUII

  final Map<String, dynamic> _formData = {
    'email': null,
    'password': null,
    'acceptTerms': false
  };

  final TextEditingController _passwordTextController = TextEditingController();

  //AuthMode _authMode = AuthMode.Login;

  DecorationImage _buildBackgroundImage() {
    return DecorationImage(
      fit: BoxFit.cover,
      colorFilter:
      ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
      image: AssetImage('assets/logo_login.png'),
    );
  }

  Widget _buildEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'E-Mail', filled: true, fillColor: Colors.white),
      keyboardType: TextInputType.emailAddress,
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                .hasMatch(value)) {
          return 'Please enter a valid email';
        }
      },
      onSaved: (String value) {
        _formData['email'] = value;
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Password', filled: true, fillColor: Colors.white),
      obscureText: true,
      controller: _passwordTextController,
      validator: (String value) {
        if (value.isEmpty || value.length < 6) {
          return 'Password invalid';
        }
      },
      onSaved: (String value) {
        _formData['password'] = value;
      },
    );
  }

  Widget _buildPasswordConfirmTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Confirm Password', filled: true, fillColor: Colors.white),
      obscureText: true,
      validator: (String value) {
        if (_passwordTextController.text != value) {
          return 'Passwords do not match.';
        }
      },
    );
  }

  Widget _buildAcceptSwitch() {
    return SwitchListTile(
      value: _formData['acceptTerms'],
      onChanged: (bool value) {
        setState(() {
          _formData['acceptTerms'] = value;
        });
      },
      title: Text('Accept Terms'),
    );
  }

//  void _submitForm(Function authenticate) async {
//    if (!_formKey.currentState.validate() || !_formData['acceptTerms']) {
//      return;
//    }
//    _formKey.currentState.save();
//    Map<String, dynamic> successInformation;
//    successInformation = await authenticate(
//        _formData['email'], _formData['password'], _authMode);
//    if (successInformation['success']) {
//      // Navigator.pushReplacementNamed(context, '/');
//    } else {
//      showDialog(
//        context: context,
//        builder: (BuildContext context) {
//          return AlertDialog(
//            title: Text('An Error Occurred!'),
//            content: Text(successInformation['message']),
//            actions: <Widget>[
//              FlatButton(
//                child: Text('Okay'),
//                onPressed: () {
//                  Navigator.of(context).pop();
//                },
//              )
//            ],
//          );
//        },
//      );
//    }
//  }
  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Error revise su correo o contraseña",style: TextStyle(color: Colors.red)),
        );
      },
    );
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
                    "Iniciar Sesión",
                    style: new TextStyle(fontSize: 30.0),
                  ),
                )
              ],
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
              child: new TextFormField(
                controller: emailcontrol01,
                keyboardType: TextInputType.emailAddress,
                decoration: new InputDecoration(labelText: 'Correo'),
              ),
            ),
            new SizedBox(
              height: 15.0,
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
              child: new TextFormField(
                controller: passcontrol01,
                obscureText: true,
                decoration: new InputDecoration(labelText: 'Contraseña'),
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
                        obj1.getTokenUser(emailcontrol01.text, passcontrol01.text);
                        if(emailcontrol01.text=='admin'&&passcontrol01.text=='admin'){

                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => Menu()));

                        }else{
                          _showDialog();
                        }
                      },
                      child: new Container(
                          alignment: Alignment.center,
                          height: 60.0,
                          decoration: new BoxDecoration(
                              color: canchaPrimary,
                              borderRadius: new BorderRadius.circular(9.0)),
                          child: new Text("INGRESAR",
                              style: new TextStyle(
                                  fontSize: 20.0, color: Colors.white))),
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
                        left: 20.0, right: 5.0, top: 10.0),
                    child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,
                        decoration: new BoxDecoration(
                            color: Color(0xFF4364A1),
                            borderRadius: new BorderRadius.circular(9.0)),
                        child: new Text("FACEBOOK",
                            style: new TextStyle(
                                fontSize: 20.0, color: Colors.white))),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 20.0, top: 10.0),
                    child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,
                        decoration: new BoxDecoration(
                            color: Color(0xFFDF513B),
                            borderRadius: new BorderRadius.circular(9.0)),
                        child: new Text("GOOGLE",
                            style: new TextStyle(
                                fontSize: 20.0, color: Colors.white))),
                  ),
                )
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom:18.0),
                    child: new Text("Recuperar Contraseña ",style: new TextStyle(
                        fontSize: 17.0, color: canchaPrimary,fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}

class UserInfoDetails {
  UserInfoDetails(this.providerId, this.uid, this.displayName, this.photoUrl,
      this.email, this.isAnonymous, this.isEmailVerified, this.providerData);

  /// The provider identifier.
  final String providerId;

  /// The provider’s user ID for the user.
  final String uid;

  /// The name of the user.
  final String displayName;

  /// The URL of the user’s profile photo.
  final String photoUrl;

  /// The user’s email address.
  final String email;

  // Check anonymous
  final bool isAnonymous;

  //Check if email is verified
  final bool isEmailVerified;

  //Provider Data
  final List<ProviderDetails> providerData;
}

class ProviderDetails {
  final String providerId;

  final String uid;

  final String displayName;

  final String photoUrl;

  final String email;

  ProviderDetails(
      this.providerId, this.uid, this.displayName, this.photoUrl, this.email);
}
