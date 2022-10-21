import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lets_study_kitti/routes.dart';
import 'package:lets_study_kitti/screens/profile_page.dart';
import 'package:lets_study_kitti/screens/subject_page.dart';

const boxColor = Color.fromARGB(255, 254, 244, 225);

class MyNavigationBar extends StatefulWidget with PreferredSizeWidget {
  const MyNavigationBar({super.key});

  @override
  State<MyNavigationBar> createState() {
    return _MyNavigationBarState();
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  Map<String, String> _subjectCodes = {};
  final _firestore = FirebaseFirestore.instance;
  bool isLoading = false;
  String forSubject = '';

  void addSubjectCodes() {
    _firestore.collection('subjects').get().then((QuerySnapshot querySnapshot) {
      if (!mounted) return;
      setState(() {
        querySnapshot.docs.forEach((doc) {
          _subjectCodes[doc['subjectName']] = doc['subjectCode'];
        });
      });
    });
  }

  void initState() {
    super.initState();
    addSubjectCodes();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange,
      padding: const EdgeInsets.all(5),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: <Widget>[
          MaterialButton(
              height: 30,
              child:
                  Image.asset('assets/images/home.png', height: 30, width: 30),
              onPressed: () => Navigator.pushNamed(context, Routes.homePage)),
          SizedBox(
            width: MediaQuery.of(context).size.width - 320,
            child: Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text == '') {
                    return const Iterable<String>.empty();
                  }
                  return _subjectCodes.keys.where((String option) {
                    return option
                        .toUpperCase()
                        .contains(textEditingValue.text.toUpperCase());
                  });
                },
                fieldViewBuilder: (context, textEditingController, focusNode,
                    onFieldSubmitted) {
                  return TextField(
                      controller: textEditingController,
                      focusNode: focusNode,
                      cursorColor: Colors.black,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Search Subjects',
                          focusedBorder: OutlineInputBorder()));
                },
                onSelected: (String value) => Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) =>
                            SubjectPage(subjectCode: _subjectCodes[value]!)))),
          ),
          FirebaseAuth.instance.currentUser == null
              ? Row(children: [
                  SizedBox(width: 40),
                  MaterialButton(
                    key: Key('signInButton'),
                    child: Row(
                      children: <Widget>[
                        Image.asset('assets/images/user.png',
                            height: 20, width: 20),
                        const Text(' Login/Sign Up'),
                      ],
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.loginPage);
                    },
                  ),
                ])
              : Row(children: [
                  MaterialButton(
                    child: Row(
                      children: <Widget>[
                        Image.asset('assets/images/user.png',
                            height: 20, width: 20),
                        const Text(' View Profile'),
                      ],
                    ),
                    onPressed: () {
                      if (FirebaseAuth.instance.currentUser!.emailVerified) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ProfilePage(
                                userID:
                                    FirebaseAuth.instance.currentUser!.uid)));
                      } else {
                        showDialog(
                            context: context,
                            barrierDismissible:
                                false, // disables popup to close if tapped outside popup (need a button to close)
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text(
                                  "Cannot Access Profile",
                                ),
                                content: const Text(
                                    "Must Verify Email to Access Profile"),
                                //buttons?
                                actions: <Widget>[
                                  MaterialButton(
                                    child: const Text("Verify Email"),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, Routes.verifyEmailPage);
                                    }, //closes popup
                                  ),
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
                    },
                  ),
                  MaterialButton(
                      child: Row(
                        children: <Widget>[
                          Image.asset('assets/images/enter.png',
                              height: 20, width: 20),
                          const Text(' Sign Out'),
                        ],
                      ),
                      onPressed: () => {
                            FirebaseAuth.instance.signOut(),
                            Navigator.pushNamed(context, Routes.homePage)
                          })
                ])
        ],
      ),
    );
  }
}
