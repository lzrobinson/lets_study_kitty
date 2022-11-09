import 'package:flutter/material.dart';
import 'package:lets_study_kitti/home_page/my_navigation_bar.dart';
import 'package:lets_study_kitti/home_page/website_title.dart';
import 'package:lets_study_kitti/home_page/home_contents.dart';

class FaqPage extends StatelessWidget {
  const FaqPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: const <Widget>[
          MyNavigationBar(),
          SizedBox(
            height: 50,
          ),
          Text(
            'Frequently Asked Questions',
            style: TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'What is Let’s Study Kitti?',
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'Let’s Study Kitti is a website to share and read student reviews on subjects at the University of Melbourne. This website was created as a part of COMP30022 (IT Project) by a group of students at UoM.',
            style: TextStyle(fontSize: 15),
          )
          // faq stuff will go here,
        ],
      ),
    );
  }
}
