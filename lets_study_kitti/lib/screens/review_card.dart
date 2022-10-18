import 'package:flutter/material.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      alignment: Alignment.topLeft,
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Text("IT Project - COMP30022", style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),),
          Container(child: Row(
            children: [
              Text("11", style: TextStyle(fontSize: 24),),
              SizedBox(width: 10,),
              Image.asset('assets/images/heart.png', width: 50, height: 50,),
            ],
          ))

        ],)
      ]),
    );
  }
}