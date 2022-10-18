import 'package:flutter/material.dart';
import 'package:lets_study_kitti/screens/likes.dart';
import 'package:lets_study_kitti/screens/rating.dart';


class ReviewCard extends StatefulWidget {
  final Rating ratings;
  final String reviewTxt;
  final String lecturer;
  final Likes likes;
  final String recommend;
  final String sem;
  final String year;

  const ReviewCard(
      {Key? key,
      required this.ratings,
      required this.reviewTxt,
      required this.lecturer,
      required this.likes,
      required this.recommend,
      required this.sem,
      required this.year})
      : super(key: key);

  @override
  State<ReviewCard> createState() {
    return _ReviewCardState();
  }

  String getRecommended() {
    return recommend;
  }
}

class _ReviewCardState extends State<ReviewCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      alignment: Alignment.center,
      child: ListView(shrinkWrap: true, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          widget.ratings,
          widget.likes,
        ]),
        const SizedBox(height: 10),
        Text('${widget.lecturer} (${widget.year} ${widget.sem})',
            style: const TextStyle(fontSize: 13)),
        const SizedBox(height: 10),
        Text('Recommend: ${widget.recommend}',
            style: const TextStyle(fontSize: 13)),
        const SizedBox(height: 10),
        Text(widget.reviewTxt, style: const TextStyle(fontSize: 10)),
        const Divider(color: Colors.black, height: 30),
      ]),
    );
  }
}