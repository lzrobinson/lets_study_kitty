import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lets_study_kitti/home_page/home_page.dart';
import 'package:lets_study_kitti/home_page/my_navigation_bar.dart';
import 'package:lets_study_kitti/home_page/website_title.dart';
import 'package:lets_study_kitti/routes.dart';

const outlineColor = Color.fromARGB(100, 0, 0, 0);
const boxColor = Color.fromARGB(255, 254, 244, 225);
const boundarySize = 300.0;
const hOffset = 80.0;
const boxWidth = 250.0;
const boxHeight = 50.0;
const vOffset = 20.0;
const sectionFont = TextStyle(fontSize: 24);
const labelFont = TextStyle(fontSize: 16, color: Colors.black);
const linkFont = TextStyle(fontSize: 16, decoration: TextDecoration.underline);

class VerificationPage extends StatefulWidget {
  const VerificationPage({Key? key}) : super(key: key);

  @override
  State<VerificationPage> createState() {
    return _VerificationPageState();
  }
}

class _VerificationPageState extends State<VerificationPage> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }

  Future checkEmailVerified() async {
    if (FirebaseAuth.instance.currentUser == null) {
      return;
    }

    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) {
      timer?.cancel();
    }
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() => canResendEmail = false);
      await Future.delayed(const Duration(seconds: 5));
      setState(() => canResendEmail = true);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? const HomePage()
      : Scaffold(
          appBar: const MyNavigationBar(),
          body: ListView(children: [
            const SizedBox(height: 50),
            const WebsiteTitle(),
            const SizedBox(height: 50),
            Center(
                child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width - 2 * boundarySize,
                    child: Card(
                        elevation: 10,
                        child: Column(
                          children: [
                            const SizedBox(height: 24),
                            const Text(
                              'A verification email has been sent to the email provided (check spam)',
                              style: labelFont,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                primary: boxColor,
                                minimumSize: const Size.fromHeight(50),
                              ),
                              icon: const Icon(Icons.email,
                                  size: 24, color: Colors.black),
                              label: const Text(
                                'Resend Email',
                                style: labelFont,
                              ),
                              onPressed: () {
                                if (canResendEmail) {
                                  sendVerificationEmail;
                                }
                              },
                            ),
                            /*
                            const SizedBox(height: 8),
                            TextButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(50),
                                primary: boxColor,
                              ),
                              child: const Text(
                                'Cancel',
                                style: labelFont,
                              ),
                              onPressed: () {
                                FirebaseAuth.instance.signOut();
                                Navigator.pushNamed(context, Routes.signUpPage);
                              },
                            ),*/
                            const SizedBox(height: 24),
                          ],
                        ))))
          ]));
}
