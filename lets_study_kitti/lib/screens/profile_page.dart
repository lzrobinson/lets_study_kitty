import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:lets_study_kitti/profile_review.dart';
import '../heading_bar.dart';
import '../home_page/my_navigation_bar.dart';
import '../likes.dart';
import '../rating.dart';
import '../review.dart';
import '../score.dart';

const double imgSize = 150;
const boundarySize = 100.0;
const vOffset = 15.0;
const hOffset = 30.0;
const labelFont = TextStyle(fontSize: 24);
const outlineColor = Color.fromARGB(100, 0, 0, 0);
const boxColor = Color.fromARGB(255, 254, 244, 225);

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
  Map<String, String> _subjectNames = {};
  bool _edit = false;
  final GlobalKey<FormBuilderState> _profileUpdateKey =
      GlobalKey<FormBuilderState>();

  CircleAvatar profilePic = const CircleAvatar(
    radius: imgSize / 2,
    backgroundImage: NetworkImage('assets/images/user.png'),
  );

  @override
  void initState() {
    super.initState();
    getUserDetails();
    addSubjectNames();
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

  // Get the majors and  given the userID
  void addSubjectNames() {
    FirebaseFirestore.instance
        .collection('subjects')
        .get()
        .then((QuerySnapshot querySnapshot) {
      setState(() {
        querySnapshot.docs.forEach((doc) {
          _subjectNames[doc['subjectCode']] = doc['subjectName'];
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
            (FirebaseAuth.instance.currentUser != null &&
                    widget.userID == (FirebaseAuth.instance.currentUser!.uid))
                ? MaterialButton(
                    child: _edit == true
                        ? const Text('Save Edit',
                            style: TextStyle(fontSize: 12))
                        : const Text('Edit Profile',
                            style: TextStyle(fontSize: 12)),
                    onPressed: () async {
                      setState(() {
                        _edit = !_edit;
                      });
                      if (!_edit) {
                        final validationSuccess =
                            _profileUpdateKey.currentState!.validate();
                        if (validationSuccess == true) {
                          _profileUpdateKey.currentState?.save();
                          debugPrint(
                              _profileUpdateKey.currentState?.value.toString());
                          setState(() {
                            username = _profileUpdateKey
                                .currentState!.fields['Username']!.value
                                .toString();
                            major = _profileUpdateKey
                                .currentState!.fields['Major']!.value
                                .toString();
                          });
                          await updateUserDetails(
                            name: _profileUpdateKey
                                .currentState!.fields['Username']!.value
                                .toString(),
                            major: _profileUpdateKey
                                .currentState!.fields['Major']!.value
                                .toString(),
                            uid: FirebaseAuth.instance.currentUser!.uid,
                          );
                        } else {
                          showDialog(
                              context: context,
                              barrierDismissible:
                                  false, // disables popup to close if tapped outside popup (need a button to close)
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text(
                                    "Cannot Update Details",
                                  ),
                                  content:
                                      const Text("Validation Not Successful"),
                                  //buttons?
                                  actions: <Widget>[
                                    MaterialButton(
                                      child: const Text("Close"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      }, //closes popup
                                    ),
                                  ],
                                );
                              });
                        }
                      }
                    })
                : const SizedBox(height: 10),
          ]),
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  padding: const EdgeInsets.fromLTRB(hOffset, 0, 0, 0),
                  child: Column(children: const [
                    Text('Name: ',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    SizedBox(height: vOffset),
                    Text('Major: ',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold))
                  ]))),
          !_edit
              ? Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(hOffset, 0, 0, 0),
                  child: Container(
                      child: Column(children: [
                    Container(
                        width: MediaQuery.of(context).size.width * 0.5, 
                        child: Text(username, style: labelFont)),
                    SizedBox(height: vOffset),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.5, 
                        child: Text(major, style: labelFont)),
                  ])))
              : Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(hOffset, 0, 0, 0),
                  child: FormBuilder(
                      key: _profileUpdateKey,
                      child: Column(children: [
                        Container(
                            width: 300,
                            height: 30,
                            alignment: Alignment.centerLeft,
                            child: FormBuilderTextField(
                              style: labelFont,
                              initialValue: username,
                              validator: FormBuilderValidators.required(),
                              cursorColor: Colors.black,
                              name: 'Username',
                              decoration: const InputDecoration(
                                hintText: 'New Name',
                                hintStyle: labelFont,
                              ),
                            )),
                        SizedBox(height: vOffset),
                        Container(
                            width: 300,
                            height: 30,
                            alignment: Alignment.centerLeft,
                            child: FormBuilderTextField(
                              style: labelFont,
                              initialValue: major,
                              validator: FormBuilderValidators.required(),
                              cursorColor: Colors.black,
                              name: 'Major',
                              decoration: const InputDecoration(
                                hintText: 'New Major',
                                hintStyle: labelFont,
                              ),
                            )),
                      ])))
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
                      const HeadingBar('Review'),
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
                                    username: username,
                                    major: major,
                                    reviewID: document.id,
                                    subjectCode: document['subjectCode'],
                                    subjectName: _subjectNames.containsKey(
                                            document['subjectCode'])
                                        ? _subjectNames[
                                            document['subjectCode']]!
                                        : 'Loading Subject',
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

  Future updateUserDetails(
      {required String uid,
      required String name,
      required String major}) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'name': name, 'major': major});
  }
}
