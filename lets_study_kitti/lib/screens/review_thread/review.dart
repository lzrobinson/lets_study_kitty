import 'package:flutter/material.dart';
import 'package:lets_study_kitti/screens/likes.dart';
import 'package:lets_study_kitti/screens/profile_bar.dart';
import 'package:lets_study_kitti/screens/rating.dart';
import 'package:lets_study_kitti/screens/review_card.dart';
import 'package:lets_study_kitti/screens/score.dart';

import 'heading_bar.dart';

class Review extends StatelessWidget {
  const Review({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
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
          SizedBox(
            height: 15,
          ),
          HeadingBar('Review'),
          ProfileBar('Sen', 'Major of Data Science'),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 15,
          ),
          ReviewCard(
            ratings: Rating(
                difficulty: Score(score: 3),
                interest: Score(score: 2),
                teaching: Score(score: 1)),
            likes: Likes(likeCount: 15),
            lecturer: "Sen",
            recommend: "yes",
            reviewTxt: "Nice. Love it!",
            sem: "Semester 1",
            year: "2023",    
          ),
        ],
      ),
    );
  }
}
