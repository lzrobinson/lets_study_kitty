import 'package:flutter/material.dart';

const double imgSize = 50;

// Currently un-used (so made to do nothing)

class Likes extends StatefulWidget {
  final int likeCount;

  const Likes({Key? key, required this.likeCount}) : super(key: key);

  @override
  State<Likes> createState() {
    return _LikesState();
  }
}

class _LikesState extends State<Likes> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      /*
      Text(widget.likeCount.toString(), style: const TextStyle(fontSize: 10)),
      const SizedBox(width: 5),
      Image.asset('images/heart.png', height: imgSize / 2, width: imgSize / 2)*/
    ]);
  }
}
