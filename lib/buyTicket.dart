import 'package:cinema/sansDetails.dart';
import 'package:cinema/sanseItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'sanse.dart';

class BuyTicket extends StatefulWidget {
  String filmCode;
  BuyTicket({Key key,@required this.filmCode}): super(key:key);
  @override
  _BuyTicketState createState() => _BuyTicketState();
}

class _BuyTicketState extends State<BuyTicket> {
  Map map;
  Sans item;
  bool error = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body:
      Container(
            child: FutureBuilder<Sans>(
                future: getData("sanses",map),
                builder:
                    (context,snapshot){
                  switch (snapshot.connectionState){
                    case ConnectionState.waiting: return Center(child:new SpinKitCubeGrid( color: Colors.pink,size: 50.0),);
                    default:
                      if(snapshot.hasError){
                        return Text("خطا در برقراری ارتباط");

                      }
                      else {
//                isLoading = false;
                        item = snapshot.data;
                        return temp(item);
                      }
                  }
                }),

      )
    );
  }
  SingleChildScrollView temp(Sans item){
    var myWidgets = List<Widget>();

    myWidgets.add(Container(
      height: 400,
      child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child:
                Image.network(
                item.imageUrl, fit: BoxFit.fill,),),
            ],
          )

    ));
    for(var sans in item.sansItems)
      myWidgets.add(buildsans(sans));
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: myWidgets,
      ),
    );
  }

  Column buildsans(SansItem sansItem){
    return Column(
      children: <Widget>[
        Row(children: <Widget>[
          Expanded(child: Container(
            color: Colors.black12,
            padding: EdgeInsets.all(5),
            child: Center(child: Text(sansItem.showDay+" "+sansItem.showDate,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black54),)),
          ),)
        ],),

        buildViews(sansItem),
        Container(
          margin: EdgeInsets.only(top: 20),
        )
//        Divider(
//          color: Colors.pink,
//        ),

      ],
    );
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

  SingleChildScrollView buildViews(SansItem sans) {
    var widgets = List<Widget>();
    for(var item in sans.sansDetails) {
        widgets.add(template(item));
    }
    return
    SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      reverse: true,
      child:Row(
        children: widgets,
      ),
    );

  }
  Widget template(SansDetails item){
    return Container(
      width: 120,
      height: 130,
      margin: EdgeInsets.only(bottom: 3,left: 3,right: 3),
//      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
//        color: item? Colors.white:Colors.grey,
        border:Border.all(
          color: Colors.pink,
          width: 1,
//          style: BorderStyle.solid,
        ),
      ),
      child:
      Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: SizedBox.expand( child: Container(color:Colors.pink,child: Center(child: Text(item.sansHour,style: TextStyle(color: Colors.white),)))),
          ),
          Expanded(
            flex: 1,
            child: Container(child: Text(item.salon)),
          ),
          Expanded(
            flex: 1,
            child: Container(margin:EdgeInsets.only(top: 5),child: Text(item.sansPrice)),
          ),
          item.buyTicket?Expanded(
              flex: 2,
                child:  Container(margin:EdgeInsets.all( 3),child: button(Colors.blue, "خرید"))
          ):Expanded(flex: 2,child: Container(),)


        ],
      )
    );
  }

  @override
  void initState() {
    super.initState();
    map = new Map<String, dynamic>();
    map["filmCode"] =  widget.filmCode;
    item = new Sans();
  }
}

