import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tn09_app_web_demo/header.dart';
import 'dart:async';
import 'package:tn09_app_web_demo/login_page/login_page.dart';
import 'package:flutter/services.dart';
import 'package:tn09_app_web_demo/menu/menu.dart';

class CollecteurPage extends StatefulWidget {
  @override
  _CollecteurPageState createState() => _CollecteurPageState();
}

class _CollecteurPageState extends State<CollecteurPage> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            header(),
            menu(context: context),
            SizedBox(height: 20),
            Align(
              alignment: Alignment(-0.9, 0),
              child: Container(
                margin: EdgeInsets.only(left: 20),
                width: 600,
                height: 600,
                color: Colors.green,
              ),
            )
          ],
        ),
      ),
    );
  }
}
