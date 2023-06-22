// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ml/Nlp.dart';
import 'package:flutter_ml/componant/testt.dart';
import 'package:flutter_ml/neuralNetwork.dart';
import 'package:flutter_ml/switch.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

//https://intel-classfier-production.up.railway.app/predictApi
class MlModel extends StatefulWidget {
  @override
  State<MlModel> createState() => _MlModel();
}

class _MlModel extends State<MlModel> {
  bool _visability = true;
  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(milliseconds: 400), (timer) {
      setState(() {
        _visability = !_visability;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(255, 20, 5, 29),
                      Color.fromARGB(255, 28, 7, 37),
                      Color.fromARGB(255, 28, 7, 40),
                      Color.fromARGB(255, 28, 7, 50),
                      Color.fromARGB(255, 28, 7, 55),
                      Color.fromARGB(255, 28, 7, 60),
                      Color.fromARGB(255, 28, 7, 65),
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 29,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.height / 20,
                        height: MediaQuery.of(context).size.width / 15,
                        child: Text(
                          "Welcome To Our",
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 20,
                                  spreadRadius: 20,
                                )
                              ]),
                        ),
                      ),
                      Container(
                        width: 20,
                        height: 30,
                        child: Text(
                          "AI World",
                          maxLines: 2,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 20,
                                  spreadRadius: 20,
                                )
                              ]),
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      SingleChildScrollView(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  Get.to(Switchh());
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 10),
                                height:
                                    MediaQuery.of(context).size.height / 2.5,
                                width: MediaQuery.of(context).size.width / 2.3,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black,
                                          spreadRadius: 2,
                                          blurRadius: 22)
                                    ],
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage("assets/aa.png"))),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Color.fromARGB(
                                                  150, 53, 1, 58)),
                                          child: Text(
                                            "NATURAL LANGUAGE PROCESSING",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold),
                                          )),
                                    ]),
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              height: MediaQuery.of(context).size.height / 2.5,
                              width: MediaQuery.of(context).size.width / 2.3,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black,
                                        spreadRadius: 2,
                                        blurRadius: 22)
                                  ],
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage("assets/machine.png"))),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color:
                                                Color.fromARGB(150, 53, 1, 58)),
                                        child: Text(
                                          "MACHINE LEARNING",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold),
                                        ))
                                  ]),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(NeuralNetwork());
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 10),
                              height: MediaQuery.of(context).size.height / 2.5,
                              width: MediaQuery.of(context).size.width / 2.3,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black,
                                        spreadRadius: 2,
                                        blurRadius: 22)
                                  ],
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage("assets/Neural.png"))),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color:
                                                Color.fromARGB(150, 53, 1, 58)),
                                        child: Text(
                                          "NEURAL NETWORK",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold),
                                        ))
                                  ]),
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            height: MediaQuery.of(context).size.height / 2.5,
                            width: MediaQuery.of(context).size.width / 2.3,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black,
                                      spreadRadius: 2,
                                      blurRadius: 22)
                                ],
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage("assets/speech.png"))),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color:
                                              Color.fromARGB(150, 53, 1, 58)),
                                      child: Text(
                                        "SPEECH PROCESSING",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                      ))
                                ]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
