import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tn09_app_web_demo/header.dart';
import 'package:tn09_app_web_demo/home_screen.dart';
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
        SizedBox(height: 20),
        Row(
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
                          Icons.people,
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
              height: 400,
              color: Colors.green,
            ),
          ],
        )
      ],
    )));
  }
}
