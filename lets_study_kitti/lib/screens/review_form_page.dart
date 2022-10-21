import 'package:flutter/material.dart';
import 'package:lets_study_kitti/Screens/review_form.dart' show ReviewForm;
import 'package:lets_study_kitti/home_page/my_navigation_bar.dart';

class ReviewFormPage extends StatelessWidget {
  const ReviewFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for
    // the major Material Components.
    return const Scaffold(appBar: MyNavigationBar(), body: ReviewForm());
  }
}
