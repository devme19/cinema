import 'package:cinema/postdata.dart';
import 'package:flutter/material.dart';


class RegisterLogin extends StatefulWidget {
  @override
  _RegisterLoginState createState() => _RegisterLoginState();
}

class _RegisterLoginState extends State<RegisterLogin>  with TickerProviderStateMixin{

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
  Animation<double> buttonAnimation;
  AnimationController buttonController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    animation = Tween<Offset>(
      begin: Offset(1.2, 0),
      end: Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.linearToEaseOut,
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
  }

  @override
  Widget build(BuildContext context) {



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
                        Container(
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
                        Container(
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
                        Container(
                          margin: EdgeInsets.all(8),
                          child: Directionality(
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
                        SlideTransition(
                          position: buttonDownAnimation,
                          child:
                          Container(
                            margin: EdgeInsets.only(top: 30,left: 8,right: 8),
                            child: InkWell(
                              borderRadius: new BorderRadius.all(const Radius
                                  .circular(30.0)),
                              onTap: (){
                                if(status == 0){

                                  buttonController.forward();
                                  buttonDownController.forward();
                                  map["name"] = name;
                                  map["lastName"] = lastName;
                                  map["mobileNumber"] = mobileNumber;
                                  postData(map);
                                  if(_formKey.currentState.validate()){
                                    Scaffold.of(context).showSnackBar(SnackBar(content: Text('در حال پردازش',textDirection: TextDirection.rtl,),));

                                  }
                                  setState(() {
                                    status = 1;
                                    animationController.forward();
                                  });
                                }
                                else
                                if(status == 1) {

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
