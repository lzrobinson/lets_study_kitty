import 'package:flutter/material.dart';

import '../home_page/my_navigation_bar.dart';
import '../home_page/website_title.dart';

class ProfilePage extends StatefulWidget {
  final String userID;

  const ProfilePage({Key? key, required this.userID}) : super(key: key);

  @override
  State<ProfilePage> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, List<String>> _userDetails = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyNavigationBar(),
        body: ListView(shrinkWrap: true, children: [
          const SizedBox(height: 50),
          Text(widget.userID),
          const SizedBox(height: 50),
        ]));
  }
}
