import 'dart:convert';
import 'dart:io';

class MyResponse {
  String activationCode;
  String responseCode;
  MyResponse({this.activationCode,this.responseCode});

  factory MyResponse.fromJson(Map<String, dynamic> json){
    return new MyResponse(
      activationCode: json['activationCode'],
      responseCode: json['responseCode'],
    );
  }
  Future<MyResponse> myPost(Map body) async {
    String baseUrl = "http://10.17.220.246:4000/api/v1";
    String url = baseUrl + "/"+"register";
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
    return null;
  }
  MyResponse parseData(String responseBody){
    final parsed = json.decode(responseBody);
    Map<String, dynamic> response = parsed;
    MyResponse m = MyResponse.fromJson(response);
    return m;
//  return parsed.map<Movie>((json) => Movie.fromJson(json));
  }

}