import 'package:cinema/sansDetails.dart';

class SansItem{
  String showDate,showDay;
  List<SansDetails> sansDetails;
  addSansDetails(List<SansDetails> list){
    this.sansDetails = list;
  }
  SansItem({this.showDate,this.showDay});

  factory SansItem.fromJson(Map<String, dynamic> json){
    return new SansItem(
      showDate: json['showDate'],
      showDay: json['showDay'],
    );
  }
}