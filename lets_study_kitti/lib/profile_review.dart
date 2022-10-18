import 'package:flutter/material.dart';
import 'package:lets_study_kitti/review.dart' show Review;
import 'package:lets_study_kitti/screens/profile_page.dart';
import 'package:lets_study_kitti/screens/review_thread/page_contents.dart';

const double imgSize = 40;

class ProfileReview extends StatefulWidget {
  final Review review;
  final String username;
  final String major;
  final String userID;
  final String reviewID;

  const ProfileReview(
      {Key? key,
      required this.review,
      required this.username,
      required this.major,
      required this.userID,
      required this.reviewID})
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
    return Container(
        child: ListView(shrinkWrap: true, children: [
      Row(children: [
        profilePic,
        const SizedBox(width: 10),
        MaterialButton(
            child: Row(children: [
              Text(widget.username,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(width: 5),
              Text(widget.major, style: const TextStyle(fontSize: 9))
            ]),
            onPressed: () {
              (widget.userID == 'discord')
                  ? null
                  : Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          ProfilePage(userID: widget.userID)));
            })
      ]),
      const SizedBox(height: 20),
      MaterialButton(
          child: widget.review,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ReviewPageContents(
                    review: widget.review,
                    reviewID: widget.reviewID,
                    username: widget.username,
                    major: widget.major)));
          })
    ]));
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
