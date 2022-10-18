import 'package:flutter/material.dart';
import 'package:lets_study_kitti/screens/star_display.dart' show StarDisplayWidget;

const double imgSize = 15;

class Score extends StatefulWidget {
  final int score;
  const Score({Key? key, required this.score}) : super(key: key);
  @override
  State<Score> createState() {
    return _ScoreState();
  }
}

class _ScoreState extends State<Score> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        StarDisplayWidget(
            value: widget.score,
            filledStar: Container(
                margin: const EdgeInsets.fromLTRB(2, 2, 2, 2),
                child: Image.asset('assets/images/fpaw.png',
                    height: imgSize, width: imgSize)),
            unfilledStar: Container(
                margin: const EdgeInsets.fromLTRB(2, 2, 2, 2),
                child: Image.asset('assets/images/paw.png',
                    height: imgSize, width: imgSize)))
      ],
    );
  }
}