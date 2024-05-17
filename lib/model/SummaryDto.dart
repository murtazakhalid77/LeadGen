
class SummarDto {
   double overAllRating;
    double totalEarning;
    int totalRequestServed;
  
  SummarDto({this.overAllRating = 0.0, this.totalEarning = 0.0, this.totalRequestServed = 0});

  Map<String, dynamic> toJson() {
    return {
      'overAllRating': overAllRating,
      'totalEarning': totalEarning,
      'totalRequestServed': totalRequestServed
    };
  }

  factory SummarDto.fromJson(Map<String, dynamic> json) {
    return SummarDto(
      overAllRating: json['overAllRating'] ?? '',
      totalEarning: json['totalEarning'] ?? '',
      totalRequestServed: json['totalRequestServed'] ?? '',
    );
  }
}


