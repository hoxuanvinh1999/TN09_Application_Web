import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tn09_app_web_demo/collecteur_page.dart';
import 'package:tn09_app_web_demo/header.dart';
import 'dart:async';
import 'package:tn09_app_web_demo/login_page/login_page.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tn09_app_web_demo/menu.dart';
import 'package:tn09_app_web_demo/showSubMenu1.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            header(),
            menu(context: context),
          ],
        ),
      ),
    );
  }
}
