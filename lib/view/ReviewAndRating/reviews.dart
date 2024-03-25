import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart'; // Import the ReadMore package
import 'package:flutter_rating_bar/flutter_rating_bar.dart'; // Import the Flutter Rating Bar package

class Review {
  final String sellerName;
  final String reviewText;
  final double rating;
  final String profilePicturePath;

  Review({
    required this.sellerName,
    required this.reviewText,
    required this.rating,
    required this.profilePicturePath,
  });
}

class ReviewCard extends StatelessWidget {
  final Review review;

  const ReviewCard({Key? key, required this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(review.profilePicturePath),
                  radius: 20.0,
                ),
                const SizedBox(width: 8.0),
                Text(
                  review.sellerName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            ReadMoreText(
              review.reviewText,
              trimLines: 2,
              trimMode: TrimMode.Line,
              textAlign: TextAlign.justify,
              style: const TextStyle(fontSize: 16.0),
              trimCollapsedText: 'Read more',
              trimExpandedText: 'Read less',
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                const Text(
                  'Rating: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                RatingBar.builder(
                  initialRating: review.rating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 16.0, // Adjusted size of the stars
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    // Handle rating update if needed
                  },
                ),
                const SizedBox(width: 8.0),
                Text(
                  '${review.rating}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ReviewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Review Cards',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Reviews'),
        ),
        body: ListView(
          children: [
            ReviewCard(
              review: Review(
                sellerName: 'John Doe',
                reviewText: 'Great seller! Highly recommended.',
                rating: 4.5,
                profilePicturePath: 'lib/assets/man.png',
              ),
            ),
            ReviewCard(
              review: Review(
                sellerName: 'Jane Smith',
                reviewText:
                    'Product as described. Fast shipping. This is a long review that will need to be collapsed and expanded.',
                rating: 5.0,
                profilePicturePath: 'lib/assets/man.png',
              ),
            ),
            
            // Add more reviews as needed
          ],
        ),
      ),
    );
  }
}


