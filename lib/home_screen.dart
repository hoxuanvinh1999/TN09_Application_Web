// ignore_for_file: invalid_return_type_for_catch_error, avoid_function_literals_in_foreach_calls, avoid_print, non_constant_identifier_names, prefer_const_declarations, unnecessary_new

import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tn09_app_web_demo/menu/header.dart';
import 'package:tn09_app_web_demo/menu/menu.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:tn09_app_web_demo/decoration/graphique.dart' as graphique;
import 'package:tn09_app_web_demo/pages/math_function/get_date_text.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  //For Send mail
  CollectionReference _mail = FirebaseFirestore.instance.collection("mail");
  // Testing Photo
  //load Signature
  String _signatureUrl = '';
  void loadData() async {
    final signature_ref =
        FirebaseStorage.instance.ref().child('29_11_2021/image/testing.png');
    var signature_url = await signature_ref.getDownloadURL();
    setState(() {
      _signatureUrl = signature_url;
    });
  }

  File _file = File("zz");
  Uint8List webImage = Uint8List(10);
  Future<PermissionStatus> requestPermissions() async {
    await Permission.photos.request();
    return Permission.photos.status;
  }

  File createFileFromBytes(Uint8List bytes) => File.fromRawPath(bytes);
  uploadImage() async {
    var permissionStatus = requestPermissions();

    // MOBILE
    if (!kIsWeb && await permissionStatus.isGranted) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        var selected = File(image.path);

        setState(() {
          _file = selected;
        });
      } else {
        Fluttertoast.showToast(
            msg: "No file selected", gravity: ToastGravity.TOP);
      }
    }
    // WEB
    else if (kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var f = await image.readAsBytes();
        setState(() {
          //_file = File("a");
          _file = File(image.path);
          webImage = f;
        });
      } else {
        Fluttertoast.showToast(
            msg: "No file selected", gravity: ToastGravity.TOP);
      }
    } else {
      Fluttertoast.showToast(
          msg: "Permission not granted", gravity: ToastGravity.TOP);
    }
  }

  @override
  Widget build(BuildContext context) {
    loadData();
    // print('$_signatureUrl');
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            header(context: context),
            menu(context: context),
            Container(
                decoration: BoxDecoration(
                  color: Color(graphique.color['default_yellow']),
                  border: Border(
                    bottom: BorderSide(
                        width: 1.0,
                        color: Color(graphique.color['default_black'])),
                  ),
                ),
                width: MediaQuery.of(context).size.width,
                height: 40,
                child: Row(
                  children: [
                    SizedBox(
                      width: 40,
                    ),
                    Icon(
                      FontAwesomeIcons.home,
                      size: 12,
                      color: Color(graphique.color['default_black']),
                    ),
                    SizedBox(width: 5),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Home',
                              style: TextStyle(
                                  color: Color(graphique.color['default_red']),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) => HomeScreen()));
                                }),
                        ],
                      ),
                    ),
                  ],
                )),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              alignment: Alignment.centerLeft,
              width: MediaQuery.of(context).size.width * 0.9,
              height: 1000,
              color: Color(graphique.color['special_bureautique_2']),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  (_file.path == "zz")
                      ? Image.asset('images/app_logo.png')
                      : (kIsWeb)
                          ? Image.memory(webImage)
                          : Image.asset('images/app_logo.png'),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await uploadImage();
                      String fileName = getDateText(date: DateTime.now())
                              .replaceAll('/', '_') +
                          '/' +
                          'image/' +
                          'testing.png';
                      String fileName_late = getDateText(date: DateTime.now())
                              .replaceAll('/', '_') +
                          '/' +
                          'image/' +
                          'testing_late.png';
                      String fileName_new = getDateText(date: DateTime.now())
                              .replaceAll('/', '_') +
                          '/' +
                          'image/' +
                          'testing_new.png';
                      await FirebaseStorage.instance.ref(fileName_new).putData(
                            webImage,
                            SettableMetadata(
                              contentType: 'image/jpeg',
                              customMetadata: {
                                'date': getDateText(date: DateTime.now()),
                                'why?': 'Tesing',
                              },
                            ),
                          );
                      http.Response response = await http.get(
                        Uri.parse(_signatureUrl.toString()),
                      );
                      Uint8List bytes = response.bodyBytes;
                      await FirebaseStorage.instance.ref(fileName_late).putData(
                            bytes,
                            SettableMetadata(
                                contentType: 'image/jpeg',
                                customMetadata: {
                                  'date': getDateText(date: DateTime.now()),
                                  'why?': 'Tesing',
                                }),
                          );
                    },
                    child: Text("Upload"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _file = File("zz");
                        webImage = Uint8List(10);
                      });
                    },
                    child: Text("Delete"),
                  ),
                  Container(
                    height: 500,
                    width: MediaQuery.of(context).size.width * 0.95,
                    color: Colors.white,
                    child: _signatureUrl == ''
                        ? Image.asset('images/app_logo.png')
                        : Image.network(
                            _signatureUrl,
                            // fit: BoxFit.cover
                          ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 100, left: 80),
                      width: 150,
                      height: 50,
                      color: Colors.yellow,
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () async {
                          // add element to partenaire
                          // await FirebaseFirestore.instance
                          //     .collection("Partenaire")
                          //     .get()
                          //     .then((QuerySnapshot querySnapshot) {
                          //   querySnapshot.docs.forEach((partenaire) {
                          //     FirebaseFirestore.instance
                          //         .collection('Partenaire')
                          //         .doc(partenaire.id)
                          //         .update({
                          //       'idTypePartenaire': '',
                          //     }).then((value) {
                          //       Fluttertoast.showToast(
                          //           msg: 'Added Element idTypePartenaire',
                          //           gravity: ToastGravity.TOP);
                          //     }).catchError((error) =>
                          //             print("Failed to add user: $error"));
                          //   });
                          // }).then((value) {
                          //   Fluttertoast.showToast(
                          //       msg: 'Finish update data',
                          //       gravity: ToastGravity.TOP);
                          // }).catchError((error) =>
                          //         print("Failed to add user: $error"));
                          // await FirebaseFirestore.instance
                          //     .collection("Partenaire")
                          //     .get()
                          //     .then((QuerySnapshot querySnapshot) {
                          //   querySnapshot.docs.forEach((partenaire) {
                          //     FirebaseFirestore.instance
                          //         .collection('TypePartenaire')
                          //         .where('nomTypePartenaire',
                          //             isEqualTo: partenaire['typePartenaire'])
                          //         .limit(1)
                          //         .get()
                          //         .then((QuerySnapshot querySnapshot) async {
                          //       querySnapshot.docs.forEach((typepartenaire) {
                          //         FirebaseFirestore.instance
                          //             .collection('Partenaire')
                          //             .doc(partenaire.id)
                          //             .update({
                          //           'idTypePartenaire':
                          //               typepartenaire['idTypePartenaire'],
                          //         });
                          //       });
                          //     });
                          //   });
                          // }).then((value) {
                          //   Fluttertoast.showToast(
                          //       msg: 'Finish update data',
                          //       gravity: ToastGravity.TOP);
                          // }).catchError((error) =>
                          //         print("Failed to add user: $error"));
                          //Test send email
                          // await _mail.doc(_mail.doc().id.toString()).set({
                          //   'to': 'hoxuanvinh1999@gmail.com',
                          //   'message': {
                          //     'subject': "Hello from Les detritivores!",
                          //     'text': 'Testing',
                          //   },
                          // });
                          //Creating new function send email
                          // final email_body = 'Hello Vinh is testing functions';
                          // final Email email = Email(
                          //   body: email_body,
                          //   subject: 'Testing Function',
                          //   recipients: ['hoxuanvinh1999@gmail.com'],
                          //   //cc: ['cc@example.com'],
                          //   //bcc: ['bcc@example.com'],
                          //   //attachmentPaths: ['/path/to/attachment.zip'],
                          //   isHTML: false,
                          // );

                          // await FlutterEmailSender.send(email);
                          // final mailtoLink = Mailto(
                          //   to: ['hoxuanvinh1999@gmail.com'],
                          //   //cc: ['cc1@example.com', 'cc2@example.com'],
                          //   subject: 'Example subject',
                          //   body: 'Testing',
                          // );
                          // // Convert the Mailto instance into a string.
                          // // Use either Dart's string interpolation
                          // // or the toString() method.
                          // await launch('$mailtoLink');
                          //delete test result in 10/11/2021 and 17/11/2021
                          // await FirebaseFirestore.instance
                          //     .collection("Tournee")
                          //     .where('dateTournee',
                          //         whereIn: ['10/11/2021', '17/11/2021'])
                          //     .get()
                          //     .then((QuerySnapshot querySnapshot) {
                          //       querySnapshot.docs.forEach((tournee) {
                          //         FirebaseFirestore.instance
                          //             .collection('Tournee')
                          //             .doc(tournee.id)
                          //             .delete()
                          //             .then((value) {
                          //           Fluttertoast.showToast(
                          //               msg: 'Delete Tournee',
                          //               gravity: ToastGravity.TOP);
                          //         }).catchError((error) =>
                          //                 print("Failed to add user: $error"));
                          //       });
                          //     })
                          //     .then((value) {
                          //       Fluttertoast.showToast(
                          //           msg: 'Finish clean data',
                          //           gravity: ToastGravity.TOP);
                          //     })
                          //     .catchError((error) =>
                          //         print("Failed to add user: $error"));
                          // await FirebaseFirestore.instance
                          //     .collection("Etape")
                          //     .where('jourEtape',
                          //         whereIn: ['10/11/2021', '17/11/2021'])
                          //     .get()
                          //     .then((QuerySnapshot querySnapshot) {
                          //       querySnapshot.docs.forEach((etape) {
                          //         FirebaseFirestore.instance
                          //             .collection('Etape')
                          //             .doc(etape.id)
                          //             .delete()
                          //             .then((value) {
                          //           Fluttertoast.showToast(
                          //               msg: 'Delete Etape',
                          //               gravity: ToastGravity.TOP);
                          //         }).catchError((error) =>
                          //                 print("Failed to add user: $error"));
                          //       });
                          //     })
                          //     .then((value) {
                          //       Fluttertoast.showToast(
                          //           msg: 'Finish clean data',
                          //           gravity: ToastGravity.TOP);
                          //     })
                          //     .catchError((error) =>
                          //         print("Failed to add user: $error"));
                        },
                        child: Row(
                          children: [
                            Text(
                              'Function Button',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
