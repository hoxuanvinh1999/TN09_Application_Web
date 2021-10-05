import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tn09_app_web_demo/home_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email = '';
  String _password = '';
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                Color(0xFFBFAC97),
                Color(0xFF74B424),
                Color(0xFF94C21E),
              ])),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 80,
                ),
                Image.asset('images/app_logo.png'),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Les Detritivores',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 480,
                  width: 400,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      SizedBox(height: 30),
                      Text(
                        'Log In Page',
                        style: TextStyle(
                            fontSize: 35, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Log into our DataBase',
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 300,
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Email Address',
                            suffixIcon: Icon(
                              FontAwesomeIcons.envelope,
                              size: 17,
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _email = value.trim();
                            });
                          },
                        ),
                      ),
                      Container(
                        width: 300,
                        child: TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            suffixIcon: Icon(
                              FontAwesomeIcons.eyeSlash,
                              size: 17,
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _password = value.trim();
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 20, 40, 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Forget Password',
                              style: TextStyle(color: Colors.orangeAccent[700]),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () => _signin(_email, _password),
                        child: Container(
                          alignment: Alignment.center,
                          width: 300,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFFBFAC97),
                                    Color(0xFF74B424),
                                    Color(0xFF94C21E),
                                  ])),
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text('Sign In',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          showSignUpDialog(context: context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 300,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFFBFAC97),
                                    Color(0xFF74B424),
                                    Color(0xFF94C21E),
                                  ])),
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text('Sign Up',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showSignUpDialog({required BuildContext context}) {
    String signupEmail = '';
    String signupPassword = '';
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              height: 480,
              width: 400,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  // Positioned(
                  //   right: 0.0,
                  //   child: GestureDetector(
                  //     onTap: () {
                  //       Navigator.of(context).pop();
                  //     },
                  //     child: Align(
                  //       alignment: Alignment.topRight,
                  //       child: CircleAvatar(
                  //         radius: 20,
                  //         backgroundColor: Colors.green,
                  //         child: Icon(Icons.close, color: Colors.red),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: 30),
                  Text(
                    'Sign Up Form',
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Sign up to our DataBase',
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 300,
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                        suffixIcon: Icon(
                          FontAwesomeIcons.envelope,
                          size: 17,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          signupEmail = value.trim();
                        });
                      },
                    ),
                  ),
                  Container(
                    width: 300,
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        suffixIcon: Icon(
                          FontAwesomeIcons.eyeSlash,
                          size: 17,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          signupPassword = value.trim();
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      _signup(
                          signupEmail: signupEmail,
                          signupPassword: signupPassword);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 300,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFFBFAC97),
                                Color(0xFF74B424),
                                Color(0xFF94C21E),
                              ])),
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text('Sign Up',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  _signin(String _email, String _password) async {
    try {
      //Create Get Firebase Auth User
      await auth.signInWithEmailAndPassword(email: _email, password: _password);

      //Success
      Fluttertoast.showToast(
          msg: 'Sign In Successed', gravity: ToastGravity.TOP);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()));
    } on FirebaseAuthException catch (error) {
      //String msgerror = 'Error sign in';
      Fluttertoast.showToast(
          msg: (error.message).toString(), gravity: ToastGravity.TOP);
    }
  }

  _signup({required String signupEmail, required String signupPassword}) async {
    try {
      //Create Get Firebase Auth User
      await auth.createUserWithEmailAndPassword(
          email: signupEmail, password: signupPassword);

      //Success
      Fluttertoast.showToast(
          msg: 'Sign Up Successed', gravity: ToastGravity.TOP);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()));
    } on FirebaseAuthException catch (error) {
      //String msgerror = 'Error sign up';
      Fluttertoast.showToast(
        msg: (error.message).toString(),
        gravity: ToastGravity.TOP,
      );
    }
  }
}
