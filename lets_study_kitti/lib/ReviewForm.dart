import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

const OUTLINE_COLOR = Color.fromARGB(100, 0, 0, 0);
const BOX_COLOR = Color.fromARGB(255, 254, 244, 225);
const BOUNDARY_SIZE = 100.0;
const H_OFFSET = 60.0;
const BOX_WIDTH = 250.0;
const BOX_HEIGHT = 50.0;
const SECTION_FONT = TextStyle(fontWeight: FontWeight.bold, fontSize: 24);
const LABEL_FONT = TextStyle(fontSize: 16);

class ReviewForm extends StatefulWidget {
  const ReviewForm({Key? key}) : super(key: key);

  @override
  State<ReviewForm> createState() {
    return _ReviewFormState();
  }
}


class _ReviewFormState extends State<ReviewForm> {

  ReviewForm(){}

  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.fromLTRB(BOUNDARY_SIZE, 25, 0, 25),
              child: Text(
                "Add a Review",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)
              ),
            ),
          ),
          Center(child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width - 2*BOUNDARY_SIZE,
            child: Card(
              elevation: 5,
              child: new ReviewElements(), 
              )
            )
          )
        ]
      );
  }
}

class ReviewElements extends StatelessWidget{

  GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

   Widget build(BuildContext context) {
    return Column(
      children:[
        FormBuilder(
          key: _formKey,
          child: ListView(
                  shrinkWrap: true,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(H_OFFSET, 25, 0, 10),
                        child: Text(
                          'Subject Information',
                          style: SECTION_FONT
                        )
                      )
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: H_OFFSET, vertical: 20),
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: BOX_WIDTH,
                        height: BOX_HEIGHT,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: BOX_COLOR,
                          border: Border.all(color: OUTLINE_COLOR)
                        ),
                        child: FormBuilderTextField(
                          cursorColor: Colors.black,
                          name: 'Subject Code',
                          decoration: InputDecoration(
                            hintText: "Subject Code",
                            hintStyle: LABEL_FONT,
                            contentPadding:
                                EdgeInsets.only(top: 5.0, bottom: 5.0),
                            border: InputBorder.none,
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.numeric(),
                            FormBuilderValidators.minLength(5),
                            FormBuilderValidators.maxLength(5),
                          ])
                        )
                      ),  
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: H_OFFSET),
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: BOX_WIDTH,
                        height: BOX_HEIGHT,
                        //padding: EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                          color: BOX_COLOR,
                          borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        child: FormBuilderDropdown(
                          name: 'Year Taken',
                        decoration: InputDecoration(
                          labelText: "Year Taken",
                          labelStyle: LABEL_FONT,                          
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(),
                              borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                          suffix: IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                _formKey.currentState?.fields['Year Taken']
                                    ?.reset();
                              },
                            ),
                        ),
                          items: ['2021', '2020', '2019', '2018', '2017', '2016', '2015', '2014']
                              .map((year) => DropdownMenuItem(
                                    alignment: AlignmentDirectional.centerStart,
                                    value: year,
                                    child: Text(year),
                                  ))
                              .toList(),
                        ),
                      ),  
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: H_OFFSET, vertical: 20),
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: BOX_WIDTH,
                        height: BOX_HEIGHT,
                        decoration: BoxDecoration(
                          color: BOX_COLOR,
                          borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        child: FormBuilderDropdown(
                          name: 'Semester Taken',
                          decoration: InputDecoration(
                            border: new OutlineInputBorder(
                              borderSide: new BorderSide(),
                              borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                            labelText: 'Semester Taken',
                            labelStyle: LABEL_FONT,
                            suffix: IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                _formKey.currentState?.fields['Semester Taken']
                                    ?.reset();
                              },
                            ),
                            hintText: 'What semester was the subject taken',
                          ),
                          items: ['Semester 1', 'Semester 2']
                              .map((sem) => DropdownMenuItem(
                                    alignment: AlignmentDirectional.centerStart,
                                    value: sem,
                                    child: Text(sem),
                                  ))
                              .toList(),
                          ),
                      ),  
                    ),
                  Container(
                    padding: EdgeInsets.only(left: H_OFFSET, bottom: 20),
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: BOX_WIDTH,
                      height: BOX_HEIGHT,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: BOX_COLOR,
                        border: Border.all(color: OUTLINE_COLOR)
                      ),
                      child: FormBuilderTextField(
                        cursorColor: Colors.black,
                        name: 'Lecturer',
                        decoration: InputDecoration(
                          hintText: "Lecturer",
                          hintStyle: LABEL_FONT,
                          contentPadding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                          border: InputBorder.none,
                        ),
                      )
                    ),  
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(H_OFFSET, 25, 0, 25),
                      child: Text(
                        'Subject Scores',
                       style: SECTION_FONT
                        )
                    )
                  ),
                  Container(
                    padding: EdgeInsets.only(left: H_OFFSET, bottom: 10),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Container(
                          width: BOX_WIDTH,
                          child: Text("Difficulty",
                            style: LABEL_FONT
                          )
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: BOX_HEIGHT,
                            height: BOX_HEIGHT,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: BOX_COLOR,
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              border: Border.all(color: OUTLINE_COLOR)
                            ),
                            child: FormBuilderTextField(
                              cursorColor: Colors.black,
                              name: 'Difficulty',
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(top: 5.0, bottom: 5.0),
                                border: InputBorder.none,
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.numeric(),
                                FormBuilderValidators.max(10),
                                FormBuilderValidators.min(0),
                              ])
                            )
                          ),  
                        ),
                      ]
                    )
                      
                  ),
                  Container(
                    padding: EdgeInsets.only(left: H_OFFSET, bottom: 10),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Container(
                          width: BOX_WIDTH,
                          child: Text("How fun/interesting you found it",
                            style: LABEL_FONT,
                          )
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: BOX_HEIGHT,
                            height: BOX_HEIGHT,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: BOX_COLOR,
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              border: Border.all(color: OUTLINE_COLOR)
                            ),
                            child: FormBuilderTextField(
                              cursorColor: Colors.black,
                              name: 'Interest',
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(top: 5.0, bottom: 5.0),
                                border: InputBorder.none,
                              ),
                              keyboardType: TextInputType.numberWithOptions(decimal: true),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.numeric(),
                                FormBuilderValidators.max(10),
                                FormBuilderValidators.min(0),
                              ])                            
                            )
                          ),  
                        ),
                      ]
                    )
                  ),
                  Container(
                    padding: EdgeInsets.only(left: H_OFFSET, bottom: 10),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Container(
                          width: BOX_WIDTH,
                          child: Text("Teaching Quality",
                            style: LABEL_FONT,
                          )
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: BOX_HEIGHT,
                            height: BOX_HEIGHT,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: BOX_COLOR,
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              border: Border.all(color: OUTLINE_COLOR)
                            ),
                            child: FormBuilderTextField(
                              cursorColor: Colors.black,
                              name: 'Teaching',
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(top: 5.0, bottom: 5.0),
                                border: InputBorder.none,
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.numeric(),
                                FormBuilderValidators.max(10),
                                FormBuilderValidators.min(0),
                              ])
                            )
                          ),  
                        ),
                      ]
                    )
                      
                  ),
                  Container(
                    padding: EdgeInsets.only(left: H_OFFSET, top: 10, bottom: 10),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Container(
                          width: BOX_WIDTH/2,
                          child: Text("Recommend",
                            style: LABEL_FONT,
                          )
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: BOX_WIDTH/2,
                            height: BOX_HEIGHT,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: BOX_COLOR,
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              border: Border.all(color: OUTLINE_COLOR)
                            ),
                            child: FormBuilderDropdown(
                              name: 'Recommended',
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: BOX_COLOR)),
                              ),
                              items: ['Yes', 'No']
                                  .map((recommend) => DropdownMenuItem(
                                        alignment: AlignmentDirectional.centerStart,
                                        value: recommend,
                                        child: Text(recommend),
                                      ))
                                  .toList(),
                            ),
                          ),  
                        ),
                      ]
                    )
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(H_OFFSET, 25, 0, 20),
                        child: Text(
                          'Subject Review',
                          style: SECTION_FONT
                        )
                      )
                    ),
                  Container(
                  padding: EdgeInsets.symmetric(horizontal: H_OFFSET),
                  child: Container(
                    height: 360,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      color: BOX_COLOR,
                      border: Border.all(color: OUTLINE_COLOR)
                    ),
                    child: FormBuilderTextField(
                      cursorColor: Colors.black,
                      name: 'Review',
                      decoration: InputDecoration(
                        contentPadding:
                          EdgeInsets.only(top: 5.0, bottom: 5.0),
                          border: InputBorder.none,
                      ),
                    )
                  ),
                )
                ],)
              ),
            SizedBox(height:30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  child: Text("Submit"),
                  onPressed: () {
                    final validationSuccess = _formKey.currentState?.validate();
                    if(validationSuccess ?? false) {
                      _formKey.currentState?.save();
                      debugPrint(_formKey.currentState?.value.toString());
                      debugPrint("validated");
                    }
                    else {
                      debugPrint(_formKey.currentState?.value.toString());
                      debugPrint('validation failed');
                      }
                  }
                )
              ]
            )
      ],      
    );
   }
}



