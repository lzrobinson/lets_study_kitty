import 'package:flutter/material.dart';
import 'package:lets_study_kitti/screens/profile_bar.dart';


class CommentBar extends StatelessWidget {
  const CommentBar(this.name, this.major, this.comment);
  final String name, major, comment;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ProfileBar(name, major),
        const SizedBox(
          height: 15,
        ),
        Text(
          comment,
          style: const TextStyle(
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 15,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Container(
            height: 1.0,
            width: MediaQuery.of(context).size.width * 0.7,
            color: Colors.black,
          ),
        ),
      ]),
    );
  }
}
