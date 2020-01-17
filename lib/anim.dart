import 'package:cinema/button.dart';
import 'package:flutter/material.dart';
class Anim extends StatefulWidget {
  @override
  _AnimState createState() => _AnimState();
}

class _AnimState extends State<Anim> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: ButtonAnimation()),
    );
  }
}
