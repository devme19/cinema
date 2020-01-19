import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin{
  Animation<double> scaleAnimation,scaleAnimation2;
  AnimationController scaleController,scaleController2;
  Animation<double> sizeAnimation,sizeAnimation2;
  Animation<double> buttonAnimation;
  AnimationController buttonController;

  int animationDuration = 400;
  String mobileNumber;
  Interval _getInternalInterval(
      double start,
      double end,
      double externalStart,
      double externalEnd, [
        Curve curve = Curves.linear,
      ]) {
    return Interval(
      start + (end - start) * externalStart,
      start + (end - start) * externalEnd,
      curve: curve,
    );
  }

  @override
  void initState() {
    super.initState();
    scaleController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: animationDuration),
    );
    scaleController2 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: animationDuration),
    );
    scaleAnimation = Tween<double>(
      begin: 0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: scaleController,
      curve: _getInternalInterval(
          0, .2, Interval(0, .85).begin, Interval(0, .85).end, Curves.easeOutBack),
    ));
    scaleAnimation2 = Tween<double>(
      begin: 0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: scaleController2,
      curve: _getInternalInterval(
          0, .2, Interval(0, .85).begin, Interval(0, .85).end, Curves.easeOutBack),
    ));
    scaleAnimation..addListener((){
      if(scaleAnimation.status == AnimationStatus.completed)
        scaleController2.forward();
    });
    buttonController = AnimationController(duration: Duration(milliseconds: 400) , vsync: this);


    buttonAnimation = Tween<double>(begin: 300,end: 60).animate(buttonController)
      ..addListener((){
//      if(animation.status == AnimationStatus.completed)
//        controller.reverse();
        setState(() {

        });
      });
    sizeAnimation = Tween<double>(
      begin: 48.0,
      end: 350,
    ).animate(CurvedAnimation(
      parent: scaleController,
      curve: _getInternalInterval(
          .2, 1.0, Interval(0, .85).begin, Interval(0, .85).end, Curves.linearToEaseOut),
      reverseCurve: Curves.easeInExpo,
    ));
    sizeAnimation2 = Tween<double>(
      begin: 48.0,
      end: 350,
    ).animate(CurvedAnimation(
      parent: scaleController2,
      curve: _getInternalInterval(
          .2, 1.0, Interval(0, .85).begin, Interval(0, .85).end, Curves.linearToEaseOut),
      reverseCurve: Curves.easeInExpo,
    ));
  }

  @override
  Widget build(BuildContext context) {
    scaleController.forward();

    return
    Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Center(
        child: Container(
          width: 300,
          margin: EdgeInsets.only(top: 300),
          child:
          Column(
            children: <Widget>[
              ScaleTransition(
                scale: scaleAnimation,
                child: AnimatedBuilder(
                  animation: sizeAnimation,
                  builder: (context, child) => ConstrainedBox(
                    constraints: BoxConstraints.tightFor(width: sizeAnimation.value),
                    child: child,
                  ),
                  child:Container(
                    margin: EdgeInsets.all(8),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        onSaved: (String val){
                          mobileNumber = val;
                        },
                        textInputAction: TextInputAction.done,
                        decoration: new InputDecoration(
                          labelText: "موبایل",
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(
                                color: Colors.pink,
                                style: BorderStyle.solid,
                                width: 50
                            ),
                          ),
                          //fillColor: Colors.green
                        ),
                        keyboardType: TextInputType.phone,
                        style: new TextStyle(
                          fontFamily: "Poppins",
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              ScaleTransition(
                scale: scaleAnimation2,
                child: AnimatedBuilder(
                  animation: sizeAnimation2,
                  builder: (context, child) => ConstrainedBox(
                    constraints: BoxConstraints.tightFor(width: sizeAnimation2.value),
                    child: child,
                  ),
                  child:Container(
//                              margin: EdgeInsets.all(5),
                    child:Container(
                      margin: EdgeInsets.only(top: 30,left: 8,right: 8),
                      child: InkWell(
                        borderRadius: new BorderRadius.all(const Radius
                            .circular(30.0)),
                        onTap: (){
                        },
                        child: Center(
                          child: Container(
                            height: 60,
                            width: buttonAnimation.value,
                            alignment: FractionalOffset.center,
                            decoration: new BoxDecoration(
                                color: const Color.fromRGBO(247, 64, 106, 1.0),
                                borderRadius: new BorderRadius.all(const Radius
                                    .circular(30.0))
                            ),
                            child: buttonAnimation.value > 75.0
                                ? new Text(
                              "ورود",
                              style: new TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w300,
                                letterSpacing: 0.3,
                              ),
                            ) : CircularProgressIndicator(
                              value: null,
                              strokeWidth: 1.0,
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );

  }
}
