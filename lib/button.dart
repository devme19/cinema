import 'package:flutter/material.dart';

class ButtonAnimation extends StatefulWidget {
  @override
  _ButtonAnimationState createState() => _ButtonAnimationState();
}

class _ButtonAnimationState extends State<ButtonAnimation> with SingleTickerProviderStateMixin{

  Animation<double> animation;
  AnimationController controller;


  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: Duration(seconds: 1) , vsync: this);
    animation = Tween<double>(begin: 300,end: 60).animate(controller)
      ..addListener((){
//      if(animation.status == AnimationStatus.completed)
//        controller.reverse();
        setState(() {

        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return
      Container(
          height: 60,
          width:animation.value,
          alignment: FractionalOffset.center,
          decoration: new BoxDecoration(
              color: const Color.fromRGBO(247, 64, 106, 1.0),
              borderRadius:new BorderRadius.all(const Radius.circular(30.0))
          ),
          child:
          GestureDetector(
            onTap: (){
              controller.forward();
            },
            child: animation.value > 75.0
                ? new Text(
              "Sign In",
              style: new TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w300,
                letterSpacing: 0.3,
              ),
            ):CircularProgressIndicator(
              value: null,
              strokeWidth: 1.0,
              valueColor: new AlwaysStoppedAnimation<Color>(
                  Colors.white),
            ),
          )
      );
  }
}
