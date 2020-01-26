import 'dart:math';

import 'package:cinema/anim.dart';
import 'package:cinema/login.dart';
import 'package:cinema/moviesList.dart';
import 'package:cinema/register.dart';
import 'package:cinema/registerlogin.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GuillotineMenu extends StatefulWidget {
  @override
  _GuillotineMenuState createState() => _GuillotineMenuState();
}
enum _GuillotineAnimationStatus { closed, open, animating }
class _GuillotineMenuState extends State<GuillotineMenu> with SingleTickerProviderStateMixin{

  String userName = "کاربر مهمان";
  double rotationAngle = 0.0;
  double screenWidth,screenHeight;
  AnimationController animationControllerMenu;
  Animation<double> animationMenu;
  _GuillotineAnimationStatus menuAnimationStatus = _GuillotineAnimationStatus.closed;
  Animation<double> animationTitleFadeInOut;
  _handleMenuOpenClose() {
    if (menuAnimationStatus == _GuillotineAnimationStatus.closed){
      animationControllerMenu.forward().orCancel;
    }
    else if (menuAnimationStatus == _GuillotineAnimationStatus.open){
      animationControllerMenu.reverse().orCancel;
    }
  }

  @override
  void initState() {
    super.initState();

    animationControllerMenu = new AnimationController(
      duration: Duration(milliseconds: 1000),
        vsync: this)..addListener((){
          setState(() {

          });
    })..addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        ///
        /// When the animation is at the end, the menu is open
        ///
        menuAnimationStatus = _GuillotineAnimationStatus.open;
      } else if (status == AnimationStatus.dismissed) {
        ///
        /// When the animation is at the beginning, the menu is closed
        ///
        menuAnimationStatus = _GuillotineAnimationStatus.closed;
      } else {
        ///
        /// Otherwise the animation is running
        ///
        menuAnimationStatus = _GuillotineAnimationStatus.animating;
      }
    });
    animationTitleFadeInOut = new Tween(
        begin: 1.0,
        end: 0.0
    ).animate(new CurvedAnimation(
      parent: animationControllerMenu,
      curve: new Interval(
        0.0,
        0.5,
        curve: Curves.ease,
      ),
    ));
    getUserName();

  }
  Future<String> getUserName() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    userName = prefs.getString('USERNAME');
    if(userName==null)
      userName = 'کاربر مهمان';
    setState(() {
    });
    return userName;
  }

  @override
  void dispose() {
    animationControllerMenu.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    animationMenu = new Tween(
      begin: pi/2,
      end: 0.0,
    ).animate(new CurvedAnimation(parent: animationControllerMenu, curve: Curves.bounceOut, reverseCurve: Curves.bounceIn));
    MediaQueryData mediaQueryData = MediaQuery.of((context));
    screenWidth = mediaQueryData.size.width;
    screenHeight = mediaQueryData.size.height;
    double angle = animationMenu.value;
    return new Transform.rotate(
        angle: angle,
        origin: new Offset(-40, 40),
      alignment: Alignment.topRight,
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: screenWidth,
          height: screenHeight,
          color: Colors.blue,
          child: new Stack(
            children: <Widget>[
//              _buildMenuTitle(),
              _buildMenuIcon(),
              _buildMenuContent()
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildMenuTitle(){
    return new Positioned(
      top: 31,
        right: 40.0,
        width: screenWidth,
        height: 24.0,
        child: new Transform.rotate(
          alignment: Alignment.topLeft,
            origin: Offset.zero,
            angle: pi/2.0,
          child: new Center(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: new Opacity(
                  opacity: animationTitleFadeInOut.value,
                child: Text(
                  "منو",
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0
                  ),
                ),

              ),
            ),
          ),
        ),
    );
  }
  Widget _buildMenuIcon(){
    return new Positioned(
        right:15,
        top: 15,
        child:
        Transform.rotate(angle: pi/2,
          child: new IconButton(icon: Icon(Icons.menu,color: Colors.white,), onPressed: (){
            _handleMenuOpenClose();
          }),
        )
    );
  }
  Widget _buildMenuContent(){
    final List<Map> _menus = <Map>[
      {
        "icon":Icons.person,
        "title":"ورود",
        "color":Colors.white,
      },
      {
        "icon":Icons.person,
        "title":"پیگیری خرید",
        "color":Colors.white,
      },
      {
        "icon":Icons.person,
        "title":"تنظیمات",
        "color":Colors.white,
      },
      {
        "icon":Icons.person,
        "title":"سوالات متداول",
        "color":Colors.white,
      },
      {
        "icon":Icons.person,
        "title":"درباره ما",
        "color":Colors.white,
      },
      {
        "icon":Icons.person,
        "title":"تماس با ما",
        "color":Colors.white,
      },
    ];
    return

      Container(
        margin: EdgeInsets.all(80),
        width: double.infinity,
        height: double.infinity,
        child:
            ListView(

//              mainAxisAlignment: MainAxisAlignment.start,
              children:
              ListTile.divideTiles(
                color: Colors.white,
                  context: context,
                  tiles: [
                    ListTile(title: listTile(userName,null),onTap: () {
                    },),
                    ListTile(title: listTile("ورود",Icon(Icons.person,color: Colors.white,)), onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                          Login()));
                    },),
                    ListTile(title: listTile("پیگیری خرید",Icon(Icons.shop,color: Colors.white)),onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                              Anim()));
                    },),
                    ListTile(title: listTile("تنظیمات",Icon(Icons.settings,color: Colors.white))),
                    ListTile(title: listTile("سوالات متداول",Icon(Icons.question_answer,color: Colors.white))),
                    ListTile(title: listTile("درباره ما",Icon(Icons.group,color: Colors.white))),
                    ListTile(title: listTile("تماس با ما",Icon(Icons.call,color: Colors.white))),
                    ListTile(title: listTile("خروج",Icon(Icons.exit_to_app,color: Colors.white)),onTap: () {
                      logOut();
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                              MoviesList()));
                    },),
                  ]
              ).toList()
            ),
      );
  }
  Widget listTile(String title,Icon icon){
    return
      Padding(
        padding: const EdgeInsets.only(top:15,bottom: 15 ),
        child:
        Row(
          children: <Widget>[

            icon==null ? Expanded(flex:1,child: Text(title,textDirection: TextDirection.rtl,style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold),)):Expanded(flex:2,child: Text(title,textDirection: TextDirection.rtl,style: TextStyle(color: Colors.white),)),
            icon==null ? Container():Expanded(flex:1,child: icon),
          ],
        ),
      );
  }
  logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Remove String
    prefs.remove("TOKEN");
    //Remove bool
    prefs.remove("USERNAME");
    //Remove int
  }
}
