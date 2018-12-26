class UserInfo {
  String _token;
  UserInfo(this._token);

  UserInfo.map(dynamic obj) {
    this._token = obj['token'];
  }

  String get token => _token;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_token != null) {
      map['token'] = _token;
    }
    return map;
  }

  UserInfo.fromMap(Map<String, dynamic> map) {
    this._token = map['token'];
  }
}
