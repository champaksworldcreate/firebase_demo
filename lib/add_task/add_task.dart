import 'package:firebase_demo/add_task/chose_screensize_page.dart';
import 'package:firebase_demo/app_theam.dart';
import 'package:firebase_demo/home_page/bottombar.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';


import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



//import 'firebase_options.dart';

const List<String> list_a = <String>[
  'Choose',
  'Personal',
  'Office Work',
  'Workout',
  'Yoga',
  'Sport',
  'Birthday'
];
const List<String> list_b = <String>[
  'None',
  'Hour',
  'Daily',
  'Weekly',
  'Monthly',
  'Yearly',
];


class Add_TaskPage extends StatefulWidget {
  static FirebaseFirestore? firestoredb; //=FirebaseFirestore.instance;

  const Add_TaskPage({super.key});
  @override
  State<Add_TaskPage> createState() => _Add_TaskPageState();
}

class _Add_TaskPageState extends State<Add_TaskPage> {
  DateTime _selectedDate1 = DateTime.now();
  DateTime _selectedDate2 = DateTime.now();
//*************Time picker initializer*************
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    firebaseInit();
  }

  void firebaseInit() {
    try {
      //Firebase.initializeApp().whenComplete(() {

      // prin != nullt("Initialized");
      // });
      Add_TaskPage.firestoredb = FirebaseFirestore.instance;
    } catch (ee) {
      print(ee);
    }
  }

  _FirebaseDemoState() {}
  String firebasedata = "data";

  Future<void> _fromDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate1) {
      setState(() {
        _selectedDate1 = picked;
      });
    }
  }

  Future<void> _ToDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate2) {
      setState(() {
        _selectedDate2 = picked;
      });
    }
  }


//*******************Select Time fun()****************
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  String category = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        leading: InkWell(
          child: const Icon(Icons.arrow_circle_left,size: 50,color: Colors.teal,),
          onTap: (){
            Navigator.pop(context);
          },
        ),
        title: const Center(child: Text("Add Task",style: TextStyle(color: Colors.teal,fontWeight: FontWeight.bold,fontSize: 25),)),
      ),
      body: SingleChildScrollView(
        //physics: const BouncingScrollPhysics(),
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),

                const Row(
                  children: [
                    Text(
                      "Task Title",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Container(
                      color: Colors.white,
                      child: SizedBox(
                        width: 350,
                        child: TextField(
                          autofocus: true,
                          controller: App_Text.task_title,
                          cursorColor: Colors.green,
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.green.shade200,
                                //width: 1.5,
                              ),
                            ),

                            //********Focus border like hover******************8
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:  const BorderSide(color: Colors.green)),
                            hintText: "Enter Task",
                            hintStyle:  TextStyle(color: Colors.green.shade200),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  children: [
                    Text(
                      "Sub-Title",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Container(
                      color: Colors.white,
                      child: SizedBox(
                        width: 350,
                        child: TextField(
                          keyboardType: TextInputType.text,
                          autofocus: true,
                          controller: App_Text.sub_title,
                          cursorColor: Colors.green,
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.green.shade200,
                                //width: 1.5,
                              ),
                            ),

                            //********Focus border like hover******************8
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Colors.green)),
                            hintText: "Enter Sub-Task",
                            hintStyle:  TextStyle(color: Colors.green.shade200),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),

                const Row(
                  children: [
                    Text(
                      "Choose Category",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Container(
                        height: 50,
                        width: 350,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.green.shade200),
                            borderRadius: BorderRadius.circular(10)),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: DropdownButtonExample(),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Column(
                      children: [
                        const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 100),
                              child: Text(
                                "Date",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          width: 170,
                          child: GestureDetector(
                            onTap: () => _fromDate(context),
                            child: AbsorbPointer(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:  BorderSide(
                                      color: Colors.green.shade200,
                                      //width: 1.5,
                                    ),
                                  ),
                                  labelText:
                                  _selectedDate1.toString().substring(0, 10),
                                  prefixIcon: const Icon(
                                    Icons.calendar_month,
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Column(
                      children: [
                        const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 100),
                              child: Text(
                                "Time",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                            width: 170,
                            child: InkWell(
                              child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.green.shade200),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Icon(Icons.lock_clock,color: Colors.green,size: 30,),
                                    ),
                                    Text(_selectedTime.format(context))
                                  ],

                                ),
                              ),
                              onTap: (){
                                _selectTime(context);
                              },
                            )
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  children: [
                    Text(
                      "Repeat Task",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Container(
                        height: 50,
                        width: 350,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.green.shade200),
                            borderRadius: BorderRadius.circular(10)),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: DropdownButton_B(),
                        )),
                  ],
                ),
                const SizedBox(height: 20,),
                const Row(
                  children: [
                    Text("Choose Remainder",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.green),
                    )
                  ],
                ),
                const SizedBox(height: 5,),
                Container(
                  height: 50,
                  width: 350,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.green.shade200)
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Remainder",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black,fontSize: 18),),
                        Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: Icon(Icons.chevron_right,size: 30,color: Colors.green,),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                const Row(
                  children: [
                    Text("Choose Screen Size && Close Button",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.green),
                    )
                  ],
                ),
                const SizedBox(height: 5,),
                InkWell(
                  child: Container(
                    height: 50,
                    width: 350,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.green.shade200)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(App_Text.Screen_size,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.black,fontSize: 18),),
                          const Padding(
                            padding: EdgeInsets.only(right: 20),
                            child: Icon(Icons.chevron_right,size: 30,color: Colors.green,),
                          )
                        ],
                      ),
                    ),
                  ),
                  onTap: (){
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        isIos: true,
                        child: const Screensize_Page(),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  children: [
                    Text(
                      "Comments",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Container(
                      color: Colors.white,
                      child: SizedBox(
                        //height: 100,
                        width: 350,
                        child: TextField(
                          keyboardType: TextInputType.text,
                          autofocus: true,
                          controller: App_Text.comments,
                          cursorColor: Colors.green,
                          cursorHeight: 20,
                          style: const TextStyle(
                              height: 5,
                              color: Colors.black, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.green.shade200,
                                //width: 1.5,
                              ),
                            ),

                            //********Focus border like hover******************8
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Colors.green)),
                            //hintText: "Enter Sub-Task",
                            hintStyle:  TextStyle(color: Colors.green.shade200),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      child: Container(
                          height: 50,
                          width: 150,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Center(
                              child: Text(
                                "Cancel",
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              ))),
                      onTap: () async {
                        print("click");
                        dynamic result =
                            await Add_TaskPage.firestoredb?.collection("goal_getter").snapshots();
                            print("result");
                            print(result.runtimeType);
                            print("yes");
                        Stream<QuerySnapshot> ms = result;
                        setState((){

                          // App_Text.sub_title.clear();
                          // App_Text.task_title.clear();
                          // App_Text.comments.clear();
                          // App_Text.repeat_task = "None";
                            });

                        firebasedata = "";
                        ms.forEach((element) {
                          for (var value in element.docs) {
                            print(value.data());

                            //await element.docs.removeAt(index);
                            firebasedata = firebasedata + value.data().toString() + "\n";
                            print(value.get("title"));
                           // print(value.get("messagefrom"));
                          }
                        });
                        print(firebasedata);

                      },
                    ),
                    InkWell(
                      child: Container(
                          height: 50,
                          width: 150,
                          decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Center(
                              child: Text(
                                "Save",
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              ))),
                      onTap: () async{
                        // Navigator.push(
                        //   context,
                        //   PageTransition(
                        //     type: PageTransitionType.leftToRight,
                        //     isIos: true,
                        //     child:  Bottomnavigation(index: 0),
                        //   ),
                        // );
                        print("sending dta");
                        if(Add_TaskPage.firestoredb is  Null)
                          {
                            print("Got Null");

                          }
                        else {
                          await Add_TaskPage.firestoredb?.collection(
                              "goal_getter").add({
                            "title": App_Text.task_title.text,
                            "sub_title": App_Text.sub_title.text,
                            "category":App_Text.category,
                            "date":_selectedDate1.day.toInt(),
                            "month":_selectedDate1.month.toInt(),
                            "year":_selectedDate1.year.toInt(),
                            "time":_selectedTime.format(context).toString(),
                            "repeat":App_Text.repeat_task,
                            "comments":App_Text.comments.text,
                          });
                        }
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String dropdownValue = list_a.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Padding(
        padding: EdgeInsets.only(left: 180),
        child: Icon(
          Icons.arrow_drop_down,
          color: Colors.green,
          size: 30,
        ),
      ),
      elevation: 16,
      style: const TextStyle(
          color: Colors.green, fontSize: 20, fontWeight: FontWeight.bold),
      underline: Container(
        height: 0,
        color: Colors.white,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
          App_Text.category = dropdownValue;
          print(App_Text.category);
        });
      },
      items: list_a.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class DropdownButton_B extends StatefulWidget {
  const DropdownButton_B({super.key});

  @override
  State<DropdownButton_B> createState() => _DropdownButton_BState();
}

class _DropdownButton_BState extends State<DropdownButton_B> {
  String dropdownValue = list_b.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Padding(
        padding: EdgeInsets.only(left: 200),
        child: Icon(
          Icons.arrow_drop_down,
          color: Colors.green,
          size: 30,
        ),
      ),
      elevation: 16,
      style: const TextStyle(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      underline: Container(
        height: 0,
        color: Colors.white,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
          App_Text.repeat_task = dropdownValue;
          print(App_Text.repeat_task);
        });
      },
      items: list_b.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}