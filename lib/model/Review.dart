class Review {
    final String reviewerName;
    final String note;
   final double rating;

  Review({
    required this.reviewerName,
    required this.note,
    required this.rating,
   
  });

  
  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      reviewerName: json['reviewerName'],
      note: json['note'],
      rating: json['rating'].toDouble(),
    );
  }

  
  Map<String, dynamic> toJson() {
    return {
      'reviewerName': reviewerName,
      'note': note,
      'rating': rating
    };
  }
}
