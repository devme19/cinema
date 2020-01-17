import 'package:cinema/sansDetails.dart';
import 'package:cinema/sanseItem.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

String baseUrl = "http://10.17.220.246:4000/api/v1";
class Sans {
  String filmName, imageUrl;
  List<SansItem> sansItems;
  addSans(List<SansItem> list){
    this.sansItems = list;
  }
  Sans({this.filmName, this.imageUrl,this.sansItems});
  factory Sans.fromJson(Map<String, dynamic> json){
    return new Sans(
        filmName: json['filmName'],
        imageUrl: json['imageUrl']
    );
  }

}
Future<Sans> getData(String what,Map body) async {
  String url = baseUrl + "/"+what;
  if(body != null){
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(body)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();
    return parseData(reply);
  }
  else{
    final response = await http.get(url);
    return parseData(response.body);
  }
}
Sans parseData(String responseBody) {
  Sans parsed = Sans.fromJson(jsonDecode(responseBody));
  final sanses = jsonDecode(responseBody)['sanses'];
  List<SansItem> item = new List();
  List<SansDetails> sansDetails = new List();
  int index = 0;
  for(var sans in sanses) {
    item.add(SansItem.fromJson(sans));
    var times = sans['times'];
    for(var time in times)
      sansDetails.add(SansDetails.fromJson(time));
    item[index].addSansDetails(sansDetails);
    sansDetails = new List();
    index++;
  }
//  for(var sansdetails in )
  parsed.addSans(item);
  return parsed;
}

