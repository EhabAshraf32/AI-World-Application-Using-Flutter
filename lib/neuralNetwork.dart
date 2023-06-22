import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ml/componant/constants.dart';
import 'package:flutter_ml/componant/custom_outline.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

//https://intel-classfier-production.up.railway.app/predictApi
class NeuralNetwork extends StatefulWidget {
  @override
  State<NeuralNetwork> createState() => _NeuralNetwork();
}

String txt = '';
var res;
Future<void> upload(File imageFile, String option) async {
  final url = Uri.parse('http://10.0.2.2:5000/neural-classification');

  // create multipart request
  var request = http.MultipartRequest('POST', url);

  // add file to request
  var stream = http.ByteStream(imageFile.openRead());
  var length = await imageFile.length();
  var multipartFile =
      http.MultipartFile('img', stream, length, filename: imageFile.path);
  request.files.add(multipartFile);

  // add other fields to request
  request.fields['option'] = option;

  try {
    // send request
    var response = await request.send();
    // read response
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    res = json.decode(responseString);
    print(res);

    // handle response
    if (response.statusCode == 200) {
      print('Data posted successfully');
    }
  } catch (error) {
    print('An error occurred: $error');
  }
}

class _NeuralNetwork extends State<NeuralNetwork> {
  final picker = ImagePicker();
  File? img;
  //var url = "http://127.0.0.1:5000/neural-classification";
  Future pickImage() async {
    PickedFile? pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );
    setState(() {
      img = File(pickedFile!.path);
    });
  }

  // Future<void> upload(img, option) async {
  //   final url = Uri.parse('http://127.0.0.1:5000/neural-classification');
  //   final body = {'img': img, 'option': option};
  //   try {
  //     final response = await post(url, body: body);
  //     res = json.decode(response.body);
  //     print(res);
  //     if (response.statusCode == 200) {
  //       print('Data posted successfully');
  //     }
  //   } catch (error) {
  //     print('An error occurred: $error');
  //   }
  // }

  //upload() async {
  // final request = http.MultipartRequest("POST", Uri.parse(url));
  // final header = {"Content_type": "multipart/form-data"};
  // request.files.add(http.MultipartFile(
  //     'fileup', img!.readAsBytes().asStream(), img!.lengthSync(),
  //     filename: img!.path.split('/').last));
  // request.headers.addAll(header);
  // final myRequest = await request.send();
  // http.Response res = await http.Response.fromStream(myRequest);
  // if (myRequest.statusCode == 200) {
  //   final resJson = jsonDecode(res.body);
  //   print("response here: $resJson");
  //   result = resJson['output'];
  // } else {
  //   print("Error ${myRequest.statusCode}");
  // }

  // setState(() {});
  //}

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return res == null
        ? Scaffold(
            backgroundColor: Constants.kBlackColor,
            extendBody: true,
            appBar: AppBar(
              backgroundColor: Constants.kPinkColor,
              title: Text(
                'VisionAI',
                style: TextStyle(fontSize: 27),
              ),
              centerTitle: true,
            ),
            body: SizedBox(
              height: screenHeight,
              width: screenWidth,
              child: Stack(children: [
                Positioned(
                  top: screenHeight * 0.1,
                  left: -88,
                  child: Container(
                    height: 166,
                    width: 166,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Constants.kPinkColor),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 200,
                        sigmaY: 200,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: screenHeight * 0.3,
                  right: -100,
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Constants.kGreenColor,
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 200,
                        sigmaY: 200,
                      ),
                      child: Container(
                        height: 200,
                        width: 200,
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
                SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: screenHeight * 0.05,
                      ),
                      CustomOutline(
                        strokeWidth: 4,
                        radius: screenWidth * 0.8,
                        padding: const EdgeInsets.all(4),
                        width: screenWidth * 0.8,
                        height: screenWidth * 0.8,
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Constants.kPinkColor,
                              Constants.kPinkColor.withOpacity(0),
                              Constants.kGreenColor.withOpacity(0.1),
                              Constants.kGreenColor
                            ],
                            stops: const [
                              0.2,
                              0.4,
                              0.6,
                              1
                            ]),
                        child: Center(
                          child: img == null
                              ? Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      alignment: Alignment.bottomLeft,
                                      image: AssetImage(
                                          'assets/img-onboarding.png'),
                                    ),
                                  ),
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      alignment: Alignment.bottomLeft,
                                      image: FileImage(img!),
                                    ),
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.05,
                      ),
                      Center(
                          child: res == null
                              ? Text(
                                  txt = 'no predicted yet',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Constants.kWhiteColor.withOpacity(
                                      0.85,
                                    ),
                                    fontSize: screenHeight <= 667 ? 18 : 34,
                                    fontWeight: FontWeight.w700,
                                  ),
                                )
                              : Text(
                                  'Result from Model NN: ${res['output']}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Constants.kWhiteColor.withOpacity(
                                      0.85,
                                    ),
                                    fontSize: screenHeight <= 667 ? 18 : 34,
                                    fontWeight: FontWeight.w700,
                                  ),
                                )),
                      SizedBox(
                        height: screenHeight * 0.03,
                      ),
                      CustomOutline(
                        strokeWidth: 3,
                        radius: 20,
                        padding: const EdgeInsets.all(3),
                        width: 160,
                        height: 38,
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Constants.kPinkColor, Constants.kGreenColor],
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Constants.kPinkColor.withOpacity(0.5),
                                Constants.kGreenColor.withOpacity(0.5)
                              ],
                            ),
                          ),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Colors.white12,
                              ),
                            ),
                            onPressed: () {
                              pickImage();
                            },
                            child: Text('Pick Image Here',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Constants.kWhiteColor,
                                )),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomOutline(
                        strokeWidth: 3,
                        radius: 20,
                        padding: const EdgeInsets.all(3),
                        width: 160,
                        height: 38,
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Constants.kPinkColor, Constants.kGreenColor],
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Constants.kPinkColor.withOpacity(0.5),
                                Constants.kGreenColor.withOpacity(0.5)
                              ],
                            ),
                          ),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Colors.white12,
                              ),
                            ),
                            onPressed: () async {
                              await upload(img!, 'A');
                              res == null
                                  ? Text("no data")
                                  : print(res["output"]);
                              setState(() {
                                res == null
                                    ? txt = 'predicted model is '
                                    : txt =
                                        'predicted model is ${res['output']}';
                              });
                            },
                            child: Text('Upload Image',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Constants.kWhiteColor,
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          )
        : Scaffold(
            backgroundColor: Constants.kBlackColor,
            extendBody: true,
            appBar: AppBar(
              backgroundColor: Constants.kPinkColor,
              title: Text(
                'VisionAI',
                style: TextStyle(fontSize: 27),
              ),
              centerTitle: true,
            ),
            body: SizedBox(
              height: screenHeight,
              width: screenWidth,
              child: Stack(children: [
                Positioned(
                  top: screenHeight * 0.1,
                  left: -88,
                  child: Container(
                    height: 166,
                    width: 166,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Constants.kPinkColor),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 200,
                        sigmaY: 200,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: screenHeight * 0.3,
                  right: -100,
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Constants.kGreenColor,
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 200,
                        sigmaY: 200,
                      ),
                      child: Container(
                        height: 200,
                        width: 200,
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
                SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: screenHeight * 0.05,
                      ),
                      CustomOutline(
                        strokeWidth: 4,
                        radius: screenWidth * 0.8,
                        padding: const EdgeInsets.all(4),
                        width: screenWidth * 0.8,
                        height: screenWidth * 0.8,
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Constants.kPinkColor,
                              Constants.kPinkColor.withOpacity(0),
                              Constants.kGreenColor.withOpacity(0.1),
                              Constants.kGreenColor
                            ],
                            stops: const [
                              0.2,
                              0.4,
                              0.6,
                              1
                            ]),
                        child: Center(
                          child: img == null
                              ? Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      alignment: Alignment.bottomLeft,
                                      image: AssetImage(
                                          'assets/img-onboarding.png'),
                                    ),
                                  ),
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      alignment: Alignment.bottomLeft,
                                      image: FileImage(img!),
                                    ),
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.05,
                      ),
                      Center(
                          child: res == null
                              ? Text(
                                  '${txt = 'THE MODEL HAS NOT BEEN PREDICTED'}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Constants.kWhiteColor.withOpacity(
                                      0.85,
                                    ),
                                    fontSize: screenHeight <= 667 ? 18 : 34,
                                    fontWeight: FontWeight.w700,
                                  ),
                                )
                              : Text(
                                  'Result from Model NN: ${res['output']}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Constants.kWhiteColor.withOpacity(
                                      0.85,
                                    ),
                                    fontSize: screenHeight <= 667 ? 18 : 34,
                                    fontWeight: FontWeight.w700,
                                  ),
                                )),
                      SizedBox(
                        height: screenHeight * 0.03,
                      ),
                      CustomOutline(
                        strokeWidth: 3,
                        radius: 20,
                        padding: const EdgeInsets.all(3),
                        width: 160,
                        height: 38,
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Constants.kPinkColor, Constants.kGreenColor],
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Constants.kPinkColor.withOpacity(0.5),
                                Constants.kGreenColor.withOpacity(0.5)
                              ],
                            ),
                          ),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Colors.white12,
                              ),
                            ),
                            onPressed: () {
                              pickImage();
                            },
                            child: Text('Pick Image Here',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Constants.kWhiteColor,
                                )),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomOutline(
                        strokeWidth: 3,
                        radius: 20,
                        padding: const EdgeInsets.all(3),
                        width: 160,
                        height: 38,
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Constants.kPinkColor, Constants.kGreenColor],
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Constants.kPinkColor.withOpacity(0.5),
                                Constants.kGreenColor.withOpacity(0.5)
                              ],
                            ),
                          ),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Colors.white12,
                              ),
                            ),
                            onPressed: () async {
                              await upload(img!, 'A');

                              res == null
                                  ? Text(" data not found")
                                  : print(res['output']);
                              setState(() {
                                txt = 'Result from model is ${res['output']}';
                              });
                            },
                            child: Text('Upload Image',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Constants.kWhiteColor,
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          );
  }
}
