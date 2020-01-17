import 'package:cinema/movieDetail.dart';
import 'package:cinema/moviesList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      title: 'Flutter Demo',
      theme: ThemeData(
//        primarySwatch: Colors.deepPurple,
      ),
//      home: MyHomePage(title: 'Flutter Demo Home Page'),
      home: MoviesList()
//      home: MovieDetail(id: "3"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool badge = false;
  _handleTapChanged(bool newValue){
    setState(() {
      badge = newValue;
    });
  }
  final controller = ScrollController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        resizeToAvoidBottomPadding: false,
//      appBar: AppBar(
//        title: Text(widget.title),
//      ),
      body:
        Container(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: 350.0,
                floating: true,
                pinned: true,
//                flexibleSpace:FlexibleSpaceBar(
//                  background: HeaderDetail(),
//                )
              flexibleSpace:
                FlexibleSpaceBar(
                    title: Container(
//                      color: Color.fromRGBO(128, 0, 128, 0.1),
//                    margin: EdgeInsets.only(right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      crossAxisAlignment: CrossAxisAlignment.baseline,
                        children: <Widget>[
                          badge ? Badge("۱۲"): Text(""),
                          Text("هزارتو",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold
                              )),

                        ],
                      ),
                      ),
                    background:
                        Image.network(
                          "https://cinematicket.org/build/images/hezarto/MazeFront.png",
                          fit: BoxFit.cover,
                        ),
                    ),
//                  bottom: TabBar(
//                    labelColor: Colors.black87,
//                    unselectedLabelColor: Colors.grey,
//                    tabs: [
//                      new Tab(icon: new Icon(Icons.info), text: "Tab 1"),
//                      new Tab(
//                          icon: new Icon(Icons.lightbulb_outline), text: "Tab 2"),
//                    ],
//                  ),
              ),
              SliverFillRemaining(
                fillOverscroll: true,
                hasScrollBody: false,
                child:  Column(
                  children: <Widget>[
                    HeaderDetail(),
                    ButtonsRow(badge: badge,onChanged: _handleTapChanged),
                    DetailSection(),
                  ],
                ),
              )
            ],
//        Column(
//          mainAxisAlignment: MainAxisAlignment.start,
//          children: <Widget>[
//            HeaderDetail(),
//            ButtonsRow(),
//          ],
//        ),
          ),
        ),
    );
  }
}

class HeaderDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      Container(
        height: 200,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: [0.1, 1],
                colors: [
                  Colors.brown,
                  Colors.deepOrange,
                ]
            )
        ),
        child:
          Container(
            margin: EdgeInsets.only(left: 20,top: 20,right: 20,bottom: 20),
            child: Column(

              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(' برای امتیاز دادن با کاربری خود وارد شوید    ',style: TextStyle(fontSize: 10,color: Colors.lightGreenAccent)),
                    Text('۴.۲ /۵',style: TextStyle(color: Colors.white )),
                    Text(' : امتیاز کاربران',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                      Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(right: 15),
                      width: 55,
                      height: 20,
                      color: Colors.black,
                      child: Text('اجتماعی',style: TextStyle(color: Colors.white,fontSize: 11),textAlign: TextAlign.center,),
                    ),
                    Text(' : ژانر',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text('امیرحسین ترابی',style: TextStyle(color: Colors.white )),
                    Text(' : کارگردان',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text('سپهر صیفی',style: TextStyle(color: Colors.white )),
                    Text(' : تهیه کننده',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text('۱۳۹۸',style: TextStyle(color: Colors.white )),
                    Text(' : سال ساخت',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(' دقیقه ',style: TextStyle(color: Colors.white )),
                    Text(' ۸۰',style: TextStyle(color: Colors.white )),
                    Text(' : زمان ',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                  ],
                ),


              ],
            ),
          ),
      );
  }
}
class ButtonsRow extends StatefulWidget {
  final bool badge;
  final ValueChanged<bool> onChanged;
  ButtonsRow({Key key,this.badge:false,@required this.onChanged});
  @override
  _ButtonsRowState createState() => _ButtonsRowState();
}

class _ButtonsRowState extends State<ButtonsRow> {
  bool badge = false;

  _changeState(){
      widget.onChanged(!widget.badge);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[

          new GestureDetector(
            child: button(Colors.amber, 'دیدگاه ها'),
            onTap: _changeState,
          ),
          new GestureDetector(
            child: button(Colors.redAccent, 'نمایش تیزر'),
          ),
          new GestureDetector(
            child: button(Colors.green, 'خرید بلیط'),
          ),
        ],
      ),
    );
  }
}
class DetailSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(': بازیگران',style: TextStyle(fontWeight: FontWeight.bold),),
          Text('شهاب حسینی، ساره بیات، غزاله نظر، پژمان جمشیدی، فریبا جدیکار، علیرضا ثانی فر، مریم معصومی، شیرین یزدان بخش، مهسا باقری',textAlign: TextAlign.right,),
          Text(': خلاصه داستان',style: TextStyle(fontWeight: FontWeight.bold),),
          Text('زندگی یه هزارتوی پیچیدس ، همه آدما دنبال راهی برای فرار هستند اما فقط یه مسیر خروج وجود داره و تا موقعی که به مرکزش نرسی متوجه اش نمی شی!',textAlign: TextAlign.right,),
          Text(': سایر عوامل ',style: TextStyle(fontWeight: FontWeight.bold),),
//          Text('نویسنده: طلا معتضدی، مجری‌طرح و مدیرتولید: حسین اکبری، تدوین: سپیده عبدالوهاب، مدیر صدابرداری: داریوش صادقپور، طراح صحنه: حجت اشتری، صداگذاری: علیرضا علویان، طراح گریم: سیدجلال موسوی، طراح لباس: ندا نصر، دستیار اول کارگردان و برنامه‌ریز: حسین فلاح، جلوه‌های بصری: وحید قطبی‌زاده، جلوه‌های ویژه میدانی: آرش آقابیگ، جانشین‌تولید و مدیر تدارکات: امیر یمینی، منشی صحنه: ماریا میرنژاد، دستیار اول فیلمبردار: مجتبی شادرو، گروه فیلمبرداری: مسعود عباسی، محمد نصیری، حسن رحیمی، محمد بختیاری، مهدی علیزاده، گروه صحنه: رامین کرد علی‌وند، مسعود حاجی‌عباسی',textAlign: TextAlign.right,),
//          Text('نویسنده: طلا معتضدی، مجری‌طرح و مدیرتولید: حسین اکبری، تدوین: سپیده عبدالوهاب، مدیر صدابرداری: داریوش صادقپور، طراح صحنه: حجت اشتری، صداگذاری: علیرضا علویان، طراح گریم: سیدجلال موسوی، طراح لباس: ندا نصر، دستیار اول کارگردان و برنامه‌ریز: حسین فلاح، جلوه‌های بصری: وحید قطبی‌زاده، جلوه‌های ویژه میدانی: آرش آقابیگ، جانشین‌تولید و مدیر تدارکات: امیر یمینی، منشی صحنه: ماریا میرنژاد، دستیار اول فیلمبردار: مجتبی شادرو، گروه فیلمبرداری: مسعود عباسی، محمد نصیری، حسن رحیمی، محمد بختیاری، مهدی علیزاده، گروه صحنه: رامین کرد علی‌وند، مسعود حاجی‌عباسی',textAlign: TextAlign.right,),

        ],
      ),
    );
  }
}
Widget button(Color color,String text){
  return Container(
    alignment: Alignment.center,
    width: 120,
    height: 40,
    padding: EdgeInsets.all(4),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.all(Radius.circular(7)),
    ),
    child: Text(text,style: TextStyle(color: Colors.white)),
  );
}
Widget Badge(String number){
  return Container(
    alignment: Alignment.center,
    width: 35,
    height: 35,
    decoration: BoxDecoration(
      color: Colors.deepOrange,
      shape: BoxShape.circle
    ),
    child: Text("+"+number,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),),
  );
}

//class MoviesList extends StatefulWidget {
//  final String title;
//  MoviesList({Key key, this.title}) : super(key: key);
//  @override
//  _MoviesListState createState() => _MoviesListState();
//}
//
//class _MoviesListState extends State<MoviesList> {
//  List moviesUrl=[
//    "https://cdn.cinematicket.org/images/filmposter/98/jandarposter.jpg",
//    "https://cdn.cinematicket.org/images/filmposter/98/dast-ha.jpg",
//    "https://cdn.cinematicket.org/images/filmposter/98/dokhtarshirazi.jpg",
//    "https://cinematicket.org/build/images/akharinDastan/web12.png",
//    "https://cdn.cinematicket.org/images/filmposter/98/leilaj2.jpg",
//    "https://cdn.cinematicket.org/images/filmposter/98/maakoosss.jpg",
//    "https://cinematicket.org/build/images/cheshmOgoshBaste/001.png",
//    "https://cdn.cinematicket.org/images/filmposter/98/-Symphony-no-9-copy-(2).jpg",
//    "https://cinematicket.org/build/build/images/motreb/01.jpg",
//    "https://cdn.cinematicket.org/images/filmposter/98/Torna2.jpg",
//    "https://cdn.cinematicket.org/images/filmposter/98/beniamin.jpg",
//    "https://cdn.cinematicket.org/images/filmposter/98/13980801105540541187315910.jpg",
//    "https://cinematicket.org/build/images/hezarto/MazeFront.png",
//    "https://cinematicket.org/build/images/maskharebaz/Characters.jpg",
//    "https://cdn.cinematicket.org/images/filmposter/98/DARKHOONGAH--120-x-180---Design-01.jpg",
//    "https://cdn.cinematicket.org/images/filmposter/98/jandarposter.jpg",
//    "https://cdn.cinematicket.org/images/filmposter/98/dast-ha.jpg",
//    "https://cdn.cinematicket.org/images/filmposter/98/dokhtarshirazi.jpg",
//    "https://cinematicket.org/build/images/akharinDastan/web12.png",
//    "https://cdn.cinematicket.org/images/filmposter/98/leilaj2.jpg",
//    "https://cdn.cinematicket.org/images/filmposter/98/maakoosss.jpg",
//    "https://cinematicket.org/build/images/cheshmOgoshBaste/001.png",
//    "https://cdn.cinematicket.org/images/filmposter/98/-Symphony-no-9-copy-(2).jpg",
//    "https://cinematicket.org/build/build/images/motreb/01.jpg",
//    "https://cdn.cinematicket.org/images/filmposter/98/Torna2.jpg",
//    "https://cdn.cinematicket.org/images/filmposter/98/beniamin.jpg",
//    "https://cdn.cinematicket.org/images/filmposter/98/13980801105540541187315910.jpg",
//    "https://cinematicket.org/build/images/hezarto/MazeFront.png",
//    "https://cinematicket.org/build/images/maskharebaz/Characters.jpg",
//    "https://cdn.cinematicket.org/images/filmposter/98/DARKHOONGAH--120-x-180---Design-01.jpg"
//  ];
//  int columnCount = 3;
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        appBar: AppBar(
//
//        title:Align(
//          alignment: Alignment.centerRight,
//          child: Text(widget.title),
//        ) ,
//      ),
//      backgroundColor: Color.fromRGBO(250, 250, 250, 0.95),
//      body: GridView.builder(
//        itemCount: moviesUrl.length,
//        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount( crossAxisCount: 2,crossAxisSpacing: 2,mainAxisSpacing: 2),
//        itemBuilder: (context, index) {
//          return AnimationConfiguration.staggeredGrid(
//            position: index,
//            duration: const Duration(milliseconds: 300),
//            columnCount: columnCount,
//            child: ScaleAnimation(
//              child: FadeInAnimation(
//                  child:
//                  Container(
//                      decoration: BoxDecoration(
//                        color: Colors.white,
//                        shape: BoxShape.rectangle,
////                        border: Border.all(
////                            color: Colors.blueGrey,
////                            width: 1
////                        ),
//                        borderRadius: BorderRadius.circular(2),
//                      ),
//                      child: Column(
//                        crossAxisAlignment: CrossAxisAlignment.stretch,
//                        mainAxisSize: MainAxisSize.max,
//                        children: <Widget>[
//                          Expanded(
//                            child: Image.network(moviesUrl[index], fit: BoxFit.fill,),
//                          ),
////                          Container(
//////                            margin: EdgeInsets.only(top: 10,bottom: 5),
////                          padding: EdgeInsets.all(5),
////                            child: Center(
////                              child:  Text("س $index",style: TextStyle(fontSize: 13,color: Colors.blueAccent),),
////                            ),
////                          )
//
//                        ],
//                      )
//                  )
//              ),
//            ),
//          );
//        },
//      ),
//    );
//
//  }




