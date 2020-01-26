import 'package:cinema/login.dart';
import 'package:cinema/register.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class RegisterLogin extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
    return Scaffold(body: FlipCard(
      key: cardKey,
      flipOnTouch: false,
      direction: FlipDirection.HORIZONTAL, // default
      back:
      Column(
        children: <Widget>[
          Expanded(
            flex: 10,
            child: Register(),),
          Expanded(
            flex: 1,
            child:
            GestureDetector(
                child: Container(
                    width: double.infinity,
                    color: Colors.transparent,
                    child: Center(child: Text("ورود",style: TextStyle(fontSize: 16),))),
                onTap: () {
                  cardKey.currentState.toggleCard();
                }),
          )
        ],
      ),
      front: Column(
        children: <Widget>[
          Expanded(
            flex: 10,
            child: Login(),),
          Expanded(
            flex: 1,
            child:
            GestureDetector(
                child: Container(
                  width: double.infinity,
                  color: Colors.transparent,
                    child: Center(child: Text("ثبت نام",style: TextStyle(fontSize: 16),))),
                onTap: () {
                  cardKey.currentState.toggleCard();
                }),
          )
        ],
      ),
    ));
  }
}
