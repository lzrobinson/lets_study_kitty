import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lets_study_kitti/profile_review.dart';
import '../home_page/my_navigation_bar.dart';
import '../likes.dart';
import '../rating.dart';
import '../review.dart';
import '../score.dart';

const double imgSize = 150;
const boundarySize = 100.0;
const vOffset = 15.0;
const hOffset = 30.0;

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
          Column(children: [
            profilePic,
            MaterialButton(
                child:
                    const Text('Edit Profile', style: TextStyle(fontSize: 12)),
                onPressed: () {
                  debugPrint('Time to Edit Profile');
                })
          ]),
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  padding: const EdgeInsets.fromLTRB(hOffset, 0, 0, 10),
                  child: Column(children: const [
                    Text('Name: ',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    //Text(username, style: const TextStyle(fontSize: 24))
                    SizedBox(height: vOffset),
                    Text('Major: ',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold))
                  ]))),
          Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.fromLTRB(hOffset, 0, 0, 10),
              child: Column(children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      username,
                      style: const TextStyle(fontSize: 24),
                      textAlign: TextAlign.start,
                    )),
                const SizedBox(height: vOffset),
                Text(major, style: const TextStyle(fontSize: 24))
              ])),
        ]),
        Container(
          padding: const EdgeInsets.fromLTRB(boundarySize, 0, boundarySize, 0),
          child: const Divider(color: Colors.black, height: 30),
        ),
        Container(
            padding:
                const EdgeInsets.only(left: boundarySize, right: boundarySize),
            child: Card(
                child: Container(
                    padding: const EdgeInsets.only(
                        left: hOffset,
                        right: hOffset,
                        top: vOffset,
                        bottom: vOffset),
                    child: Column(children: [
                      Row(
                        children: const [
                          SizedBox(
                            width: 50,
                            height: 30,
                            child: DecoratedBox(
                              decoration: BoxDecoration(color: Colors.orange),
                            ),
                          ),
                          Text('  Reviews  ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                          SizedBox(
                            width: 780,
                            height: 30,
                            child: DecoratedBox(
                              decoration: BoxDecoration(color: Colors.orange),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('reviews')
                              .where('userID', isEqualTo: widget.userID)
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                  child: CircularProgressIndicator(
                                      color: Colors.orange));
                            }
                            return ListView(
                              shrinkWrap: true,
                              children: snapshot.data!.docs.map((document) {
                                return ProfilePageReview(
                                    subjectCode: document['subjectCode'],
                                    subjectName: document['subjectName'],
                                    review: Review(
                                        ratings: Rating(
                                            difficulty: Score(
                                                score: document['difficulty']),
                                            interest: Score(
                                                score: document['interesting']),
                                            teaching: Score(
                                                score: document[
                                                    'teachingQuality'])),
                                        reviewTxt: document['reviewText'],
                                        lecturer: document['lecturer'],
                                        likes: const Likes(likeCount: 0),
                                        recommend: document['recommended'],
                                        year: document['year'],
                                        sem: document['semesterTaken'],
                                        stream: document['subjectType']));
                              }).toList(),
                            );
                          }),
                    ]))))
      ]),
    );
  }
}
