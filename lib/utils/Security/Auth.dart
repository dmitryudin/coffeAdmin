import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Auth {
  static final Auth _auth = Auth._instance();

  factory Auth() {
    return _auth;
  }
  Auth._instance();

  String _login = '';
  String _password = '';
  String accessToken = '';
  String _refreshToken = '';
  int _lifeTimeInSeconds = 1;
  bool isAuthFlag = false;
  String _authUrl = '';
  String _refreshTokenUrl = '';

  late var box;
  late void Function({required bool isAuthFlag}) callback;

  void updateToken() {
    Timer(Duration(milliseconds: _lifeTimeInSeconds * 1000), () async {
      var r = await post(Uri.parse(_refreshTokenUrl),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $_refreshToken',
          },
          body: '{}');

      if (r.statusCode == 200) {
        Map<String, dynamic> jsonString = jsonDecode(r.body);
        accessToken = jsonString['access_token'];
        box.put('accessToken', accessToken);
      }
      if (r.statusCode == 422 || r.statusCode == 401)
        callback(isAuthFlag: false);

      updateToken();
    });
  }

  void logIn({required String login, required String password}) async {
    print('login $login');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$login:$password'));

    Response r = await get(Uri.parse(_authUrl),
        headers: <String, String>{'authorization': basicAuth});
    if (r.statusCode == 200) {
      Map<String, dynamic> jsonString = jsonDecode(r.body);
      _login = login;
      _password = password;
      _lifeTimeInSeconds = jsonString['lifetime'];
      accessToken = jsonString['access_token'];
      _refreshToken = jsonString['refresh_token'];
      box.put('login', _login);
      box.put('password', _password);
      box.put('accessToken', accessToken);
      box.put('refreshToken', _refreshToken);
      callback(isAuthFlag: true);
      updateToken();
    } else if (r.statusCode == 404) {
      callback(isAuthFlag: false);
      throw Exception('Exception on Auth: user is not found');
    } else {
      callback(isAuthFlag: false);
    }
  }

  void logOut() {
    _login = '';
    _password = '';
    _refreshToken = '';
    accessToken = '';
    box.put('login', '');
    box.put('password', '');
    box.put('accessToken', '');
    box.put('refreshToken', '');
    callback(isAuthFlag: false);
  }

  void init(
      {required void Function({required bool isAuthFlag}) callback,
      required String authUrl,
      required String refreshTokenUrl}) async {
    await Hive.initFlutter();
    box = await Hive.openBox('Security');
    this.callback = callback;
    _authUrl = authUrl;
    _refreshTokenUrl = refreshTokenUrl;

    this.callback(isAuthFlag: isAuthFlag);
    // accessToken = box.get('secToken');
    // refreshToken = box.get('refreshToken');

    //Тут мы проверяем запрос есть ли авторизация
    //если авторизации нету, но есть логин и пароль, то стучимся к jwt
  }
}
