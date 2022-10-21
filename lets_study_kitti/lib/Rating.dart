import 'package:flutter/material.dart';
import 'package:lets_study_kitti/score.dart' show Score;

class Rating extends StatefulWidget {
  final Score difficulty;
  final Score interest;
  final Score teaching;

  const Rating(
      {Key? key,
      required this.difficulty,
      required this.interest,
      required this.teaching})
      : super(key: key);

  @override
  State<Rating> createState() {
    return _RatingState();
  }
}

class _RatingState extends State<Rating> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: const [
            Align(
                alignment: Alignment.centerRight,
                child: Text("Difficulty", style: TextStyle(fontSize: 15))),
            Align(
                alignment: Alignment.centerRight,
                child: Text("Interest Level", style: TextStyle(fontSize: 15))),
            Align(
                alignment: Alignment.centerRight,
                child: Text("Teaching Quality", style: TextStyle(fontSize: 15)))
          ]),
      const SizedBox(width: 10),
      Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.difficulty,
            widget.interest,
            widget.teaching,
          ])
    ]);
  }
}
