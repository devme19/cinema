import 'package:cinema/guillotineMenu.dart';
import 'package:cinema/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'movieDetail.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MoviesList extends StatefulWidget {
  @override
  _MoviesListState createState() => _MoviesListState();
}
class Page extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return new Container(
      padding: const EdgeInsets.only(top: 90.0),
      color: Color(0xff222222),
    );
  }
}
class _MoviesListState extends State<MoviesList> {
  int scrollPosition = 0;
  List<Item> moviesList;
  bool isLoading = true;
  bool loadMore = false;
  bool error = false;
  double _expandedHeight;
  @override
  void initState() {
    super.initState();
    moviesList = new List();

   // fetchData();
  }
  Future<bool> fetchData() async {
    if (!isLoading){
      setState(() {
        isLoading = true;
      });
    }
    await Future.delayed(Duration(seconds: 0, milliseconds: 1000));
    _fetchData();
    return true;

  }
  bool _fetchData() {
    getData("movies",null).then((onValue){
      moviesList.addAll(onValue);
      setState(() {
        isLoading = false;
      });
      return true;
    },onError:(e){
      setState(() {
        isLoading = false;
        error = true;
      });
    });
    return false;
  }
  int columnCount = 3;

  String title = 'فیلم ها';
  @override
  Widget build(BuildContext context) {
    _expandedHeight = 300;
    return
      SafeArea(
        top: false,
      bottom: false,
      child: new Container(
        color: Colors.white,
        child:
        Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            FutureBuilder<List<Item>>(
                future: getData("movies", null),
                builder:
                    (context,snapshot){
                  switch (snapshot.connectionState){
                    case ConnectionState.waiting: return Center(child:new SpinKitCubeGrid( color: Colors.pink,size: 50.0),);
                    default:
                      if(snapshot.hasError){
                        return Container();

                      }
                      else {
                        isLoading = false;
                        moviesList = snapshot.data;
                        return
                          views();
                      }
                  }
                }),
            new GuillotineMenu(),
//            Page()
          ],
        ),
      ),

    );
  }
  Widget views() {
    double expandedHeight = 330;
    return Container(
      padding: EdgeInsets.only(top: 60),
      child: CustomScrollView(
        shrinkWrap: false,

        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.white,
            expandedHeight: expandedHeight,
            floating: false,
            pinned: false,
            snap: false,
//                flexibleSpace:FlexibleSpaceBar(
//                  background: HeaderDetail(),
//                )
            flexibleSpace:
            FlexibleSpaceBar(
//                collapseMode: CollapseMode.pin,

              background:
              imageSlider(),

            ),
          ),
          SliverGrid(

            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 150,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1,
            ),
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                              MovieDetail(id: moviesList[index].id)));
                    },
                    child: Container(

                    alignment: Alignment.center,
                    child:
                    new Card(
                      child: new
                      GridTile(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Expanded(
                                child: Image.network(
                                  moviesList[index].imageUrl, fit: BoxFit.fill,),
                              ),
//                          Container(
////                            margin: EdgeInsets.only(top: 10,bottom: 5),
//                          padding: EdgeInsets.all(5),
//                            child: Center(
//                              child:  Text("س $index",style: TextStyle(fontSize: 13,color: Colors.blueAccent),),
//                            ),
//                          )

                            ],
                          ) //just for testing, will fill with image later
                      ),
                    ),
                ),
                  );
              },
              childCount: moviesList.length,
            ),
          ),
        ],
      ),
    );
  }
  Widget imageSlider(){
    return CarouselSlider(
      viewportFraction: 0.73 ,
      autoPlayInterval: Duration(seconds: 3),
      items: moviesList.map((movie) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
//                                color: Colors.amber
              ),
              child:
              GestureDetector(
                onTap:(){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MovieDetail(id: movie.id)));
                },
                child: Container(
                  child: GridTile(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Expanded(
                            child: Image.network(
                              movie.imageUrl,
                              fit: BoxFit.fill,),
                          ),
//                          Container(
////                            margin: EdgeInsets.only(top: 10,bottom: 5),
//                          padding: EdgeInsets.all(5),
//                            child: Center(
//                              child:  Text("س $index",style: TextStyle(fontSize: 13,color: Colors.blueAccent),),
//                            ),
//                          )

                        ],
                      ) //just for testing, will fill with image later
                  ),
                ),
              ),
//                            child: Image.network(movie.imageUrl),
            );
          },
        );
      }).toList(),
      autoPlay: true,
      reverse: false,
      height: 300,
    );
  }
  Future<void> refresh() async {
    await Future.delayed(Duration(seconds: 0, milliseconds: 200));
    moviesList.clear();
    fetchData();
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
                            setState(() {
                              error = false;
                              fetchData();
                            });
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
  _onTap(String id){
    print(id);
    if(isLoading)
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MovieDetail(id: id)));
  }

Widget grid(){
    return
      FutureBuilder<List<Item>>(
        future: getData("movies", null),
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
                moviesList = snapshot.data;
                return gridv();
              }
          }
        });
}

  Widget gridv(){
    return
      Container(
        height: 500,
        child: GridView.builder(

          itemCount: moviesList.length,
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (BuildContext context, int index) {
            return
              GestureDetector(
                child:
                AnimationConfiguration.staggeredGrid(
                  position: index,
                  duration: const Duration(milliseconds: 300),
                  columnCount: columnCount,
                  child:
                  ScaleAnimation(
                    child: FadeInAnimation(
                      child:
                      new Card(
                        child: new
                        GridTile(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Expanded(
                                  child: Image.network(
                                    moviesList[index].imageUrl, fit: BoxFit.fill,),
                                ),
//                          Container(
////                            margin: EdgeInsets.only(top: 10,bottom: 5),
//                          padding: EdgeInsets.all(5),
//                            child: Center(
//                              child:  Text("س $index",style: TextStyle(fontSize: 13,color: Colors.blueAccent),),
//                            ),
//                          )

                              ],
                            ) //just for testing, will fill with image later
                        ),
                      ),
//                GestureDetector(
//                  onTap: _onTap(moviesList[index].id),
//                  child:
//
//                )
                    ),
                  ),
                ),

                onTap:(){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MovieDetail(id: moviesList[index].id)));
                  },
              );
          },
        ),
      );
  }
  Widget moviesGrid(){
    return GridView.builder(
      itemCount: moviesList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          // ignore: unrelated_type_equality_checks
          crossAxisCount: 2,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2),
      itemBuilder: (BuildContext context,int index) {
        return new GestureDetector(
          child: AnimationConfiguration.staggeredGrid(
            position: index,
            duration: const Duration(milliseconds: 300),
            columnCount: columnCount,
            child:
            ScaleAnimation(
              child: FadeInAnimation(
                child:
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
//                        border: Border.all(
//                            color: Colors.blueGrey,
//                            width: 1
//                        ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        child: Image.network(
                          moviesList[index].imageUrl, fit: BoxFit.fill,),
                      ),
//                          Container(
////                            margin: EdgeInsets.only(top: 10,bottom: 5),
//                          padding: EdgeInsets.all(5),
//                            child: Center(
//                              child:  Text("س $index",style: TextStyle(fontSize: 13,color: Colors.blueAccent),),
//                            ),
//                          )

                    ],
                  ),
                ),
//                GestureDetector(
//                  onTap: _onTap(moviesList[index].id),
//                  child:
//
//                )
              ),
            ),
          ),
          onTap: _onTap(moviesList[index].id),
        );
      },
    );
  }
}

