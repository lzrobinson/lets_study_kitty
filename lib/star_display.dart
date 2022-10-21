import 'dart:math';

import 'package:flutter/material.dart';

const double imgSize = 15;

class StarDisplayWidget extends StatelessWidget {
  final double value;
  const StarDisplayWidget({
    Key? key,
    this.value = 0,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(10, (index) {
        if (value - index > 0) {
          return ShaderMask(
            blendMode: BlendMode.srcATop,
            shaderCallback: (Rect rect) {
              return LinearGradient(
                stops: [0, min(1, value - index), min(1, value - index)],
                colors: [
                  Colors.black,
                  Colors.black,
                  Colors.black.withOpacity(0)
                ],
              ).createShader(rect);
            },
            child: SizedBox(
              width: imgSize,
              height: imgSize,
              child: Icon(Icons.pets, size: imgSize, color: Colors.grey[300]),
            ),
          );
        } else {
          return Icon(Icons.pets, size: imgSize, color: Colors.grey[300]);
        }
      }),
    );
  }
}
