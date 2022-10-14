import 'package:flutter/material.dart';
import 'package:lets_study_kitti/review.dart' show Review;

const double imgSize = 40;

class ProfileReview extends StatefulWidget {
  final Review review;
  final String username;
  final String major;

  const ProfileReview(
      {Key? key,
      required this.review,
      required this.username,
      required this.major})
      : super(key: key);

  @override
  State<ProfileReview> createState() {
    return _ProfileReviewState();
  }

  Review getReview() {
    return review;
  }
}

class _ProfileReviewState extends State<ProfileReview> {
  CircleAvatar profilePic = const CircleAvatar(
    radius: imgSize / 2,
    backgroundImage: NetworkImage('assets/images/user.png'),
  );

  void setPic(CircleAvatar avatar) {
    profilePic = avatar;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(shrinkWrap: true, children: [
      Row(children: [
        profilePic,
        const SizedBox(width: 10),
        Text(widget.username,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(width: 5),
        Text(widget.major, style: const TextStyle(fontSize: 9))
      ]),
      const SizedBox(height: 20),
      widget.review,
    ]);
  }
}

class ProfilePageReview extends StatefulWidget {
  final Review review;
  final String subjectName;
  final String subjectCode;

  const ProfilePageReview(
      {Key? key,
      required this.review,
      required this.subjectCode,
      required this.subjectName})
      : super(key: key);

  @override
  State<ProfilePageReview> createState() {
    return _ProfilePageReviewState();
  }

  Review getReview() {
    return review;
  }
}

class _ProfilePageReviewState extends State<ProfilePageReview> {
  @override
  Widget build(BuildContext context) {
    return ListView(shrinkWrap: true, children: [
      Row(children: [
        Text(widget.subjectCode + " - ",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        Text(widget.subjectName,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18))
      ]),
      const SizedBox(height: 20),
      widget.review,
    ]);
  }
}
