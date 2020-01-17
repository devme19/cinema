class SansDetails{
  String sansCode,sansHour,salon,sansPrice;
  bool buyTicket;
  SansDetails({this.sansCode,this.sansHour,this.salon,this.sansPrice,this.buyTicket});

  factory SansDetails.fromJson(Map<String, dynamic> json){
    return new SansDetails(
        sansPrice: json['sansPrice'],
        salon: json['salon'],
        sansCode: json['sansCode'],
        sansHour: json['sansHour'],
        buyTicket: json['buyTicket'],
    );
  }
}