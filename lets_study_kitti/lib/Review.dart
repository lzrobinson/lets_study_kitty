import 'package:flutter/material.dart';
import 'package:lets_study_kitti/rating.dart' show Rating;
import 'package:lets_study_kitti/likes.dart' show Likes;

// Base review display class

class Review extends StatefulWidget {
  final Rating ratings;
  final String reviewTxt;
  final String lecturer;
  final Likes likes;
  final String recommend;
  final String sem;
  final String year;
  final String stream;

  const Review(
      {Key? key,
      required this.ratings,
      required this.reviewTxt,
      required this.lecturer,
      required this.likes,
      required this.recommend,
      required this.sem,
      required this.year,
      required this.stream})
      : super(key: key);

  @override
  State<Review> createState() {
    return _ReviewState();
  }

  String getRecommended() {
    return recommend;
  }
}

class _ReviewState extends State<Review> {
  @override
  Widget build(BuildContext context) {
    return ListView(shrinkWrap: true, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        widget.ratings,
        widget.likes,
      ]),
      const SizedBox(height: 10),
      Text(
          '${widget.lecturer} (${widget.year} ${widget.sem}) - ${widget.stream}',
          style: const TextStyle(fontSize: 13)),
      const SizedBox(height: 10),
      Text('Recommend: ${widget.recommend}',
          style: const TextStyle(fontSize: 13)),
      const SizedBox(height: 10),
      Text(widget.reviewTxt, style: const TextStyle(fontSize: 10)),
      const Divider(color: Colors.black, height: 30),
    ]);
  }
}
