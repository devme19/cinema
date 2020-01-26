import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LoginAuth {
  String token;
  LoginAuth({this.token});

  factory LoginAuth.fromJson(Map<String, dynamic> json){
    return new LoginAuth(
      token: json['token'],
    );
  }
  LoginAuth parseData(String responseBody,String userName){
    final parsed = json.decode(responseBody);
    Map<String, dynamic> response = parsed;
    LoginAuth aut = LoginAuth.fromJson(response);
    if(aut.token!=null){
      setToken(aut.token);
      setUserName(userName);
    }

    return aut;
//  return parsed.map<Movie>((json) => Movie.fromJson(json));
  }
  setToken(String token) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('TOKEN', token);
  }
  setUserName(String userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('USERNAME', userName);
  }

}