import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tn09_app_web_demo/header.dart';
import 'package:tn09_app_web_demo/home_screen.dart';
import 'package:tn09_app_web_demo/login_page/login_page.dart';
import 'package:tn09_app_web_demo/menu/menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserInforPage extends StatefulWidget {
  @override
  _UserInforPageState createState() => _UserInforPageState();
}

class _UserInforPageState extends State<UserInforPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final _changeUserDisplayKeyForm = GlobalKey<FormState>();
  final _changePasswordKeyForm = GlobalKey<FormState>();
  TextEditingController _displaynameController = TextEditingController();
  TextEditingController _currentPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _checknewPasswordController = TextEditingController();
  String check = '';

  void inputData() {
    final User? user = auth.currentUser;
    final uid = user?.uid;
    if (user?.displayName != null) {
      check = user!.displayName!;
      _displaynameController.text = user.displayName!;
    } else {
      check = 'no name';
    }
  }

  @override
  Widget build(BuildContext context) {
    inputData();
    print('$check');
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      children: [
        header(context: context),
        menu(context: context),
        Container(
            color: Colors.yellow,
            width: double.infinity,
            height: 40,
            child: Row(
              children: [
                SizedBox(
                  width: 40,
                ),
                Icon(
                  FontAwesomeIcons.home,
                  size: 12,
                ),
                SizedBox(width: 5),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Home',
                          style: TextStyle(
                              color: Colors.red,
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
                SizedBox(
                  width: 10,
                ),
                Icon(
                  FontAwesomeIcons.chevronCircleRight,
                  size: 12,
                ),
                SizedBox(
                  width: 10,
                ),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: 'User Infor',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            )),
        SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 20),
              width: 600,
              height: 400,
              color: Colors.green,
              child: Column(
                children: [
                  Container(
                    height: 50,
                    color: Colors.blue,
                    child: Row(
                      children: [
                        SizedBox(width: 20),
                        Icon(
                          FontAwesomeIcons.user,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Change User Name',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  const Divider(
                    thickness: 5,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      color: Colors.yellow,
                      height: 100,
                      width: 400,
                      child: Form(
                          key: _changeUserDisplayKeyForm,
                          child: Column(
                            children: [
                              Container(
                                width: 300,
                                color: Colors.red,
                                child: TextFormField(
                                  controller: _displaynameController,
                                  decoration: InputDecoration(
                                    labelText: 'User Name:',
                                  ),
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value == '' ||
                                        value.length > 15) {
                                      return 'This can not be null or too long';
                                    }
                                  },
                                ),
                              ),
                            ],
                          ))),
                  Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(10)),
                      margin:
                          const EdgeInsets.only(right: 10, top: 20, bottom: 20),
                      child: GestureDetector(
                        onTap: () async {
                          if (_changeUserDisplayKeyForm.currentState!
                              .validate()) {
                            final User? currentuser = auth.currentUser;
                            await currentuser!
                                .updateDisplayName(_displaynameController.text);
                            Fluttertoast.showToast(
                                msg: "Changed User name",
                                gravity: ToastGravity.TOP);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserInforPage()),
                            ).then((value) => setState(() {}));
                            // Will not have effect setState(() {});
                          }
                        },
                        child: Text(
                          'Change',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )),
                ],
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              width: 600,
              height: 600,
              color: Colors.green,
              child: Column(
                children: [
                  Container(
                    height: 50,
                    color: Colors.blue,
                    child: Row(
                      children: [
                        SizedBox(width: 20),
                        Icon(
                          FontAwesomeIcons.key,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Change Password',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  const Divider(
                    thickness: 5,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      color: Colors.yellow,
                      height: 300,
                      width: 400,
                      child: Form(
                          key: _changePasswordKeyForm,
                          child: Column(
                            children: [
                              Container(
                                width: 300,
                                color: Colors.red,
                                child: TextFormField(
                                  obscureText: true,
                                  controller: _currentPasswordController,
                                  decoration: InputDecoration(
                                    labelText: 'Current Password:',
                                  ),
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value == '') {
                                      return 'This can not be null';
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Divider(
                                thickness: 3,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: 300,
                                color: Colors.red,
                                child: TextFormField(
                                  obscureText: true,
                                  controller: _newPasswordController,
                                  decoration: InputDecoration(
                                    labelText: 'New Password:',
                                  ),
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value == '') {
                                      return 'This can not be null';
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: 300,
                                color: Colors.red,
                                child: TextFormField(
                                  obscureText: true,
                                  controller: _checknewPasswordController,
                                  decoration: InputDecoration(
                                    labelText: 'Confirm Password:',
                                  ),
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value == '') {
                                      return 'This can not be null';
                                    } else if (_checknewPasswordController
                                            .text !=
                                        _newPasswordController.text) {
                                      return 'Does not match the new password';
                                    }
                                  },
                                ),
                              ),
                            ],
                          ))),
                  Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(10)),
                      margin:
                          const EdgeInsets.only(right: 10, top: 20, bottom: 20),
                      child: GestureDetector(
                        onTap: () async {
                          if (_changePasswordKeyForm.currentState!.validate()) {
                            final User? currentuser = auth.currentUser;
                            changePassword(
                                currentPassword:
                                    _currentPasswordController.text,
                                newPassword: _newPasswordController.text);
                          }
                        },
                        child: Text(
                          'Change',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ],
        )
      ],
    )));
  }

  void changePassword(
      {required String currentPassword, required newPassword}) async {
    User? currentuser = auth.currentUser;
    String email = currentuser!.email!;

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: currentPassword,
      );

      currentuser.updatePassword(newPassword).then((_) async {
        Fluttertoast.showToast(
            msg: 'Successfully changed password', gravity: ToastGravity.TOP);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserInforPage()),
        ).then((value) => setState(() {}));
        // await FirebaseAuth.instance.signOut();
        // Navigator.of(context).pushReplacement(
        //     MaterialPageRoute(builder: (context) => LoginPage()));
      }).catchError((error) {
        Fluttertoast.showToast(
            msg: "Password can't be changed" + ': ' + error.toString(),
            gravity: ToastGravity.TOP);
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(
            msg: 'No user found for that email', gravity: ToastGravity.TOP);
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(
            msg: 'Wrong password provided for that user',
            gravity: ToastGravity.TOP);
      }
    }
  }
}
