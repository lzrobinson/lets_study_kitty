import 'package:flutter/material.dart';
import 'package:lets_study_kitti/screens/review_thread/profile_bar.dart';
import 'package:lets_study_kitti/review.dart';

import 'heading_bar.dart';

class ReviewThreadReview extends StatelessWidget {
  final Review review;
  final String username;
  final String major;
  const ReviewThreadReview(
      {super.key,
      required this.review,
      required this.username,
      required this.major});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.6),
              spreadRadius: 5,
              blurRadius: 7,
            )
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 15,
          ),
          const HeadingBar('Review'),
          ProfileBar(username, major),
          const SizedBox(
            height: 15,
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            alignment: Alignment.center,
            child: review,
          )
        ],
      ),
    );
  }
}
