import 'package:flutter/material.dart';
import 'package:lead_gen/model/Review.dart';
import 'package:lead_gen/services/HelperService.dart';
import 'package:readmore/readmore.dart'; // Import the ReadMore package
import 'package:flutter_rating_bar/flutter_rating_bar.dart'; // Import the Flutter Rating Bar package

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
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.reviewerName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            ReadMoreText(
              review.note,
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

class ReviewsPage extends StatefulWidget {
  final String sellerName;

  const ReviewsPage({Key? key, required this.sellerName}) : super(key: key);

  @override
  _ReviewsPageState createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  late Future<List<Review>> futureReviews;

  @override
  void initState() {
    super.initState();
    futureReviews = _loadReviewsForSeller(widget.sellerName);
  }

  Future<List<Review>> _loadReviewsForSeller(String sellerName) async {
    HelperService helperService = HelperService();
    return await helperService.getReviews(sellerName);
  }

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
          leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
          onPressed: () {
            // Unfocus the current focus node before popping the screen
            FocusManager.instance.primaryFocus?.unfocus();
            Navigator.of(context).pop();// Add navigation functionality here
          },
        ),
        ),
        body: FutureBuilder<List<Review>>(
          future: futureReviews,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No reviews found'));
            } else {
              return ListView(
                children: snapshot.data!.map((review) => ReviewCard(review: review)).toList(),
              );
            }
          },
        ),
      ),
    );
  }
}
