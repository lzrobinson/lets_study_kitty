import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lets_study_kitti/routes.dart';
import 'package:lets_study_kitti/screens/review_thread/review_thread_review.dart';

import 'comment_bar.dart';
import 'heading_bar.dart';

const outlineColor = Color.fromARGB(100, 0, 0, 0);

class Comment extends StatefulWidget {
  final String reviewID;
  const Comment({super.key, required this.reviewID});

  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  bool isLoading = false;
  Map<String, List<String>> _userDetails = {};

  void initState() {
    super.initState();
    addUserDetails();
  }

  // Get the majors and  given the userID
  void addUserDetails() {
    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      setState(() {
        querySnapshot.docs.forEach((doc) {
          _userDetails[doc['uid']] = [doc['name'], doc['major']];
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.6),
                spreadRadius: 5,
                blurRadius: 7,
              )
            ]),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              const HeadingBar('Comments'),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: FormBuilder(
                    key: _formKey,
                    child: FormBuilderTextField(
                      validator: FormBuilderValidators.required(),
                      name: 'Comment',
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Add a comment',
                          filled: true,
                          fillColor: Color.fromARGB(102, 236, 155, 49)),
                    ),
                  )),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                    width: MediaQuery.of(context).size.width * 0.1,
                    padding: const EdgeInsets.only(bottom: 20.0, top: 20.0),
                    child: Container(
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 250, 172, 26),
                            border: Border.all(color: outlineColor)),
                        child: isLoading
                            ? const LinearProgressIndicator(
                                color: Colors.orange,
                                backgroundColor: Colors.white)
                            : MaterialButton(
                                child: const Text("SUBMIT",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    )),
                                onPressed: () async {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  final validationSuccess =
                                      _formKey.currentState!.validate();
                                  if (validationSuccess == true) {
                                    if (FirebaseAuth.instance.currentUser !=
                                        null) {
                                      if (FirebaseAuth.instance.currentUser!
                                          .emailVerified) {
                                        _formKey.currentState?.save();
                                        debugPrint(_formKey.currentState?.value
                                            .toString());
                                        await uploadComment(
                                            commentTxt: _formKey.currentState!
                                                .fields['Comment']!.value
                                                .toString(),
                                            reviewID: widget.reviewID,
                                            userID: FirebaseAuth
                                                .instance.currentUser!.uid);
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
                                                    child: const Text(
                                                        "Verify Email"),
                                                    onPressed: () {
                                                      Navigator.pushNamed(
                                                          context,
                                                          Routes
                                                              .verifyEmailPage);
                                                    }, //closes popup
                                                  ),
                                                  MaterialButton(
                                                    child: const Text("Close"),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    }, //closes popup
                                                  ),
                                                ],
                                              );
                                            });
                                      }
                                      setState(() {
                                        isLoading = false;
                                      });
                                      _formKey.currentState?.reset();
                                    } else {
                                      setState(() {
                                        isLoading = false;
                                      });
                                      showDialog(
                                          context: context,
                                          barrierDismissible:
                                              false, // disables popup to close if tapped outside popup (need a button to close)
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text(
                                                "Cannot Submit Comment",
                                              ),
                                              content: const Text(
                                                  "Must Login to Submit a Comment"),
                                              //buttons?
                                              actions: <Widget>[
                                                MaterialButton(
                                                  child: const Text(
                                                      "Log In/Sign Up"),
                                                  onPressed: () {
                                                    Navigator.pushNamed(context,
                                                        Routes.loginPage);
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
                                  } else {
                                    debugPrint(_formKey.currentState?.value
                                        .toString());
                                    debugPrint('validation failed');
                                    setState(() {
                                      isLoading = false;
                                    });
                                    return;
                                  }
                                })))
              ]),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('comments')
                      .where('reviewID', isEqualTo: widget.reviewID)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                          child:
                              CircularProgressIndicator(color: Colors.orange));
                    }
                    return ListView(
                      shrinkWrap: true,
                      children: snapshot.data!.docs.map((document) {
                        return CommentBar(
                            _userDetails[document['userID']]![0],
                            _userDetails[document['userID']]![1],
                            document['commentTxt']);
                      }).toList(),
                    );
                  }),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ));
  }

  Future uploadComment(
      {required String commentTxt,
      required String reviewID,
      required String userID}) async {
    final docUser = FirebaseFirestore.instance.collection('comments').doc();

    final json = {
      'commentTxt': commentTxt,
      'reviewID': reviewID,
      'userID': userID,
    };

    await docUser.set(json);
  }
}
