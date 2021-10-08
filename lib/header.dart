import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tn09_app_web_demo/pages/user_infor_page.dart';

Widget header({required BuildContext context}) {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  final uid = user!.uid;
  // print('User in Header: $user');
  String? displayName;
  if (user.displayName == null) {
    displayName = 'User Name';
  } else {
    displayName = user.displayName;
  }
  // print(('$displayName'));

  return Container(
      width: double.infinity,
      height: 80,
      color: Colors.green,
      child: GestureDetector(
        onTap: () {
          showDialog(
              barrierColor: null,
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                    alignment: Alignment(1.1, -0.85),
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => UserInforPage()));
                            },
                            child: Container(
                                color: Colors.red,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'User Infor',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                )),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Divider(
                            thickness: 3,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                                color: Colors.red,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      FontAwesomeIcons.signOutAlt,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text('Log Out'),
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ));
              });
        },
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
            margin: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
            child: Image.asset('images/logo_homescreen.png'),
          ),
          Container(
              margin: const EdgeInsets.only(right: 10, top: 20, bottom: 20),
              child: GestureDetector(
                child: Row(
                  children: [
                    Image.asset('images/logo_user.png'),
                    SizedBox(width: 10),
                    Text(
                      displayName!,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              )),
        ]),
      ));
}
