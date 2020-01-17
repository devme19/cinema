import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';


//String baseUrl = "http://10.5.3.92:4000/api/v1";
String baseUrl = "http://10.17.220.246:4000/api/v1";
class Item {
  String id, imageUrl,title;

  Item({this.id, this.imageUrl});

  factory Item.fromJson(Map<String, dynamic> json){
    return new Item(
        id: json['id'],
        imageUrl: json['imageUrl']
    );
  }
}
Future<List<Item>> getData(String what,Map body) async {
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
  List<Item> parseData(String responseBody){
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Item>((json) => Item.fromJson(json)).toList();
}