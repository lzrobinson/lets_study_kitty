import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lets_study_kitti/routes.dart';
import '../screens/profile_page.dart';

class HomeContents extends StatelessWidget {
  const HomeContents({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.6,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
                child: const _ContentIcon(
                    'assets/images/add.png', 'Add Review', Colors.deepOrange),
                onPressed: () => {
                      if (FirebaseAuth.instance.currentUser != null)
                        {
                          if (FirebaseAuth.instance.currentUser!.emailVerified)
                            {
                              Navigator.pushNamed(
                                  context, Routes.reviewFormPage)
                            }
                          else
                            {
                              showDialog(
                                  context: context,
                                  barrierDismissible:
                                      false, // disables popup to close if tapped outside popup (need a button to close)
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text(
                                        "Cannot Submit Review",
                                      ),
                                      content: const Text(
                                          "Must Verify Email to Submit Review"),
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
                                  })
                            }
                        }
                      else
                        {
                          showDialog(
                              context: context,
                              barrierDismissible:
                                  false, // disables popup to close if tapped outside popup (need a button to close)
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text(
                                    "Cannot Submit Review",
                                  ),
                                  content: const Text(
                                      "Must Log In To Submit a Review"),
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
                              })
                        }
                    }),
            const SizedBox(
              width: 30,
            ),
            MaterialButton(
                key: Key('profileButton'),
                child: _ContentIcon('assets/images/user.png', 'Profile',
                    Colors.purple.shade100),
                onPressed: () => {
                      if (FirebaseAuth.instance.currentUser != null)
                        {
                          if (FirebaseAuth.instance.currentUser!.emailVerified)
                            {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ProfilePage(
                                      userID: FirebaseAuth
                                          .instance.currentUser!.uid)))
                            }
                          else
                            {
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
                                          child: const Text("Close"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          }, //closes popup
                                        ),
                                      ],
                                    );
                                  })
                            }
                        }
                      else
                        {
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
                                      "Must Log In To Access Profile"),
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
                              })
                        }
                    }),
            const SizedBox(
              width: 30,
            ),
            MaterialButton(
                child: _ContentIcon(
                    'assets/images/flame.png', 'Trending Reviews', Colors.lime),
                onPressed: () => {
                      showDialog(
                          context: context,
                          barrierDismissible:
                              false, // disables popup to close if tapped outside popup (need a button to close)
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text(
                                "Cannot See Trending Reviews",
                              ),
                              content: const Text(
                                  "Functionality Not Yet Implemented :("),
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
                          })
                    })
          ],
        ));
  }
}

class _ContentIcon extends StatelessWidget {
  const _ContentIcon(this.image, this.text, this.color);
  final String image;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.2,
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: BoxDecoration(color: color),
      child: Center(
        child: Column(
          children: [
            Image.asset(image,
                width: MediaQuery.of(context).size.width * 0.2 * 0.8,
                height: MediaQuery.of(context).size.height * 0.5 * 0.8),
            Align(
                alignment: Alignment.center,
                child: Text(
                  text,
                  style: const TextStyle(fontSize: 25),
                ))
          ],
        ),
      ),
    );
  }
}
