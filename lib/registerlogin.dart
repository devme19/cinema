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
                child: Text("ورود"),
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
                child: Text("ثبت نام"),
                onTap: () {
                  cardKey.currentState.toggleCard();
                }),
          )
        ],
      ),
    ));
  }
}
