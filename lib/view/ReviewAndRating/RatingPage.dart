import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingPage extends StatefulWidget {
  final String sellerName;

  const RatingPage({Key? key, required this.sellerName}) : super(key: key);

  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  double _rating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rate ${widget.sellerName}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Rating stars widget
            RatingBar.builder(
              initialRating: _rating,
              minRating: 0,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 40,
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  _rating = rating;
                });
              },
            ),

            const SizedBox(height: 20),

            // Text field for writing a note
            TextField(
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Write a note...',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            // Submit button
            ElevatedButton(
              onPressed: () {
                // Implement your submit action here
                print('Rating: $_rating');
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
