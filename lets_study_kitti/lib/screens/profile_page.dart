import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../home_page/my_navigation_bar.dart';

const double imgSize = 150;
const boundarySize = 100.0;
const vOffset = 15.0;

class ProfilePage extends StatefulWidget {
  final String userID;

  const ProfilePage({Key? key, required this.userID}) : super(key: key);

  @override
  State<ProfilePage> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage> {
  String username = '';
  String major = '';

  CircleAvatar profilePic = const CircleAvatar(
    radius: imgSize / 2,
    backgroundImage: NetworkImage('assets/images/user.png'),
  );

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  // Get the major and name given the userID
  void getUserDetails() {
    FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: widget.userID)
        .get()
        .then((QuerySnapshot querySnapshot) {
      setState(() {
        querySnapshot.docs.forEach((doc) {
          username = doc['name'];
          major = doc['major'];
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyNavigationBar(),
        body: ListView(shrinkWrap: true, children: [
          const SizedBox(height: 1 / 2 * boundarySize),
          Row(children: [
            const SizedBox(width: boundarySize),
            profilePic,
            Column(children: [
              const SizedBox(height: vOffset),
              Row(children: [
                Text('Name: ',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold)),
                Text(username, style: const TextStyle(fontSize: 24))
              ]),
              const SizedBox(height: vOffset),
              Row(children: [
                Text(major, style: const TextStyle(fontSize: 24))
              ]),
            ])
          ])
        ]));
  }
}
