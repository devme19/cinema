import 'dart:math';

import 'package:cinema/loginAuth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'moviesList.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin{
  String TOKEN,tk="";
  Map map;
  final _formKey = GlobalKey<FormState>();
  final FocusNode passwordFocus = FocusNode();
  Animation<double> scaleAnimation,scaleAnimation2,scaleAnimation3;
  AnimationController scaleController,scaleController2,scaleController3;
  Animation<double> sizeAnimation,sizeAnimation2,sizeAnimation3;
  Animation<double> buttonAnimation;
  AnimationController buttonController;
  Animation<Offset> animation;
  TextEditingController userNameController;
  TextEditingController passwordController;
  bool errorLogin = false;

  int animationDuration = 650;
  String userName,password;
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
  String token;

  @override
  void initState() {
    super.initState();

    map = new Map<String, dynamic>();
    userNameController = TextEditingController();
    passwordController = TextEditingController();
    scaleController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: animationDuration),
    );
    scaleController2 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: animationDuration),
    );
    scaleController3 = AnimationController(
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
    scaleAnimation3 = Tween<double>(
      begin: 0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: scaleController3,
      curve: _getInternalInterval(
          0, .2, Interval(0, .85).begin, Interval(0, .85).end, Curves.easeOutBack),
    ));
    scaleAnimation..addListener((){
      if(scaleAnimation.status == AnimationStatus.completed)
        scaleController2.forward();
    });
    scaleAnimation2..addListener((){
      if(scaleAnimation2.status == AnimationStatus.completed)
        scaleController3.forward();
    });
    buttonController = AnimationController(duration: Duration(milliseconds: 200) , vsync: this);


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
    sizeAnimation3 = Tween<double>(
      begin: 48.0,
      end: 350,
    ).animate(CurvedAnimation(
      parent: scaleController3,
      curve: _getInternalInterval(
          .2, 1.0, Interval(0, .85).begin, Interval(0, .85).end, Curves.linearToEaseOut),
      reverseCurve: Curves.easeInExpo,
    ));
    getToken();
  }

  Future<String> getToken() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    token = prefs.getString('TOKEN');
    setState(() {
      tk= token;
    });
    return token;
  }
  @override
  Widget build(BuildContext context) {
    scaleController.forward();
    return
      Scaffold(
        resizeToAvoidBottomPadding: false,
        body:
        Builder(
          builder: (context) =>
              Form(
                key: _formKey,
                child: Center(
                  child:
                  SingleChildScrollView(
                    padding: EdgeInsets.all(50),
                    child:
                    Column(
                      mainAxisSize: MainAxisSize.max,
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
                                  controller: userNameController,
                                  textInputAction: TextInputAction.done,
                                  decoration: new InputDecoration(
                                    labelText: "نام کاربری",
                                    fillColor: Colors.white,

                                    border: new OutlineInputBorder(
                                      borderRadius: new BorderRadius.circular(25.0),
                                      borderSide: new BorderSide(
                                          color: Colors.red,
                                          style: BorderStyle.solid,
                                          width: 50
                                      ),
                                    ),
                                    //fillColor: Colors.green
                                  ),
                                  onFieldSubmitted: (term){
                                    FocusScope.of(context).requestFocus(passwordFocus);
                                    // _fieldFocusChange(context, userNameFocus, passwordFocus);
                                  },
                                  keyboardType: TextInputType.text,
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
                              margin: EdgeInsets.all(8),
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: TextFormField(
                                  obscureText: true,
                                  controller: passwordController,
                                  textInputAction: TextInputAction.done,
                                  focusNode: passwordFocus,
                                  decoration: new InputDecoration(
                                    labelText: "کلمه عبور",
                                    fillColor: Colors.white,

                                    border: new OutlineInputBorder(
                                      borderRadius: new BorderRadius.circular(25.0),
                                      borderSide: new BorderSide(
                                          color: Colors.red,
                                          style: BorderStyle.solid,
                                          width: 50
                                      ),
                                    ),
                                    //fillColor: Colors.green
                                  ),
                                  keyboardType: TextInputType.text,
                                  style: new TextStyle(
                                    fontFamily: "Poppins",
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        ScaleTransition(
                          scale: scaleAnimation3,
                          child: AnimatedBuilder(
                            animation: sizeAnimation3,
                            builder: (context, child) => ConstrainedBox(
                              constraints: BoxConstraints.tightFor(width: sizeAnimation3.value),
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
                                    if(_formKey.currentState.validate()){
                                      setState(() {
                                        errorLogin = false;
                                      });
                                      postData(userNameController.text,passwordController.text);
//                                          Scaffold.of(context).showSnackBar(SnackBar(content: Text('در حال پردازش',textDirection: TextDirection.rtl,),));
                                      buttonController.forward();
                                    }
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
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 60),
                          child: errorLogin?Text("نام کاربری یا کلمه عبور اشتباه است"):Text(""),
                        )

                      ],
                    ),
                  ),
                ),
              ),
        ),

      );

  }

  postData(String username,String password) {
    LoginAuth loginAuth = new LoginAuth();
    String baseUrl = "http://10.5.8.108:8000/^api-token-auth/";
    var client = http.Client();
    var request = http.Request('POST', Uri.parse(baseUrl));
    var body = {'username': username,'password': password};
    request.bodyFields = body;
    var future = client.send(request).then((response){
      Future<void>.delayed(Duration(seconds: 2), () {
        buttonController.reverse();
        response.stream.bytesToString().then((value){
          LoginAuth auth = loginAuth.parseData(value,userNameController.text);
          if(auth.token == null)
            setState(() {
              errorLogin = true;
            });
          else
            setState(() {
              errorLogin = false;
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>
                      MoviesList()));
            });
          print("token is:"+auth.token);
        }).catchError((error){
          print(error.toString());
        });
        });


    });
  }
  String validatePhone(String value) {
    if(value.length != 11)
      return "شماره همراه صحیح نمی باشد";
    else
      return null;
  }


}
