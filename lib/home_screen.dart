import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tn09_app_web_demo/login_page/login_page.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatelessWidget {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    // final applicationBloc = Provider.of<ApplicationBloc>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 80,
            color: Colors.green,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin:
                        const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                    child: Image.asset('images/logo_homescreen.png'),
                  ),
                  Container(
                      margin:
                          const EdgeInsets.only(right: 10, top: 20, bottom: 20),
                      child: GestureDetector(
                        child: Row(
                          children: [
                            Image.asset('images/logo_user.png'),
                            SizedBox(width: 10),
                            Text(
                              'User Name Here',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      )),
                ]),
          ),
        ],
      ),
    );
  }
}
