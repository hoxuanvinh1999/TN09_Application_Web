import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tn09_app_web_demo/login_page/login_page.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatelessWidget {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    // final applicationBloc = Provider.of<ApplicationBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('DataBase HomeScreen'),
      ),
    );
  }
}
