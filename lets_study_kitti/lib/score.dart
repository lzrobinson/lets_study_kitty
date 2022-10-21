import 'package:flutter/material.dart';
import 'package:lets_study_kitti/star_display.dart' show StarDisplayWidget;

class Score extends StatefulWidget {
  final double score;
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
        )
      ],
    );
  }
}
