import 'dart:convert';
import 'dart:io';
import 'dart:async';

class User {
  String tokens;
  String username;
  String type;
  int status;

  //Recibir datos Rest se utiliza Future y async
  Future<User> apiRequest(String url, Map jsonMap) async {
    User obj = new User();
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(jsonMap)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();
    var resbody = json.decode(reply);
    //Captura los datos del Post
    obj.username = username = resbody['username'];
    obj.type = type = resbody['type'];
    obj.tokens = type = resbody['token'];
    httpClient.close();
    //retorna un String
    return obj;
  }
}