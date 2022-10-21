import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:lets_study_kitti/home_page/my_navigation_bar.dart';
import 'package:lets_study_kitti/home_page/website_title.dart';
import 'package:lets_study_kitti/routes.dart';
import 'package:lets_study_kitti/services/firebase_helper.dart';

const outlineColor = Color.fromARGB(100, 0, 0, 0);
const boxColor = Color.fromARGB(255, 254, 244, 225);
const boundarySize = 300.0;
const hOffset = 80.0;
const boxWidth = 250.0;
const boxHeight = 50.0;
const vOffset = 20.0;
const sectionFont = TextStyle(fontSize: 24);
const labelFont = TextStyle(fontSize: 16);
const linkFont = TextStyle(fontSize: 16, decoration: TextDecoration.underline);

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() {
    return _SignUpPageState();
  }
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyNavigationBar(),
        body: ListView(shrinkWrap: true, children: [
          const SizedBox(height: 50),
          const WebsiteTitle(),
          const SizedBox(height: 50),
          Center(
              child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width - 2 * boundarySize,
                  child: Card(
                      elevation: 10,
                      child: Column(children: [
                        FormBuilder(
                            key: _formKey,
                            child: ListView(shrinkWrap: true, children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          hOffset, 2 * vOffset, 0, 10),
                                      child: const Text('Create an account',
                                          style: sectionFont))),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: hOffset, vertical: vOffset),
                                alignment: Alignment.centerLeft,
                                child: Container(
                                    key: const Key('emailInput'),
                                    height: boxHeight,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    decoration: const BoxDecoration(
                                      color: boxColor,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: FormBuilderTextField(
                                        cursorColor: Colors.black,
                                        name: 'email',
                                        decoration: const InputDecoration(
                                          hintText: "email",
                                          hintStyle: labelFont,
                                          contentPadding: EdgeInsets.only(
                                              top: 5.0, bottom: 5.0),
                                          border: InputBorder.none,
                                        ),
                                        validator:
                                            FormBuilderValidators.compose([
                                          FormBuilderValidators.required(),
                                          FormBuilderValidators.email(),
                                        ]))),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: hOffset,
                                    right: hOffset,
                                    bottom: vOffset),
                                alignment: Alignment.centerLeft,
                                child: Container(
                                    key: Key('passwordInput'),
                                    height: boxHeight,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    decoration: const BoxDecoration(
                                      color: boxColor,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: FormBuilderTextField(
                                        cursorColor: Colors.black,
                                        name: 'password',
                                        decoration: const InputDecoration(
                                          hintText: "password",
                                          hintStyle: labelFont,
                                          contentPadding: EdgeInsets.only(
                                              top: 5.0, bottom: 5.0),
                                          border: InputBorder.none,
                                        ),
                                        validator:
                                            FormBuilderValidators.compose([
                                          FormBuilderValidators.required(),
                                          FormBuilderValidators.minLength(6),
                                        ]))),
                              ),
                              Container(
                                  padding: const EdgeInsets.only(
                                      left: hOffset,
                                      right: hOffset,
                                      bottom: vOffset),
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                      key: Key('passwordCInput'),
                                      height: boxHeight,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      decoration: const BoxDecoration(
                                        color: boxColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                      child: FormBuilderTextField(
                                          autovalidateMode:
                                              AutovalidateMode.disabled,
                                          cursorColor: Colors.black,
                                          name: 'password_r',
                                          decoration: const InputDecoration(
                                            hintText: "confirm password",
                                            hintStyle: labelFont,
                                            contentPadding: EdgeInsets.only(
                                                top: 5.0, bottom: 5.0),
                                            border: InputBorder.none,
                                          ),
                                          validator: (value) {
                                            if (value !=
                                                _formKey.currentState!
                                                    .fields['password']!.value
                                                    .toString()) {
                                              return 'Password is not matching';
                                            } else {
                                              return null;
                                            }
                                          }))),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: hOffset,
                                    right: hOffset,
                                    bottom: vOffset),
                                alignment: Alignment.centerLeft,
                                child: Container(
                                    key: Key('nameInput'),
                                    height: boxHeight,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    decoration: const BoxDecoration(
                                      color: boxColor,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: FormBuilderTextField(
                                        cursorColor: Colors.black,
                                        name: 'name',
                                        decoration: const InputDecoration(
                                          hintText: "name",
                                          hintStyle: labelFont,
                                          contentPadding: EdgeInsets.only(
                                              top: 5.0, bottom: 5.0),
                                          border: InputBorder.none,
                                        ),
                                        validator:
                                            FormBuilderValidators.compose([
                                          FormBuilderValidators.required(),
                                        ]))),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: hOffset,
                                    right: hOffset,
                                    bottom: vOffset),
                                alignment: Alignment.centerLeft,
                                child: Container(
                                    key: Key('majorInput'),
                                    height: boxHeight,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    decoration: const BoxDecoration(
                                      color: boxColor,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: FormBuilderTextField(
                                        cursorColor: Colors.black,
                                        name: 'major',
                                        decoration: const InputDecoration(
                                          hintText: "major",
                                          hintStyle: labelFont,
                                          contentPadding: EdgeInsets.only(
                                              top: 5.0, bottom: 5.0),
                                          border: InputBorder.none,
                                        ),
                                        validator:
                                            FormBuilderValidators.compose([
                                          FormBuilderValidators.required(),
                                        ]))),
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        width: boxWidth,
                                        padding: const EdgeInsets.only(
                                            bottom: 2 * vOffset),
                                        child: Container(
                                            decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 250, 172, 26),
                                                border: Border.all(
                                                    color: outlineColor)),
                                            child: isLoading
                                                ? const LinearProgressIndicator(
                                                    color: Colors.orange,
                                                    backgroundColor:
                                                        Colors.white)
                                                : MaterialButton(
                                                    child: const Text(
                                                        "CREATE ACCOUNT",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        )),
                                                    onPressed: () async {
                                                      setState(() {
                                                        isLoading = true;
                                                      });
                                                      final validationSuccess =
                                                          _formKey.currentState!
                                                              .validate();
                                                      if (validationSuccess ==
                                                          true) {
                                                        _formKey.currentState
                                                            ?.save();
                                                        try {
                                                          final isSaved = await FirebaseHelper.saveUser(
                                                              email: _formKey
                                                                      .currentState
                                                                      ?.value[
                                                                  'email'],
                                                              password: _formKey
                                                                      .currentState
                                                                      ?.value[
                                                                  'password'],
                                                              name: _formKey
                                                                      .currentState
                                                                      ?.value[
                                                                  'name'],
                                                              major: _formKey
                                                                      .currentState
                                                                      ?.value[
                                                                  'major']);
                                                          debugPrint(isSaved
                                                              .toString());
                                                        } catch (e) {
                                                          showDialog(
                                                              context: context,
                                                              barrierDismissible:
                                                                  false, // disables popup to close if tapped outside popup (need a button to close)
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return AlertDialog(
                                                                  title:
                                                                      const Text(
                                                                    "Unsuccesful Account Creation",
                                                                  ),
                                                                  content:
                                                                      const Text(
                                                                          "Email in Use"),
                                                                  //buttons?
                                                                  actions: <
                                                                      Widget>[
                                                                    MaterialButton(
                                                                      child: const Text(
                                                                          "Close"),
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      }, //closes popup
                                                                    ),
                                                                  ],
                                                                );
                                                              });
                                                          setState(() {
                                                            isLoading = false;
                                                          });
                                                          return;
                                                        }

                                                        setState(() {
                                                          isLoading = false;
                                                        });
                                                      } else {
                                                        debugPrint(_formKey
                                                            .currentState?.value
                                                            .toString());
                                                        debugPrint(
                                                            'validation failed');
                                                        setState(() {
                                                          isLoading = false;
                                                        });
                                                        return;
                                                      }
                                                      if (!mounted) {
                                                        return;
                                                      }
                                                      Navigator.pushNamed(
                                                          context,
                                                          Routes
                                                              .verifyEmailPage);
                                                    })))
                                  ]),
                            ]))
                      ]))))
        ]));
  }
}
