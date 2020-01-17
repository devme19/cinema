import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';


//String baseUrl = "http://10.5.3.92:4000/api/v1";
String baseUrl = "http://10.17.220.246:4000/api/v1";
class Movie {
  String limit,trailerUrl, imageUrl, rate, title, genre, duration, director, producer, year, actors, others, summary;

  Movie({this.limit, this.trailerUrl, this.imageUrl, this.rate, this.title, this.genre, this.duration, this.director, this.producer, this.year, this.actors, this.others, this.summary});

  factory Movie.fromJson(Map<String, dynamic> json){
    return new Movie(
      limit: json['limit'],
      trailerUrl: json['trailerUrl'],
      imageUrl: json['imgurl'],
      rate: json['rate'],
      title: json['title'],
      genre: json['genre'],
      duration: json['duration'],
      director: json['director'],
      producer: json['producer'],
      year: json['year'],
      actors: json['actors'],
      others: json['others'],
      summary: json['Summary'],

    );
  }
}
Future<Movie> getM(String what,Map body) async {
  String url = baseUrl + "/"+what;
  Map<String,String> headers = new Map();
  headers['Accept'] = 'application/x-www-form-urlencoded';
//  headers['Content-type'] = 'application/json';
  headers['Content-type'] = 'application/x-www-form-urlencoded';
  return await http.post(url,body: body,headers: headers)
      .then((http.Response response){
        final int statusCode = response.statusCode;
        if(statusCode < 200 || statusCode > 400 || json == null){
          throw new Exception("Error while fetching data");
        }
        return parseDataMovie(response.body);
  });
}
Future<Movie> getMovie(String what,Map body) async {
  String url = baseUrl + "/"+what;
  if(body != null){
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(body)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();
    return parseDataMovie(reply);
  }
  else{
    final response = await http.get(url);
    return parseDataMovie(response.body);
  }
}
 Movie parseDataMovie(String responseBody){
  final parsed = json.decode(responseBody);
  Map<String, dynamic> movie = parsed;
  Movie m = Movie.fromJson(movie);
  return m;
//  return parsed.map<Movie>((json) => Movie.fromJson(json));
}