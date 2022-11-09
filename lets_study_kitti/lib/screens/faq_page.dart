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
            height: 30,
          ),
          Text(
            'What is Let’s Study Kitti?',
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'Let’s Study Kitti is a website to share and read student reviews on subjects at the University of Melbourne.',
            style: TextStyle(fontSize: 15),
          ),
          Text(
            'This website was created as a part of COMP30022 (IT Project) by a group of students at UoM.',
            style: TextStyle(fontSize: 15),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            'How can I read subject reviews?',
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'You can browse subject reviews by subject. Simply search for your subject in the search bar and click the desired subject title.',
            style: TextStyle(fontSize: 15),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            'How can I create subject reviews?',
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'If you are logged in with a registered account, simply click on the create review button and fill in all fields. An error message will display if you have not entered all fields correctly.',
            style: TextStyle(fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Alternatively, if you are on the CS@unimelb discord server, you can submit subject reviews to the website through the subject-reviews channel.',
            style: TextStyle(fontSize: 15),
          ),
          Text(
            'Simply enter ‘/review’ to prompt the discord bot to generate the subject review fields.',
            style: TextStyle(fontSize: 15),
          )
        ],
      ),
    );
  }
}
