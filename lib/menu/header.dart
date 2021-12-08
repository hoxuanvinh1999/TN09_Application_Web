import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tn09_app_web_demo/login_page/login_page.dart';
import 'package:tn09_app_web_demo/pages/user_infor_page.dart';
import 'package:tn09_app_web_demo/decoration/graphique.dart' as graphique;

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
    width: MediaQuery.of(context).size.width,
    height: 80,
    decoration: BoxDecoration(
      color: Color(graphique.color['main_color_1']),
      border: Border(
        bottom: BorderSide(
            width: 1.0, color: Color(graphique.color['default_black'])),
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
          child: Image.asset('images/logo_homescreen.png'),
        ),
        Container(
            margin: const EdgeInsets.only(
              // right: 10,
              top: 20,
              bottom: 20,
            ),
            decoration: BoxDecoration(
              color: Color(graphique.color['main_color_1']),
              // border: Border.all(
              //   color: Colors.black,
              //   width: 4,
              // ),
              // borderRadius: BorderRadius.circular(4)
            ),
            child: GestureDetector(
              onTap: () {
                showDialog(
                    barrierColor: null,
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                          alignment: const Alignment(1.1, -0.85),
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Color(graphique.color['main_color_2']),
                            ),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 5,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                UserInforPage()));
                                  },
                                  child: Container(
                                      margin: const EdgeInsets.only(
                                          left: 10, bottom: 5),
                                      // color: Colors.red,
                                      child: Row(
                                        children: [
                                          Icon(
                                            FontAwesomeIcons.user,
                                            size: 15,
                                            color: Color(graphique
                                                .color['default_black']),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            graphique.languagefr['header_page']
                                                ['user_infor_form']['button_1'],
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Color(graphique
                                                  .color['default_black']),
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                                const Divider(
                                  thickness: 3,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    Fluttertoast.showToast(
                                        msg: 'Logged Out',
                                        gravity: ToastGravity.TOP);
                                    await FirebaseAuth.instance.signOut();
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) => LoginPage()));
                                  },
                                  child: Container(
                                      margin: const EdgeInsets.only(
                                          left: 10, bottom: 5),
                                      // color: Colors.red,
                                      child: Row(
                                        children: [
                                          Icon(
                                            FontAwesomeIcons.signOutAlt,
                                            size: 15,
                                            color: Color(graphique
                                                .color['default_black']),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            graphique.languagefr['header_page']
                                                ['user_infor_form']['button_2'],
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Color(graphique
                                                  .color['default_black']),
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                              ],
                            ),
                          ));
                    });
              },
              child: Row(
                children: [
                  Image.asset('images/logo_user.png'),
                  const SizedBox(width: 10),
                  Text(
                    displayName!,
                    style: TextStyle(
                      color: Color(graphique.color['default_black']),
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            )),
      ],
    ),
  );
}
