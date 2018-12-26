import 'package:flutter/material.dart';
import 'package:Pichanga/screens/Inicio/option_session.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Pichanga/screens/register_football_field_screen.dart';
import 'package:Pichanga/utils/colors.dart';
import 'package:Pichanga/screens/register _characteristics_soccer_field_screen.dart';
import 'package:Pichanga/screens/register _football_field_type_screen.dart';
import 'package:Pichanga/screens/register_soccer_field_rates_screen.dart';
import 'package:Pichanga/screens/register_soccer_field_schedules_screen.dart';
import 'package:Pichanga/screens/register_characteristics_soccer_field_detail_screen.dart';

class Menu  extends StatefulWidget {
  @override
  _MenuPageState createState() => new _MenuPageState();
}
class _MenuPageState extends State<Menu> {
  String currentProfilePic = "https://img.elcomercio.pe/files/article_content_ec_fotos/uploads/2018/06/25/5b311adf0c62b.jpeg";
  String otherProfilePic = "https://assets.trome.pe/uploads/2017/03/26/58d8006f17393.jpeg";

  void switchAccounts() {
    String picBackup = currentProfilePic;
    this.setState(() {
      currentProfilePic = otherProfilePic;
      otherProfilePic = picBackup;
    });
  }
  String status = "";
  @override
  void initState() {
    super.initState();
    getStatusSharedPreferences();
  }

  getStatusSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      status = prefs.getString('token') ?? "";
    });
  }
  getStatusSharedPreferencesRemove() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    print("borrando localstorage");

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: new AppBar(title: new Text("Pichangas"),backgroundColor: canchaPrimary,),
        drawer: new Drawer(
          child: new ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                accountEmail: new Text("bramvbilsen@gmail.com" + status),
                accountName: new Text("Bramvbilsen"),
                currentAccountPicture: new GestureDetector(
                  child: new CircleAvatar(
                    backgroundImage: new NetworkImage(currentProfilePic),
                  ),
                  onTap: () => print("This is your current account."),
                ),
                otherAccountsPictures: <Widget>[
                  new GestureDetector(
                    child: new CircleAvatar(
                      backgroundImage: new NetworkImage(otherProfilePic),
                    ),
                    onTap: () => switchAccounts(),
                  ),
                ],
                decoration: new BoxDecoration(
                    image: new DecorationImage(
                        image: new NetworkImage("https://www.24horas.cl/incoming/_95410190_gettyimages-488144002jpg-2345205/ALTERNATES/BASE_LANDSCAPE/_95410190_gettyimages-488144002.jpg"),
                        fit: BoxFit.fill
                    )
                ),
              ),
              new ListTile(
                  title: new Text("Tipo de Canchas"),
                  //trailing: new Icon(Icons.arrow_upward),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new RegisterFootballFieldTypeScreen()));
                  }
              ),
              new ListTile(
                  title: new Text("Caracteristicas"),
                  //trailing: new Icon(Icons.arrow_upward),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new RegisterCharacteristicsSoccerFieldScreen()));
                  }
              ),
              new ListTile(
                  title: new Text("Canchas"),
                  //trailing: new Icon(Icons.arrow_upward),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new RegisterFootballFieldScreen()));
                  }
              ),
              new ListTile(
                  title: new Text("Caracteristica de las Canchas"),
                  //trailing: new Icon(Icons.arrow_upward),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new RegisterCharacteristicsSoccerFieldDetailScreen()));
                  }
              ),
              new ListTile(
                  title: new Text("Tarifas"),
                  //trailing: new Icon(Icons.arrow_upward),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new RegisterFootballFieldRatesScreen()));
                  }
              ),
              new ListTile(
                  title: new Text("Horario"),
                  //trailing: new Icon(Icons.arrow_right),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new RegisterFootballFieldSchedulesScreen()));
                  }
              ),
         new ListTile(
    //leading: new Icon(Icons.person),
    title: new Text("Cerrar Sesion"),
    subtitle: new Text("Sus datos de la sesion sera borradas."),
    onTap:(){
    getStatusSharedPreferencesRemove();
    Navigator.push(
    context, MaterialPageRoute(builder: (context) => OptionSessionPage()),
    );
    },

    ),
            ],
          ),
        ),
        body: new Center(
          child: new Text("Drawer Tutorial", style: new TextStyle(fontSize: 35.0)),
        ),
      bottomNavigationBar: new BottomNavigationBar(items: _getFooterItems()
      ),
    );
  }

  //Creacion de Tabs
  List<BottomNavigationBarItem>_getFooterItems(){
    return [
      new BottomNavigationBarItem(
          icon: new Icon(Icons.thumb_up),title: new Text("Canchas")
      ),
      new BottomNavigationBarItem(
          icon: new Icon(Icons.update),title: new Text("Buscar")
      ),
      new BottomNavigationBarItem(
          icon: new Icon(Icons.star),title: new Text("Reportes")
      )
    ];
  }

}

