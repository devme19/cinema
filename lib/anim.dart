import 'package:cinema/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';

import 'moviesList.dart';
class Anim extends StatefulWidget {
  @override
  _AnimState createState() => _AnimState();
}

class _AnimState extends State<Anim> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginScreen(),
    );
  }
}
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'ECORP',
      logo: 'assets/images/ecorp.png',
      onLogin: (_) => Future(null),
      onSignup: (_) => Future(null),
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => MoviesList (),
        ));
      },
      onRecoverPassword: (_) => Future(null),
    );
  }
}

