// ignore_for_file: prefer_const_constructors, avoid_print, use_build_context_synchronously, avoid_single_cascade_in_expression_statements, unrelated_type_equality_checks, unnecessary_new, unused_element

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'componant/Widgets.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'componant/testt.dart';

class sentiMachine extends StatefulWidget {
  @override
  State<sentiMachine> createState() => _sentiMachine();
}

TextEditingController emailtx = TextEditingController();
TextEditingController input1 = TextEditingController();
GlobalKey<FormState> formstate = GlobalKey();

// ignore: prefer_typing_uninitialized_variables
var res;
Future<void> postData(text) async {
  final url = Uri.parse('http://10.0.2.2:5000/sentimentMachine');
  final body = {'text': text};
  try {
    final response = await post(url, body: body);
    res = json.decode(response.body);
    print(res);
    if (response.statusCode == 200) {
      print('Data posted successfully');
    }
  } catch (error) {
    print('An error occurred: $error');
  }
}

class _sentiMachine extends State<sentiMachine> {
  void _refreshData() {
    // Update the data source with new data

    // Call the function to refresh data again after 5 seconds
    Future.delayed(Duration(seconds: 1), _refreshData);
  }

  @override
  Widget build(BuildContext context) {
    return res != null
        ? Scaffold(
            backgroundColor: Color.fromARGB(255, 28, 7, 40),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 1),
                duration: Duration(seconds: 1),
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Padding(
                      padding: EdgeInsets.only(top: value * 15),
                      child: child,
                    ),
                  );
                },
                child: Form(
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    key: formstate,
                    physics: BouncingScrollPhysics(),
                    children: [
                      SizedBox(
                        height: 197,
                      ),
                      Text(
                        'Hello Dear',
                        style: TextStyle(
                            color: Color.fromARGB(200, 255, 255, 255),
                            fontSize: 32,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 99,
                      ),
                      Text(
                        'Please Write your phrase',
                        style: TextStyle(
                            color: kSecondaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 99,
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: TextFormField(
                            validator: (text) {
                              if (text?.length == "") {
                                return " the field is empty";
                              }
                              return null;
                            },
                            cursorColor: Colors.white,
                            style: TextStyle(color: Colors.white),
                            controller: input1,
                            decoration: InputDecoration(
                              hintText: 'Write here',
                              hintStyle: TextStyle(
                                color: Color.fromARGB(200, 255, 255, 255),
                              ),
                              focusedErrorBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(122, 255, 255, 255),
                                      width: 3)),
                            ),
                          )),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 35,
                      ),
                      GestureDetector(
                          onTap: () async {
                            await postData(input1.text);
                            print(res["output"]);
                            setState(() {});
                            print(res['output']);
                            if (res == null) {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.scale,
                                title: 'Error',
                                body: Column(
                                  children: [
                                    Text(
                                      "you are feeling a positive integer you are so cute",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20),
                                    ),
                                  ],
                                ),
                                descTextStyle: TextStyle(
                                  fontSize: 17,
                                ),
                                btnCancelOnPress: () {},
                                btnOkOnPress: () {},
                              );
                            } else if (res != null && res['output'] == 1) {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.success,
                                animType: AnimType.scale,
                                title: 'Info',
                                body: Column(
                                  children: [
                                    Text(
                                      "you are feeling a positive Vibe",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text("Output : ${res["output"]}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold))
                                  ],
                                ),
                                descTextStyle: TextStyle(
                                  fontSize: 17,
                                ),
                                btnOkOnPress: () {},
                              )..show();
                            } else if (res != null && res['output'] == 0) {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.scale,
                                title: 'Info',
                                body: Column(
                                  children: [
                                    Text(
                                      "you are feeling a Negative Vibe",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text("Output : ${res["output"]}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold))
                                  ],
                                ),
                                descTextStyle: TextStyle(
                                  fontSize: 17,
                                ),
                                btnOkOnPress: () {},
                              )..show();
                            } else {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.info,
                                animType: AnimType.scale,
                                title: 'Info',
                                body: Column(
                                  children: [
                                    Text(
                                      "you are feeling a Neutral Vibe",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text("Output  Not 0 , Not 1}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold))
                                  ],
                                ),
                                descTextStyle: TextStyle(
                                  fontSize: 17,
                                ),
                                btnOkOnPress: () {},
                              )..show();
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: MediaQuery.of(context).size.height * 0.08,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: kPrimaryColor),
                            child: Text(
                              "Show what you are feeling ",
                              style: TextStyle(
                                color: kWhiteColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          )
        : Scaffold(
            backgroundColor: Color.fromARGB(255, 28, 7, 40),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 1),
                duration: Duration(seconds: 1),
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Padding(
                      padding: EdgeInsets.only(top: value * 15),
                      child: child,
                    ),
                  );
                },
                child: Form(
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    key: formstate,
                    physics: BouncingScrollPhysics(),
                    children: [
                      SizedBox(
                        height: 197,
                      ),
                      Text(
                        'Hello Dear',
                        style: TextStyle(
                            color: Color.fromARGB(200, 255, 255, 255),
                            fontSize: 32,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Please Write your phrase',
                        style: TextStyle(
                            color: kSecondaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 99,
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: TextFormField(
                            validator: (text) {
                              if (text?.length == "") {
                                return " the field is empty";
                              }
                              return null;
                            },
                            cursorColor: Colors.white,
                            style: TextStyle(color: Colors.white),
                            controller: input1,
                            decoration: InputDecoration(
                              hintText: 'Write here',
                              hintStyle: TextStyle(
                                color: Color.fromARGB(200, 255, 255, 255),
                              ),
                              focusedErrorBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(122, 255, 255, 255),
                                      width: 3)),
                            ),
                          )),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 30,
                      ),
                      GestureDetector(
                          onTap: () async {
                            await postData(input1.text);
                            setState(() {});

                            if (res == null) {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.scale,
                                title: 'Error',
                                body: Text(
                                  "you are feeling a positive integer you are so cute",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                                descTextStyle: TextStyle(
                                  fontSize: 17,
                                ),
                                btnCancelOnPress: () {},
                                btnOkOnPress: () {},
                              );
                            } else if (res != null && res['output'] == 1) {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.success,
                                animType: AnimType.scale,
                                title: 'Info',
                                body: Column(
                                  children: [
                                    Text(
                                      "you are feeling a positive Vibe",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text("Output : ${res["output"]}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold))
                                  ],
                                ),
                                descTextStyle: TextStyle(
                                  fontSize: 17,
                                ),
                                btnOkOnPress: () {},
                              )..show();
                            } else if (res != null && res['output'] == 0) {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.scale,
                                title: 'Info',
                                body: Column(
                                  children: [
                                    Text(
                                      "you are feeling a Negative Vibe",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text("Output : ${res["output"]}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold))
                                  ],
                                ),
                                descTextStyle: TextStyle(
                                  fontSize: 17,
                                ),
                                btnOkOnPress: () {},
                              )..show();
                            } else {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.info,
                                animType: AnimType.scale,
                                title: 'Info',
                                body: Column(
                                  children: [
                                    Text(
                                      "you are feeling a Neutral Vibe",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text("Output  Not 0 , Not 1}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold))
                                  ],
                                ),
                                descTextStyle: TextStyle(
                                  fontSize: 17,
                                ),
                                btnOkOnPress: () {},
                              )..show();
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: MediaQuery.of(context).size.height * 0.08,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: kPrimaryColor),
                            child: Text(
                              "Show what you are feeling ",
                              style: TextStyle(
                                color: kWhiteColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          )),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 3,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 30,
                        width: MediaQuery.of(context).size.height / 30,
                        color: Color.fromARGB(255, 28, 7, 40),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
