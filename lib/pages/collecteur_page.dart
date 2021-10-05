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
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference collecteur =
      FirebaseFirestore.instance.collection("collecteur");

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
                child: FutureBuilder<DocumentSnapshot>(
                  future: collecteur.doc('xFEa0QGtcZwZ348bu1pP').get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasError) {
                      print('snapshot = $snapshot');
                      return Text("Something went wrong");
                    }

                    if (snapshot.hasData && !snapshot.data!.exists) {
                      return Text("Document does not exist");
                    }

                    if (snapshot.connectionState == ConnectionState.done) {
                      Map<String, dynamic> data =
                          snapshot.data!.data() as Map<String, dynamic>;
                      return Text("Full Name: ${data['nomcollecteur']}");
                    }

                    return Text("loading");
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
