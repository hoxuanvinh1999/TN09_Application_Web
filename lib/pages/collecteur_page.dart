import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tn09_app_web_demo/header.dart';
import 'package:tn09_app_web_demo/menu/menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CollecteurPage extends StatefulWidget {
  @override
  _CollecteurPageState createState() => _CollecteurPageState();
}

class _CollecteurPageState extends State<CollecteurPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference _collecteur =
      FirebaseFirestore.instance.collection("Collecteur");
  Stream<QuerySnapshot> _collecteurStream = FirebaseFirestore.instance
      .collection("Collecteur")
      .orderBy('nomCollecteur')
      .snapshots();

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
                  child: Column(
                    children: [
                      Container(
                        color: Colors.blue,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(width: 20),
                                Icon(
                                  Icons.people,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Collecteur',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: 280,
                                ),
                                Container(
                                    width: 150,
                                    decoration: BoxDecoration(
                                        color: Colors.yellow,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    margin: const EdgeInsets.only(
                                        right: 10, top: 20, bottom: 20),
                                    child: GestureDetector(
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.add,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'New Collecteur',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            const Divider(
                              thickness: 5,
                            ),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      ),
                      Container(
                          color: Colors.red,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    'Nom',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 200,
                                  ),
                                  Text(
                                    'Sites',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              const Divider(
                                thickness: 5,
                              ),
                              SizedBox(
                                height: 15,
                              )
                            ],
                          )),
                      StreamBuilder<QuerySnapshot>(
                        stream: _collecteurStream,
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text('Something went wrong');
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          }
                          // print('$snapshot');
                          return Column(
                            children: snapshot.data!.docs
                                .map((DocumentSnapshot document) {
                              Map<String, dynamic> collecteur =
                                  document.data()! as Map<String, dynamic>;
                              // print('$collecteur');
                              return Container(
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Container(
                                            alignment: Alignment.topLeft,
                                            width: 200,
                                            height: 50,
                                            color: Colors.green,
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  collecteur['nomCollecteur'],
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  collecteur[
                                                      'prenomCollecteur'],
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 30,
                                          ),
                                          Container(
                                            alignment: Alignment(-1, 0.15),
                                            width: 200,
                                            height: 50,
                                            color: Colors.green,
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.place,
                                                  color: Colors.black,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  collecteur['siteCollecteur'],
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 100,
                                          ),
                                          Container(
                                            alignment: Alignment(-1, 0.15),
                                            width: 50,
                                            height: 50,
                                            color: Colors.green,
                                            child: IconButton(
                                              icon: const Icon(Icons.edit),
                                              tooltip: 'Modifiy Collecteur',
                                              onPressed: () {
                                                //update later
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      const Divider(
                                        thickness: 5,
                                      ),
                                    ],
                                  ));
                            }).toList(),
                          );
                        },
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
