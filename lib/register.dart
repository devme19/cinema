import 'package:cinema/postdata.dart';
import 'package:flutter/material.dart';


class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register>  with TickerProviderStateMixin{

  final _formKey = GlobalKey<FormState>();
  final FocusNode emailFocus = FocusNode();
  final FocusNode nameFocus = FocusNode();
  final FocusNode lastNameFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  final FocusNode submitFocus = FocusNode();
  bool activeMobileNumber = false;
  Animation<Offset> animation;
  Animation<Offset> buttonDownAnimation;
  AnimationController buttonDownController;
  AnimationController animationController;
  Map map;
  String name,lastName,mobileNumber;
  MyResponse myResponse;
  TextEditingController textEditingController;
  String labelText = 'ثبت نام';

  int status = 0;
  int animationDuration = 400;
  Animation<double> buttonAnimation;
  AnimationController buttonController;


  Animation<double> scaleAnimation,scaleAnimation2,scaleAnimation3,scaleAnimation4;
  AnimationController scaleController,scaleController2,scaleController3,scaleController4;
  Animation<double> sizeAnimation,sizeAnimation2,sizeAnimation3,sizeAnimation4;




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
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: animationDuration),
    );
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
    scaleController4 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: animationDuration),
    );
    animation = Tween<Offset>(
      begin: Offset(1.2, 0),
      end: Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.linearToEaseOut,
    ));
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
    scaleAnimation4 = Tween<double>(
      begin: 0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: scaleController4,
      curve: _getInternalInterval(
          0, .2, Interval(0, .85).begin, Interval(0, .85).end, Curves.easeOutBack),
    ));
    buttonDownAnimation = Tween<Offset>(
      begin: Offset(0.0, 0.0),
      end: Offset(0.0, 0.7),
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.linearToEaseOut,
    ));
    map = new Map<String, dynamic>();
    textEditingController = TextEditingController();

    buttonDownController = AnimationController(duration: Duration(seconds: 5) , vsync: this);
    buttonController = AnimationController(duration: Duration(milliseconds: 400) , vsync: this);
    buttonAnimation = Tween<double>(begin: 300,end: 60).animate(buttonController)
      ..addListener((){
//      if(animation.status == AnimationStatus.completed)
//        controller.reverse();
        setState(() {

        });
      });
    scaleAnimation..addListener((){
      if(scaleAnimation.status == AnimationStatus.completed)
        scaleController2.forward();
    });
    scaleAnimation2..addListener((){
      if(scaleAnimation2.status == AnimationStatus.completed)
        scaleController3.forward();
    });
    scaleAnimation3..addListener((){
      if(scaleAnimation3.status == AnimationStatus.completed)
        scaleController4.forward();
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
    sizeAnimation4 = Tween<double>(
      begin: 48.0,
      end: 350,
    ).animate(CurvedAnimation(
      parent: scaleController4,
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
      body:
      Builder(
        builder: (context) =>
            Form(
          key: _formKey,
          child: Center(
            child:
            Container(
              width: 300,
              margin: EdgeInsets.only(top: 150),
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                    Radius.circular(20.0)
                ),
//                color: Colors.pink,
              ),
                child:
               SingleChildScrollView(
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
                                  onSaved: (String val){
                                    name = val;
                                  },
                                  textInputAction: TextInputAction.done,
                                  focusNode: nameFocus,
                                  decoration: new InputDecoration(
                                    labelText: "نام",
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
                                  onFieldSubmitted: (term){
                                    FocusScope.of(context).requestFocus(lastNameFocus);
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
                                  onSaved: (String val){
                                    lastName = val;
                                  },
                                  textInputAction: TextInputAction.done,
                                  focusNode: lastNameFocus,
                                  decoration: new InputDecoration(
                                    labelText: "نام خانوادگی",
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
                                  onFieldSubmitted: (term){
                                    FocusScope.of(context).requestFocus(phoneFocus);
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
                          scale: scaleAnimation3,
                          child: AnimatedBuilder(
                            animation: sizeAnimation3,
                            builder: (context, child) => ConstrainedBox(
                              constraints: BoxConstraints.tightFor(width: sizeAnimation3.value),
                              child: child,
                            ),
                            child:Container(
                              margin: EdgeInsets.all(8),
                              child:
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: TextFormField(
                                  onSaved: (String val){
                                    mobileNumber = val;
                                  },
                                  textInputAction: TextInputAction.done,
                                  focusNode: phoneFocus,
                                  decoration: new InputDecoration(
                                    hintText: "09121234567",
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
                                  validator: validatePhone,
                                  onFieldSubmitted: (term){
                                    FocusScope.of(context).requestFocus(emailFocus);
                                    // _fieldFocusChange(context, userNameFocus, passwordFocus);
                                  },
                                  keyboardType: TextInputType.phone,
                                  style: new TextStyle(
                                    fontFamily: "Poppins",
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        status == 0 ? Container() : SlideTransition(
                          position: animation,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 8,top: 8,left: 8,right: 8),
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextFormField(
                                controller: textEditingController,
                                textInputAction: TextInputAction.done,
                                decoration: new InputDecoration(
                                  labelText: "کد فعال سازی",
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

                        ScaleTransition(
                          scale: scaleAnimation4,
                          child: AnimatedBuilder(
                            animation: sizeAnimation4,
                            builder: (context, child) => ConstrainedBox(
                              constraints: BoxConstraints.tightFor(width: sizeAnimation4.value),
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
                                    if(status == 0){


                                      if(_formKey.currentState.validate()){
                                        Scaffold.of(context).showSnackBar(SnackBar(content: Text('در حال پردازش',textDirection: TextDirection.rtl,),));
                                        buttonController.forward();
                                        buttonDownController.forward();
                                        map["name"] = name;
                                        map["lastName"] = lastName;
                                        map["mobileNumber"] = mobileNumber;
                                        postData(map);
                                        setState(() {
                                          status = 1;
                                          animationController.forward();
                                        });
                                      }

                                    }
                                    else
                                    if(status == 1) {
                                      Scaffold.of(context).showSnackBar(SnackBar(content: Text('در حال پردازش',textDirection: TextDirection.rtl,),));
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
                                        labelText,
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
                ),
            ),
        ),
      ),

    );

  }

  Widget myTextFormFieldWithValidate(String title,TextInputType textInputType, bool what,FocusNode focusNode) {
    return
      Container(
        margin: EdgeInsets.all(8),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: TextFormField(
            textInputAction: TextInputAction.done,
            focusNode: focusNode,
          decoration: new InputDecoration(
            labelText: title,
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
          validator: what? validateEmail:validatePhone,
          keyboardType: textInputType,
          style: new TextStyle(
            fontFamily: "Poppins",
          ),
    ),
        ),
      );
  }
  Widget myTextFormField(String title, FocusNode focusNode) {
    return
      Container(
        margin: EdgeInsets.all(8),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: TextFormField(
            textInputAction: TextInputAction.done,
            focusNode: focusNode,
            decoration: new InputDecoration(
              labelText: title,
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
            keyboardType: TextInputType.text,
            style: new TextStyle(
              fontFamily: "Poppins",
            ),
          ),
        ),
      );
  }
  String validateEmail(String value) {
      String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp = new RegExp(pattern);
      if (value.length == 0) {
        return "وارد کردن ایمیل الزامی است";
      } else if(!regExp.hasMatch(value)){
        return "ایمیل نامعتبر است";
      }else {
        return null;
      }
  }
//  test
  String validatePhone(String value) {
    if(value.length != 11)
      return "شماره همراه صحیح نمی باشد";
    else
      return null;
  }
  bool postData(Map map) {
    myResponse = new MyResponse();
    myResponse.myPost(map).then((onValue){
      myResponse = onValue;

      Future<void>.delayed(Duration(seconds: 3), () {
        textEditingController.text = myResponse.activationCode.toString();
        setState(() {
          buttonController.reverse();
          status = 1;
          labelText = 'فعال سازی';
        });
      });



    });

    return false;
  }

}
