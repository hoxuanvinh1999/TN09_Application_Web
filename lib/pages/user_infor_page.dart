import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tn09_app_web_demo/menu/header.dart';
import 'package:tn09_app_web_demo/home_screen.dart';
import 'package:tn09_app_web_demo/menu/menu.dart';
import 'package:tn09_app_web_demo/decoration/graphique.dart' as graphique;

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
    // For width of table
    double column1_width = MediaQuery.of(context).size.width * 0.45;
    double column2_width = MediaQuery.of(context).size.width * 0.45;
    inputData();
    // print('$check');
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
                    width: 1.0, color: Color(graphique.color['default_black'])),
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
                  color: Color(graphique.color['default_black']),
                  size: 12,
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
                        text: graphique.languagefr['user_infor_page']
                            ['nom_page'],
                        style: TextStyle(
                            color: Color(graphique.color['default_grey']),
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            )),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.only(
                left: 20,
                top: 20,
                bottom: 20,
              ),
              width: column1_width,
              height: 650,
              decoration: BoxDecoration(
                color: Color(graphique.color['special_bureautique_2']),
                border: Border.all(
                    width: 1.0, color: Color(graphique.color['default_black'])),
              ),
              child: Column(
                children: [
                  Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: Color(graphique.color['main_color_1']),
                      border: Border.all(
                          width: 1.0,
                          color: Color(graphique.color['default_black'])),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 20),
                        Icon(
                          FontAwesomeIcons.user,
                          size: 17,
                          color: Color(graphique.color['main_color_2']),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          graphique.languagefr['user_infor_page']
                              ['change_user_name_form']['form_title'],
                          style: TextStyle(
                            color: Color(graphique.color['main_color_2']),
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      height: 100,
                      width: column1_width * 2 / 3,
                      decoration: BoxDecoration(
                        color: Color(graphique.color['special_bureautique_2']),
                        // border: Border.all(width: 1.0),
                      ),
                      child: Form(
                          key: _changeUserDisplayKeyForm,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                width: 400,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color:
                                        Color(graphique.color['main_color_1']),
                                  ),
                                  color: Color(
                                      graphique.color['special_bureautique_1']),
                                ),
                                child: TextFormField(
                                  style: TextStyle(
                                      color: Color(
                                          graphique.color['main_color_2'])),
                                  cursorColor:
                                      Color(graphique.color['main_color_2']),
                                  controller: _displaynameController,
                                  decoration: InputDecoration(
                                    labelText:
                                        graphique.languagefr['user_infor_page']
                                                ['change_user_name_form']
                                            ['field_1_title'],
                                    labelStyle: TextStyle(
                                      color: Color(
                                          graphique.color['main_color_2']),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(
                                            graphique.color['main_color_2']),
                                      ),
                                    ),
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
                      width: column1_width * 3 / 4,
                      decoration: BoxDecoration(
                          color: Color(graphique.color['default_yellow']),
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
                          graphique.languagefr['user_infor_page']
                              ['change_user_name_form']['button_1'],
                          style: TextStyle(
                            color: Color(graphique.color['default_black']),
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                right: 20,
                top: 20,
                bottom: 20,
              ),
              width: column2_width,
              height: 650,
              decoration: BoxDecoration(
                color: Color(graphique.color['special_bureautique_2']),
                border: Border.all(
                    width: 1.0, color: Color(graphique.color['default_black'])),
              ),
              child: Column(
                children: [
                  Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: Color(graphique.color['main_color_1']),
                      border: Border.all(
                          width: 1.0,
                          color: Color(graphique.color['default_black'])),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 20),
                        Icon(
                          FontAwesomeIcons.key,
                          size: 17,
                          color: Color(graphique.color['main_color_2']),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          graphique.languagefr['user_infor_page']
                              ['change_password_form']['form_title'],
                          style: TextStyle(
                            color: Color(graphique.color['main_color_2']),
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      height: 300,
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      width: column1_width * 2 / 3,
                      decoration: BoxDecoration(
                        color: Color(graphique.color['special_bureautique_2']),
                        // border: Border.all(width: 1.0),
                      ),
                      child: Form(
                          key: _changePasswordKeyForm,
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                width: 400,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color:
                                        Color(graphique.color['main_color_1']),
                                  ),
                                  color: Color(
                                      graphique.color['special_bureautique_1']),
                                ),
                                child: TextFormField(
                                  style: TextStyle(
                                      color: Color(
                                          graphique.color['main_color_2'])),
                                  cursorColor:
                                      Color(graphique.color['main_color_2']),
                                  obscureText: true,
                                  controller: _currentPasswordController,
                                  decoration: InputDecoration(
                                    labelText:
                                        graphique.languagefr['user_infor_page']
                                                ['change_password_form']
                                            ['field_1_title'],
                                    labelStyle: TextStyle(
                                      color: Color(
                                          graphique.color['main_color_2']),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(
                                            graphique.color['main_color_2']),
                                      ),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value == '') {
                                      return graphique.languagefr['warning']
                                          ['not_null'];
                                    }
                                  },
                                ),
                              ),
                              Divider(
                                thickness: 3,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                width: 400,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color:
                                        Color(graphique.color['main_color_1']),
                                  ),
                                  color: Color(
                                      graphique.color['special_bureautique_1']),
                                ),
                                child: TextFormField(
                                  style: TextStyle(
                                      color: Color(
                                          graphique.color['main_color_2'])),
                                  cursorColor:
                                      Color(graphique.color['main_color_2']),
                                  obscureText: true,
                                  controller: _newPasswordController,
                                  decoration: InputDecoration(
                                    labelText:
                                        graphique.languagefr['user_infor_page']
                                                ['change_password_form']
                                            ['field_2_title'],
                                    labelStyle: TextStyle(
                                      color: Color(
                                          graphique.color['main_color_2']),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(
                                            graphique.color['main_color_2']),
                                      ),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value == '') {
                                      return graphique.languagefr['warning']
                                          ['not_null'];
                                    }
                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                width: 400,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color:
                                        Color(graphique.color['main_color_1']),
                                  ),
                                  color: Color(
                                      graphique.color['special_bureautique_1']),
                                ),
                                child: TextFormField(
                                  style: TextStyle(
                                      color: Color(
                                          graphique.color['main_color_2'])),
                                  cursorColor:
                                      Color(graphique.color['main_color_2']),
                                  obscureText: true,
                                  controller: _checknewPasswordController,
                                  decoration: InputDecoration(
                                    labelText:
                                        graphique.languagefr['user_infor_page']
                                                ['change_password_form']
                                            ['field_3_title'],
                                    labelStyle: TextStyle(
                                      color: Color(
                                          graphique.color['main_color_2']),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(
                                            graphique.color['main_color_2']),
                                      ),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value == '') {
                                      return graphique.languagefr['warning']
                                          ['not_null'];
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
                      width: column1_width * 3 / 4,
                      decoration: BoxDecoration(
                          color: Color(graphique.color['default_yellow']),
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
                          graphique.languagefr['user_infor_page']
                              ['change_password_form']['button_1'],
                          style: TextStyle(
                            color: Color(graphique.color['default_black']),
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
