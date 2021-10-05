import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tn09_app_web_demo/collecteur_page.dart';
import 'dart:async';
import 'package:tn09_app_web_demo/login_page/login_page.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final auth = FirebaseAuth.instance;
  String dropdownValue = 'One';
  ElevatedButton button1 = ElevatedButton(onPressed: () {}, child: Text('12'));
  @override
  Widget build(BuildContext context) {
    // final applicationBloc = Provider.of<ApplicationBloc>(context);
    return Scaffold(
      body: SingleChildScrollView(
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
                        margin: const EdgeInsets.only(
                            right: 10, top: 20, bottom: 20),
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
            Container(
              color: Colors.red,
              width: double.infinity,
              height: 50,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        showSubMenu1(context: context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 200,
                        decoration: BoxDecoration(color: Colors.blue),
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text('Button1',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        showSubMenu2(context: context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 200,
                        decoration: BoxDecoration(color: Colors.blue),
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text('Button2',
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
            ),
          ],
        ),
      ),
    );
  }

  showSubMenu1({required BuildContext context}) {
    return showDialog(
        barrierColor: null,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            alignment: Alignment(-1.045, -0.04),
            child: Container(
                height: 400,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [],
                  ),
                )),
          );
        });
  }

  showSubMenu2({required BuildContext context}) {
    return showDialog(
        barrierColor: null,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            alignment: Alignment(-0.6, -0.04),
            child: Container(
                height: 400,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [],
                  ),
                )),
          );
        });
  }
}
