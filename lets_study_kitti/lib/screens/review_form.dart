import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:lets_study_kitti/routes.dart';

const outlineColor = Color.fromARGB(100, 0, 0, 0);
const boxColor = Color.fromARGB(255, 254, 244, 225);
const boundarySize = 100.0;
const hOffset = 60.0;
const boxWidth = 250.0;
const boxHeight = 50.0;
const sectionFont = TextStyle(fontWeight: FontWeight.bold, fontSize: 24);
const labelFont = TextStyle(fontSize: 16);

class ReviewForm extends StatefulWidget {
  const ReviewForm({Key? key}) : super(key: key);

  @override
  State<ReviewForm> createState() {
    return _ReviewFormState();
  }
}

class _ReviewFormState extends State<ReviewForm> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  bool subjectSelected = false;

  Map<String, String> _subjectCodes = {};
  final _firestore = FirebaseFirestore.instance;
  bool isLoading = false;
  String forSubject = '';

  void addSubjectCodes() {
    _firestore.collection('subjects').get().then((QuerySnapshot querySnapshot) {
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
    return ListView(shrinkWrap: true, children: [
      Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.fromLTRB(boundarySize, 25, 0, 25),
          child: const Text("Add a Review",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
        ),
      ),
      Center(
          child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width - 2 * boundarySize,
              child: Card(
                  elevation: 5,
                  child: Column(
                    children: [
                      FormBuilder(
                          key: _formKey,
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          hOffset, 25, 0, 10),
                                      child: const Text('Subject Information',
                                          style: sectionFont))),
                              Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: hOffset, vertical: 20),
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                      color: boxColor,
                                      height: boxHeight,
                                      width: boxWidth,
                                      child: Autocomplete<String>(
                                          optionsBuilder: (TextEditingValue
                                              textEditingValue) {
                                        if (textEditingValue.text == '') {
                                          return const Iterable<String>.empty();
                                        }
                                        return _subjectCodes.keys
                                            .where((String option) {
                                          return option.toUpperCase().contains(
                                              textEditingValue.text
                                                  .toUpperCase());
                                        });
                                      }, optionsViewBuilder:
                                              (context, onSelected, options) {
                                        return Align(
                                          alignment: Alignment.topLeft,
                                          child: Material(
                                            shape: const RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                      bottom:
                                                          Radius.circular(4.0)),
                                            ),
                                            child: SizedBox(
                                              height: 52.0 * options.length,
                                              width: boxWidth,
                                              child: ListView.builder(
                                                padding: EdgeInsets.zero,
                                                itemCount: options.length,
                                                shrinkWrap: false,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  final String option =
                                                      options.elementAt(index);
                                                  return InkWell(
                                                    onTap: () =>
                                                        onSelected(option),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              16.0),
                                                      child: Text(option),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        );
                                      }, fieldViewBuilder: (context,
                                              textEditingController,
                                              focusNode,
                                              onFieldSubmitted) {
                                        return TextField(
                                            enabled: !subjectSelected,
                                            controller: textEditingController,
                                            focusNode: focusNode,
                                            cursorColor: Colors.black,
                                            decoration: const InputDecoration(
                                                fillColor: boxColor,
                                                border: OutlineInputBorder(),
                                                hintText: 'Subject',
                                                focusedBorder:
                                                    OutlineInputBorder()));
                                      }, onSelected: (String value) {
                                        forSubject = value;
                                        setState(() => subjectSelected = true);
                                      }))),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: hOffset),
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  width: boxWidth,
                                  height: boxHeight,
                                  //padding: EdgeInsets.only(left: 20, right: 20),
                                  decoration: const BoxDecoration(
                                      color: boxColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: FormBuilderDropdown(
                                    validator: FormBuilderValidators.required(),
                                    name: 'Year Taken',
                                    decoration: InputDecoration(
                                      labelText: "Year Taken",
                                      labelStyle: labelFont,
                                      border: const OutlineInputBorder(
                                          borderSide: BorderSide(),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      suffixIcon: IconButton(
                                        icon: const Icon(Icons.close),
                                        onPressed: () {
                                          _formKey.currentState
                                              ?.fields['Year Taken']
                                              ?.reset();
                                        },
                                      ),
                                    ),
                                    items: List.generate(
                                            100, (i) => (2022 - i).toString())
                                        .map((year) => DropdownMenuItem(
                                              alignment: AlignmentDirectional
                                                  .centerStart,
                                              value: year,
                                              child: Text(year),
                                            ))
                                        .toList(),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: hOffset, vertical: 20),
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  width: boxWidth,
                                  height: boxHeight,
                                  decoration: const BoxDecoration(
                                      color: boxColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: FormBuilderDropdown(
                                    validator: FormBuilderValidators.required(),
                                    name: 'Semester Taken',
                                    decoration: InputDecoration(
                                      border: const OutlineInputBorder(
                                          borderSide: BorderSide(),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      labelText: 'Semester Taken',
                                      labelStyle: labelFont,
                                      suffixIcon: IconButton(
                                        icon: const Icon(Icons.close),
                                        onPressed: () {
                                          _formKey.currentState
                                              ?.fields['Semester Taken']
                                              ?.reset();
                                        },
                                      ),
                                      hintText:
                                          'What semester was the subject taken',
                                    ),
                                    items: [
                                      'Semester 1',
                                      'Semester 2',
                                      'Year-Long',
                                      'Summer',
                                      'Winter'
                                    ]
                                        .map((sem) => DropdownMenuItem(
                                              alignment: AlignmentDirectional
                                                  .centerStart,
                                              value: sem,
                                              child: Text(sem),
                                            ))
                                        .toList(),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: hOffset, bottom: 20),
                                alignment: Alignment.centerLeft,
                                child: Container(
                                    width: boxWidth,
                                    height: boxHeight,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    decoration: BoxDecoration(
                                        color: boxColor,
                                        border:
                                            Border.all(color: outlineColor)),
                                    child: FormBuilderTextField(
                                      validator:
                                          FormBuilderValidators.required(),
                                      cursorColor: Colors.black,
                                      name: 'Lecturer',
                                      decoration: const InputDecoration(
                                        hintText: "Lecturer",
                                        hintStyle: labelFont,
                                        contentPadding: EdgeInsets.only(
                                            top: 5.0, bottom: 5.0),
                                        border: InputBorder.none,
                                      ),
                                    )),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: hOffset),
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  width: boxWidth,
                                  height: boxHeight,
                                  decoration: const BoxDecoration(
                                      color: boxColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: FormBuilderDropdown(
                                    validator: FormBuilderValidators.required(),
                                    name: 'Stream',
                                    decoration: InputDecoration(
                                      border: const OutlineInputBorder(
                                          borderSide: BorderSide(),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      labelText: 'Stream',
                                      labelStyle: labelFont,
                                      suffixIcon: IconButton(
                                        icon: const Icon(Icons.close),
                                        onPressed: () {
                                          _formKey
                                              .currentState?.fields['Stream']
                                              ?.reset();
                                        },
                                      ),
                                      hintText: 'What Stream Was This Subject',
                                    ),
                                    items: ['Core', 'Elective', 'Breadth']
                                        .map((stream) => DropdownMenuItem(
                                              alignment: AlignmentDirectional
                                                  .centerStart,
                                              value: stream,
                                              child: Text(stream),
                                            ))
                                        .toList(),
                                  ),
                                ),
                              ),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          hOffset, 25, 0, 25),
                                      child: const Text('Subject Scores (0-10)',
                                          style: sectionFont))),
                              Container(
                                  padding: const EdgeInsets.only(
                                      left: hOffset, bottom: 10),
                                  alignment: Alignment.centerLeft,
                                  child: Row(children: [
                                    const SizedBox(
                                        width: boxWidth,
                                        child: Text("Difficulty",
                                            style: labelFont)),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                          width: boxHeight,
                                          height: boxHeight,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          decoration: BoxDecoration(
                                              color: boxColor,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(20)),
                                              border: Border.all(
                                                  color: outlineColor)),
                                          child: FormBuilderTextField(
                                              cursorColor: Colors.black,
                                              name: 'Difficulty',
                                              decoration: const InputDecoration(
                                                contentPadding: EdgeInsets.only(
                                                    top: 5.0, bottom: 5.0),
                                                border: InputBorder.none,
                                              ),
                                              validator: FormBuilderValidators
                                                  .compose([
                                                FormBuilderValidators.required(
                                                    errorText: '0-10'),
                                                FormBuilderValidators.numeric(
                                                    errorText: '0-10'),
                                                FormBuilderValidators.max(10,
                                                    errorText: '0-10'),
                                                FormBuilderValidators.min(0,
                                                    errorText: '0-10'),
                                              ]))),
                                    ),
                                  ])),
                              Container(
                                  padding: const EdgeInsets.only(
                                      left: hOffset, bottom: 10),
                                  alignment: Alignment.centerLeft,
                                  child: Row(children: [
                                    const SizedBox(
                                        width: boxWidth,
                                        child: Text(
                                          "How fun/interesting you found it",
                                          style: labelFont,
                                        )),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                          width: boxHeight,
                                          height: boxHeight,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          decoration: BoxDecoration(
                                              color: boxColor,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(20)),
                                              border: Border.all(
                                                  color: outlineColor)),
                                          child: FormBuilderTextField(
                                              cursorColor: Colors.black,
                                              name: 'Interest',
                                              decoration: const InputDecoration(
                                                contentPadding: EdgeInsets.only(
                                                    top: 5.0, bottom: 5.0),
                                                border: InputBorder.none,
                                              ),
                                              keyboardType: const TextInputType
                                                      .numberWithOptions(
                                                  decimal: true),
                                              validator: FormBuilderValidators
                                                  .compose([
                                                FormBuilderValidators.required(
                                                    errorText: '0-10'),
                                                FormBuilderValidators.numeric(
                                                    errorText: '0-10'),
                                                FormBuilderValidators.max(10,
                                                    errorText: '0-10'),
                                                FormBuilderValidators.min(0,
                                                    errorText: '0-10'),
                                              ]))),
                                    ),
                                  ])),
                              Container(
                                  padding: const EdgeInsets.only(
                                      left: hOffset, bottom: 10),
                                  alignment: Alignment.centerLeft,
                                  child: Row(children: [
                                    const SizedBox(
                                        width: boxWidth,
                                        child: Text(
                                          "Teaching Quality",
                                          style: labelFont,
                                        )),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                          width: boxHeight,
                                          height: boxHeight,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          decoration: BoxDecoration(
                                              color: boxColor,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(20)),
                                              border: Border.all(
                                                  color: outlineColor)),
                                          child: FormBuilderTextField(
                                              cursorColor: Colors.black,
                                              name: 'Teaching',
                                              decoration: const InputDecoration(
                                                contentPadding: EdgeInsets.only(
                                                    top: 5.0, bottom: 5.0),
                                                border: InputBorder.none,
                                              ),
                                              validator: FormBuilderValidators
                                                  .compose([
                                                FormBuilderValidators.required(
                                                    errorText: '0-10'),
                                                FormBuilderValidators.numeric(
                                                    errorText: '0-10'),
                                                FormBuilderValidators.max(10,
                                                    errorText: '0-10'),
                                                FormBuilderValidators.min(0,
                                                    errorText: '0-10'),
                                              ]))),
                                    ),
                                  ])),
                              Container(
                                  padding: const EdgeInsets.only(
                                      left: hOffset, top: 10, bottom: 10),
                                  alignment: Alignment.centerLeft,
                                  child: Row(children: [
                                    const SizedBox(
                                        width: boxWidth / 2,
                                        child: Text(
                                          "Recommend",
                                          style: labelFont,
                                        )),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        width: boxWidth / 1.5,
                                        height: boxHeight,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        decoration: BoxDecoration(
                                            color: boxColor,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(20)),
                                            border: Border.all(
                                                color: outlineColor)),
                                        child: FormBuilderDropdown(
                                          validator:
                                              FormBuilderValidators.required(
                                                  errorText: "required"),
                                          name: 'Recommended',
                                          decoration: InputDecoration(
                                            enabledBorder:
                                                const UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: boxColor)),
                                            suffixIcon: IconButton(
                                              icon: const Icon(Icons.close),
                                              onPressed: () {
                                                _formKey.currentState
                                                    ?.fields['Recommended']
                                                    ?.reset();
                                              },
                                            ),
                                          ),
                                          items: ['Yes', 'No']
                                              .map((recommend) =>
                                                  DropdownMenuItem(
                                                    alignment:
                                                        AlignmentDirectional
                                                            .centerStart,
                                                    value: recommend,
                                                    child: Text(recommend),
                                                  ))
                                              .toList(),
                                        ),
                                      ),
                                    ),
                                  ])),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          hOffset, 25, 0, 20),
                                      child: const Text('Subject Review',
                                          style: sectionFont))),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: hOffset),
                                child: Container(
                                    height: 360,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    decoration: BoxDecoration(
                                        color: boxColor,
                                        border:
                                            Border.all(color: outlineColor)),
                                    child: FormBuilderTextField(
                                      validator:
                                          FormBuilderValidators.required(),
                                      cursorColor: Colors.black,
                                      name: 'Review',
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                            top: 5.0, bottom: 5.0),
                                        border: InputBorder.none,
                                      ),
                                    )),
                              )
                            ],
                          )),
                      const SizedBox(height: 30),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                width: boxWidth,
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 250, 172, 26),
                                        border:
                                            Border.all(color: outlineColor)),
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
                                              final validationSuccess = _formKey
                                                  .currentState!
                                                  .validate();
                                              if (forSubject == '') {
                                                showDialog(
                                                    context: context,
                                                    barrierDismissible:
                                                        false, // disables popup to close if tapped outside popup (need a button to close)
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: const Text(
                                                          "Form Submission Unsuccesful",
                                                        ),
                                                        content: const Text(
                                                            "Must Specify Subject"),
                                                        actions: <Widget>[
                                                          MaterialButton(
                                                            child: const Text(
                                                                "Close"),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            }, //closes popup
                                                          ),
                                                        ],
                                                      );
                                                    });
                                                isLoading = false;
                                                return;
                                              } else if (validationSuccess ==
                                                  true) {
                                                _formKey.currentState?.save();
                                                debugPrint(_formKey
                                                    .currentState?.value
                                                    .toString());
                                                //uploadToDatabase('MAST30027', '2017', 'Semester 1', 'Mr John', 3, 4, 5, 'Yes', 'great', 10, 'core');
                                                debugPrint(forSubject);
                                                await uploadToDatabase(
                                                  subjectCode: _subjectCodes[
                                                      forSubject]!,
                                                  yearTaken: _formKey
                                                      .currentState!
                                                      .fields['Year Taken']!
                                                      .value
                                                      .toString(),
                                                  semTaken: _formKey
                                                      .currentState!
                                                      .fields['Semester Taken']!
                                                      .value
                                                      .toString(),
                                                  lecturer: _formKey
                                                      .currentState!
                                                      .fields['Lecturer']!
                                                      .value
                                                      .toString(),
                                                  difficulty: double.parse(
                                                      _formKey
                                                          .currentState!
                                                          .fields['Difficulty']!
                                                          .value),
                                                  interest: double.parse(
                                                      _formKey
                                                          .currentState!
                                                          .fields['Interest']!
                                                          .value),
                                                  teachingQuality: double.parse(
                                                      _formKey
                                                          .currentState!
                                                          .fields['Teaching']!
                                                          .value),
                                                  recommend: _formKey
                                                      .currentState!
                                                      .fields['Recommended']!
                                                      .value
                                                      .toString(),
                                                  reviewText: _formKey
                                                      .currentState!
                                                      .fields['Review']!
                                                      .value
                                                      .toString(),
                                                  subjectType: _formKey
                                                      .currentState!
                                                      .fields['Stream']!
                                                      .value
                                                      .toString(),
                                                );
                                                setState(() {
                                                  isLoading = false;
                                                });
                                              } else {
                                                debugPrint(_formKey
                                                    .currentState?.value
                                                    .toString());
                                                debugPrint('validation failed');
                                                setState(() {
                                                  isLoading = false;
                                                });
                                                return;
                                              }
                                              if (!mounted) {
                                                return;
                                              }
                                              Navigator.pushNamed(
                                                  context, Routes.homePage);
                                            })))
                          ])
                    ],
                  ))))
    ]);
  }

  Future uploadToDatabase(
      {required String subjectCode,
      required String yearTaken,
      required String semTaken,
      required String lecturer,
      required double difficulty,
      required double interest,
      required double teachingQuality,
      required String recommend,
      required String reviewText,
      required String subjectType}) async {
    final docUser = FirebaseFirestore.instance.collection('reviews').doc();
    final FirebaseAuth auth = FirebaseAuth.instance;

    final User user = auth.currentUser!;
    final uid = user.uid;

    debugPrint(uid);

    final json = {
      'subjectCode': subjectCode,
      'userID': uid,
      'lecturer': lecturer,
      'subjectType': subjectType,
      'semesterTaken': semTaken,
      'year': yearTaken,
      'teachingQuality': teachingQuality,
      'difficulty': difficulty,
      'interesting': interest,
      'reviewText': reviewText,
      'recommended': recommend,
    };

    await docUser.set(json);
  }

  // List of possible subject code and subject name starting with entered values
  List readData(String val) {
    List<String> subjects = <String>[];
    FirebaseFirestore.instance
        .collection('subjects')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc['subjectCode']
            .toString()
            .toLowerCase()
            .startsWith(val.toLowerCase())) {
          String sub = doc['subjectCode'] + ' ' + doc["subjectName"];
          subjects.add(sub);
        }
      });
      return subjects;
    });
    return [];
  }
}
