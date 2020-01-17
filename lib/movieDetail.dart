import 'package:cinema/buyTicket.dart';
import 'package:cinema/ratingbar.dart';
import 'package:flutter/material.dart';
import 'package:cinema/Movie.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_view_indicators/page_view_indicators.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'guillotineMenu.dart';

String filmCode;
class MovieDetail extends StatefulWidget {
  final String id;
  MovieDetail({Key key,@required this.id}): super(key:key);
  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  Map map;
  Movie movieItem;
  bool error = false;
  bool isLoading = true;
  final _pageController = PageController();
  final _currentPageNotifier = ValueNotifier<int>(0);
  ScrollController scrollController;
  AppBar appBar;
  double appBarHeight;
  double _expandedHeight = 346;
  @override
  void initState() {
    super.initState();
    map = new Map<String, dynamic>();
    map["id"] =  widget.id;
    filmCode = widget.id;
    movieItem = new Movie();
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
    appBar = new AppBar();
    appBarHeight = appBar.preferredSize.height;

//    fetchData();
  }
  _scrollListener(){
    if(scrollController.offset >= _expandedHeight - appBarHeight){
      _currentPageNotifier.value = 0;
    }
  }
  Future<bool> fetchData() async {
//    if (!isLoading){
//      setState(() {
//        isLoading = true;
//      });
//    }
    await Future.delayed(Duration(seconds: 0, milliseconds: 1000));
    _fetchData();
    return true;

  }
  bool _fetchData() {
    getMovie("movie_detail",map).then((onValue){
      movieItem = onValue;
      if(movieItem.limit != "")
        badge = true;
      setState(() {
        isLoading = false;
      });
      return true;
    },onError:(e){
      setState(() {
//        isLoading = false;
        error = true;
      });
    });
    return false;
  }
  bool badge = false;
  final controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return


      Scaffold(
//      resizeToAvoidBottomPadding: false,
//      appBar: AppBar(
////        title: Text(widget.title),
//      ),
      body:
      FutureBuilder<Movie>(
          future: getMovie("movie_detail",map),
          builder:
              (context,snapshot){
            switch (snapshot.connectionState){
              case ConnectionState.waiting: return Center(child:new SpinKitCubeGrid( color: Colors.pink,size: 50.0),);
              default:
                if(snapshot.hasError){
                  return errorBox("خطا در برقراری ارتباط");

                }
                else {
                  isLoading = false;
                  movieItem = snapshot.data;
                  return buildViews();
                }
            }
          })

//      isLoading?
//          Center(
//            child: SpinKitCubeGrid(
//              color: Colors.pink,
//              size: 50.0,
//            ),
//          )
//      :

    );
  }
  Widget buildViews(){
    return Container(
      child:
      CustomScrollView(
        controller: scrollController,
        slivers: <Widget>[
          SliverAppBar(
//            iconTheme: IconThemeData(
//              color: Colors.blueGrey, //change your color here
//            ),

            expandedHeight: _expandedHeight,
            floating: false,
            pinned: true,
snap: false,

//                flexibleSpace:FlexibleSpaceBar(
//                  background: HeaderDetail(),
//                )
            flexibleSpace:
            FlexibleSpaceBar(
//                collapseMode: CollapseMode.pin,
                title: Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(0, 128, 255, 0.15),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      bottomLeft: Radius.circular(40.0),
                    )
                  ),
                  padding: EdgeInsets.all(2),

//                  margin: EdgeInsets.only(right: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
//                      crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: <Widget>[
                      !badge ? Badge("۱۲"): Text(""),
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Text(movieItem.title,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold
                            )),
                      ),

                    ],
                  ),
                ),
                background:
                viewPager()

            ),
          ),
          SliverFillRemaining(
            fillOverscroll: true,
            hasScrollBody: false,
            child:  Column(
              children: <Widget>[
                HeaderDetail(movieItem: movieItem),
                ButtonsRow(),
                DetailSection(movieItem: movieItem),
              ],
            ),
          )
        ],
      ),
    );
  }
  Widget errorBox(String title){
    return Center(
      child: Container(
          width: 150,
          height: 130,
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: Colors.purple,
            ),
            borderRadius: new BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight:  Radius.circular(20)),
          ),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                    width: double.infinity,
                    color: Colors.purple,
                    child: Align(
                        alignment:Alignment.centerRight,
                        child: Padding(
                            child: Text("خطا",style: TextStyle(color:Colors.white),),
                            padding: EdgeInsets.only(right: 10)))
                ),
              ),
              Expanded(
                child: Container(
                  child: Center(
                    child: Text(title,style: TextStyle(
                        fontSize: 14,color: Colors.black
                    ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  //margin: EdgeInsets.only(left: 20.0,right: 20.0,top: 50.0),
                    child: Center(
                      child: IconButton(
                          icon: Icon(Icons.refresh),
                          onPressed: (){
//                            setState(() {
//                              error = false;
//                              fetchData();
//                            });
                          }
                      ),
                    )
                ),
              )

            ],
          )
      ),
    );
  }
  Widget viewPager(){

    return 
      Column(
          children: <Widget>[
                Expanded(
                  flex: 15,
                  child: Container(
//                    height: 373,
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (index){
                        _currentPageNotifier.value = index;
                      },
                      children: <Widget>[
                        Image.network(
                          movieItem.imageUrl,
                          fit: BoxFit.cover,
                        ),
                        WebView(
                            javascriptMode: JavascriptMode.unrestricted,
                            initialUrl: movieItem.trailerUrl)
                      ],
                    ),
                  ),
                ),

                Expanded(
                  flex: 1,
                  child:
                    Container(
//                      height: 5,
                      width: MediaQuery.of(context).size.width,
                      color: Color.fromRGBO(38, 38, 38, 1),
                      child:
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: CirclePageIndicator(
                            dotSpacing: 3,
                            selectedDotColor:Colors.pink,
                            dotColor: Colors.white70,
                            itemCount: 2,
                            size: 6,
                            currentPageNotifier: _currentPageNotifier,
                          ),
                        ),
                      ),
                  ),
            ),

          ],
    );
  }
}


class HeaderDetail extends StatelessWidget {

  final Movie movieItem;
  HeaderDetail({Key key,@required this.movieItem}): super(key:key);
  @override
  Widget build(BuildContext context) {
    return
      Container(
        height: 320,
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
          margin: EdgeInsets.only(left: 20,top: 0,right: 20,bottom: 0),
          child: Column(

            children: <Widget>[
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

//                    RatingBar(
//                      initialRating: 1.2,
//                      direction: Axis.horizontal,
//                      allowHalfRating: true,
//                      itemSize: 15,
//                      itemCount: 5,
//                      itemPadding: EdgeInsets.symmetric(horizontal: 1),
//                      itemBuilder: (context, _) =>
//                          Icon(
//                            Icons.star,
//                            color: Colors.amber,
//                          ),
//                      onRatingUpdate: (rating) {
//                        print(rating);
//                      },
//                    )
                    RatingBar(
                      isLogin: true,
                      initialRating: double.parse(movieItem.rate),
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 30,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                        child: Text(' برای امتیاز دادن با کاربری خود وارد شوید    ',style: TextStyle(fontSize: 10,color: Colors.lightGreenAccent))),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(right: 15),
                      width: 55,
                      height: 20,
                      color: Colors.black,
                      child: Text(movieItem.genre,style: TextStyle(color: Colors.white,fontSize: 11),textAlign: TextAlign.center,),
                    ),
                    Text(' ژانر',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),

                  ],
                ),
              ),
              myRows("کارگردان", movieItem.director),

              myRows("سال ساخت", movieItem.year),
              myRows("زمان", movieItem.duration + " دقیقه"),
              myRows("تهیه کننده", movieItem.producer),

            ],
          ),
        ),
      );
  }
  Expanded myRows(String title, String value){
    return Expanded(
      flex: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right:8.0),
            child: Text(value,style: TextStyle(color: Colors.white )),
          ),
          Text(title,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        ],
      ),
    );

  }
  Container myRow(String title, String value){
    return Container(
      width: 800,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(flex:1,child: Text(value)),
          Expanded(flex:1,child: Text(title)),

        ],
      ),
    );
  }
  Column table(Movie movie){
    return Column(
//     defaultColumnWidth: FlexColumnWidth(5.0),
      children: [
        Expanded(flex:1,child: myRow("ژانر", movie.genre)),
        Expanded(flex: 1,child: myRow("کارگردان", movie.producer)),
        Expanded(flex: 1,child: myRow("تهیه کننده", movie.director+"hkjhkhjkhmnkjhkjh,jhjh,jh,jhbmnbjbhbmbmbmb"),),
        Expanded(flex: 1,child: myRow("سال ساخت", movie.year),),
        Expanded(flex: 1,child: myRow("زمان", movie.duration+ "دقیقه "),),
//        TableRow(
//            children: [
//              Text(movie.producer),
//              Text("کارگردان"),
//            ]
//        ),
//        TableRow(
//            children: [
//              Text(movie.director),
//              Text("تهیه کننده"),
//            ]
//        ),
//        TableRow(
//            children: [
//              Text(movie.year),
//              Text("سال ساخت"),
//            ]
//        ),
//        TableRow(
//            children: [
//              Text(movie.duration),
//              Text("زمان"),
//            ]
//        ),
      ],
    );
  }
}
class ButtonsRow extends StatefulWidget {
  @override
  _ButtonsRowState createState() => _ButtonsRowState();
}

class _ButtonsRowState extends State<ButtonsRow> {
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
          ),
          new GestureDetector(
            child: button(Colors.green, 'خرید بلیط'),
            onTap:(){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BuyTicket(filmCode:filmCode)));
            },
          ),
        ],
      ),
    );
  }

}
class DetailSection extends StatelessWidget {
  final Movie movieItem;
  DetailSection({Key key,@required this.movieItem});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(': بازیگران',style: TextStyle(fontWeight: FontWeight.bold),),
          Text(movieItem.actors,textAlign: TextAlign.right,),
          Text(': خلاصه داستان',style: TextStyle(fontWeight: FontWeight.bold),),
          Text(movieItem.summary,textAlign: TextAlign.right,),
          Text(': سایر عوامل ',style: TextStyle(fontWeight: FontWeight.bold),),
          Text(movieItem.others,textAlign: TextAlign.right,),
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
    margin: EdgeInsets.only(right: 10),
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