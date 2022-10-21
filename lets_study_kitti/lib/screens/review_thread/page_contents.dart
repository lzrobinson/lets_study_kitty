import 'package:flutter/material.dart';
import 'package:lets_study_kitti/home_page/my_navigation_bar.dart';
import 'package:lets_study_kitti/screens/review_thread/comment.dart';
import 'package:lets_study_kitti/screens/review_thread/review_thread_review.dart';

import '../../review.dart';

class ReviewPageContents extends StatelessWidget {
  final Review review;
  final String reviewID;
  final String username;
  final String major;
  const ReviewPageContents(
      {super.key,
      required this.review,
      required this.reviewID,
      required this.username,
      required this.major});

  @override
  Widget build(BuildContext context) {
    debugPrint(reviewID);
    return Scaffold(
      appBar: const MyNavigationBar(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(children: [
            const SizedBox(height: 100),
            ReviewThreadReview(
                review: review, username: username, major: major),
            const SizedBox(
              height: 50,
            ),
            Comment(reviewID: reviewID),
            const SizedBox(height: 100)
          ]),
        ),
      ),
    );
  }
}
