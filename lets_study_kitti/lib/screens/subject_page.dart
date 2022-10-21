import 'package:flutter/material.dart';
import 'package:lets_study_kitti/heading_bar.dart';
import 'package:lets_study_kitti/home_page/my_navigation_bar.dart';
import 'package:lets_study_kitti/likes.dart' show Likes;
import 'package:lets_study_kitti/profile_review.dart' show ProfileReview;
import 'package:lets_study_kitti/rating.dart' show Rating;
import 'package:lets_study_kitti/score.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lets_study_kitti/review.dart' show Review;
import 'package:cloud_firestore/cloud_firestore.dart';

const boundarySize = 100.0;
const hOffset = 30.0;
const vOffset = 15.0;
const double imgSize = 100;

class SubjectPage extends StatefulWidget {
  final String subjectCode;

  const SubjectPage({Key? key, required this.subjectCode}) : super(key: key);

  @override
  State<SubjectPage> createState() {
    return _SubjectPageState();
  }
}

class _SubjectPageState extends State<SubjectPage> {
  final _firestore = FirebaseFirestore.instance;
  Map<String, List<String>> _userDetails = {};
  var reviews = [];
  var reviewLen = 0;
  var recommendNum = 0;
  var handbookLink = '';
  var subjectName = '';
  var name = '';
  var majors = '';
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    addUserDetails();
    getSubjectName(widget.subjectCode);
    getRecommended(widget.subjectCode);
    getHandbookLink(widget.subjectCode);
    setState(() {
      _loading = false;
    });
  }

  // Given subject code get subject name
  void getSubjectName(String subjectCode) {
    _firestore
        .collection('subjects')
        .where('subjectCode', isEqualTo: subjectCode)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (!mounted) return;
      setState(() {
        querySnapshot.docs.forEach((doc) {
          subjectName = doc['subjectName'];
        });
      });
    });
  }

// Get the handbook link given the subject code
  void getHandbookLink(String subjectCode) {
    _firestore
        .collection('subjects')
        .where('subjectCode', isEqualTo: subjectCode)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (!mounted) return;
      setState(() {
        querySnapshot.docs.forEach((doc) {
          handbookLink = doc['link'];
        });
      });
    });
  }

  void getRecommended(String subjectCode) {
    _firestore
        .collection('reviews')
        .where('subjectCode', isEqualTo: subjectCode)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (!mounted) return;
      setState(() {
        querySnapshot.docs.forEach((doc) {
          if (doc['recommended'] == 'Yes') {
            recommendNum += 1;
          }
          reviewLen += 1;
        });
      });
    });
  }

  // Get the majors and  given the userID
  void addUserDetails() {
    _firestore.collection('users').get().then((QuerySnapshot querySnapshot) {
      if (!mounted) return;
      setState(() {
        querySnapshot.docs.forEach((doc) {
          name = doc['name'];
          majors = doc['major'];
          _userDetails[doc['uid']] = [name, majors];
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? const CircularProgressIndicator()
        : Scaffold(
            appBar: const MyNavigationBar(),
            body: ListView(shrinkWrap: true, children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(
                      boundarySize + 2 * hOffset, 25, 0, 25),
                  child: Text('${subjectName} - ${widget.subjectCode}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 30)),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(
                      boundarySize + 2 * hOffset, 0, 0, 0),
                  child: Row(
                      children: reviewLen != 0
                          ? [
                              Image.asset(
                                  getRecommendationImage(
                                      recommendNum / reviewLen),
                                  height: imgSize / 2,
                                  width: imgSize / 2),
                              const SizedBox(width: 10),
                              Text(
                                  "${(recommendNum / reviewLen * 100).toStringAsFixed(1)}%",
                                  style: const TextStyle(fontSize: 30)),
                              const Text('  Recommended',
                                  style: TextStyle(fontSize: 12))
                            ]
                          : [
                              const Text('No Reviews Yet',
                                  style: TextStyle(fontSize: 24))
                            ]),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                    left: boundarySize + hOffset,
                    right: boundarySize + hOffset),
                child: const Divider(color: Colors.black, height: 30),
              ),
              Container(
                  padding: const EdgeInsets.only(
                      left: boundarySize, right: boundarySize),
                  child: Card(
                      child: Container(
                          padding: const EdgeInsets.only(
                              left: hOffset,
                              right: hOffset,
                              top: vOffset,
                              bottom: vOffset),
                          child: Column(
                            children: [
                              HeadingBar('Subject Information'),
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(0, vOffset, 0, 0),
                                alignment: Alignment.centerLeft,
                                child: InkWell(
                                    child: const Text('Handbook Link'),
                                    onTap: () =>
                                        launchUrl(Uri.parse(handbookLink))),
                              )
                            ],
                          )))),
              Container(
                padding: const EdgeInsets.only(
                    left: boundarySize + hOffset,
                    right: boundarySize + hOffset),
                child: const Divider(color: Colors.black, height: 30),
              ),
              Container(
                  padding: const EdgeInsets.only(
                      left: boundarySize, right: boundarySize),
                  child: Card(
                      child: Container(
                          padding: const EdgeInsets.only(
                              left: hOffset,
                              right: hOffset,
                              top: vOffset,
                              bottom: vOffset),
                          child: Column(children: [
                            HeadingBar('Reviews'),
                            const SizedBox(height: 10),
                            StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('reviews')
                                    .where('subjectCode',
                                        isEqualTo: widget.subjectCode)
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
                                    children:
                                        snapshot.data!.docs.map((document) {
                                      return ProfileReview(
                                          reviewID: document.id,
                                          major: (document['userID'] != null)
                                              ? _userDetails.containsKey(
                                                      document['userID'])
                                                  ? _userDetails[
                                                      document['userID']]![1]
                                                  : 'Loading Major'
                                              : document['major'],
                                          username: (document['userID'] != null)
                                              ? _userDetails.containsKey(
                                                      document['userID'])
                                                  ? _userDetails[
                                                      document['userID']]![0]
                                                  : 'Loading User'
                                              : document['username'],
                                          userID:
                                              document['userID'] ?? 'discord',
                                          review: Review(
                                              ratings: Rating(
                                                  difficulty: Score(
                                                      score: document[
                                                          'difficulty']),
                                                  interest: Score(
                                                      score: document[
                                                          'interesting']),
                                                  teaching:
                                                      Score(score: document['teachingQuality'])),
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
            ]));
  }

  double recommendedRate(List<dynamic> reviews) {
    int yesCount = 0;
    int noCount = 0;

    for (ProfileReview review in reviews) {
      if (review.getReview().getRecommended() == 'Yes') {
        yesCount++;
      } else {
        noCount++;
      }
    }

    return yesCount / (yesCount + noCount);
  }

  String getRecommendationImage(double rate) {
    if (rate < 0.4) {
      return 'assets/images/frown.png';
    } else if (rate < 0.6) {
      return 'assets/images/flat.png';
    } else {
      return 'assets/images/smile.png';
    }
  }
}
