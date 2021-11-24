import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tn09_app_web_demo/menu/header.dart';
import 'package:tn09_app_web_demo/home_screen.dart';
import 'package:tn09_app_web_demo/menu/menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tn09_app_web_demo/pages/menu2/create_contact_page.dart';
import 'package:tn09_app_web_demo/pages/math_function/limit_length_string.dart';
import 'package:tn09_app_web_demo/pages/menu2/view_contact_page.dart';
import 'package:tn09_app_web_demo/pages/menu2/view_partenaire_page.dart';
import 'package:tn09_app_web_demo/decoration/graphique.dart' as graphique;

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  // for partenaire
  CollectionReference _partenaire =
      FirebaseFirestore.instance.collection("Partenaire");

  //For contact
  CollectionReference _contact =
      FirebaseFirestore.instance.collection("Contact");
  Stream<QuerySnapshot> _contactStream = FirebaseFirestore.instance
      .collection("Contact")
      .where('idContact', isNotEqualTo: 'null')
      .snapshots();
  // null Map
  Map<String, String> nullPartenaire = {};
  // for control table contactpartenaire
  CollectionReference _contactpartenaire =
      FirebaseFirestore.instance.collection("ContactPartenaire");
  String isPrincipal = 'true';
  @override
  Widget build(BuildContext context) {
    // Fow width of table
    double page_width = MediaQuery.of(context).size.width * 0.9;
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
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
                size: 12,
                color: Color(graphique.color['default_black']),
              ),
              const SizedBox(width: 5),
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
                      text: graphique.languagefr['contact_page']['nom_page'],
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
      Align(
          alignment: Alignment(-0.9, 0),
          child: Container(
              margin: const EdgeInsets.only(left: 20, top: 20),
              width: page_width,
              height: 2000,
              decoration: BoxDecoration(
                color: Color(graphique.color['special_bureautique_2']),
                border: Border.all(
                    width: 1.0, color: Color(graphique.color['default_black'])),
              ),
              child: Column(children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: Color(graphique.color['main_color_1']),
                    border: Border.all(
                        width: 1.0,
                        color: Color(graphique.color['default_black'])),
                  ),
                  width: page_width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 20),
                        child: Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.user,
                              size: 17,
                              color: Color(graphique.color['main_color_2']),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              graphique.languagefr['contact_page']
                                  ['table_title'],
                              style: TextStyle(
                                color: Color(graphique.color['main_color_2']),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          width: 180,
                          decoration: BoxDecoration(
                              color: Color(graphique.color['default_yellow']),
                              borderRadius: BorderRadius.circular(10)),
                          margin: const EdgeInsets.only(
                              right: 10, top: 20, bottom: 20),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CreateContactPage()));
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.add,
                                  color:
                                      Color(graphique.color['default_black']),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  graphique.languagefr['contact_page']
                                      ['button_1'],
                                  style: TextStyle(
                                    color:
                                        Color(graphique.color['default_black']),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  width: page_width,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(graphique.color['main_color_1']),
                    border: Border.all(
                        width: 1.0,
                        color: Color(graphique.color['default_black'])),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          graphique.languagefr['contact_page']
                              ['column_1_title'],
                          style: TextStyle(
                            color: Color(graphique.color['main_color_2']),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 150,
                        ),
                        Text(
                          graphique.languagefr['contact_page']
                              ['column_2_title'],
                          style: TextStyle(
                            color: Color(graphique.color['main_color_2']),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 250,
                        ),
                        Text(
                          graphique.languagefr['contact_page']
                              ['column_3_title'],
                          style: TextStyle(
                            color: Color(graphique.color['main_color_2']),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 300,
                        ),
                        Text(
                          graphique.languagefr['contact_page']
                              ['column_4_title'],
                          style: TextStyle(
                            color: Color(graphique.color['main_color_2']),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  height: 1000,
                  child: SingleChildScrollView(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: _contactStream,
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
                            Map<String, dynamic> contact =
                                document.data()! as Map<String, dynamic>;
                            return Container(
                                height:
                                    // 50 +
                                    //     double.parse(contact['nombredePartenaire']) *
                                    //         50,
                                    100,
                                width: page_width,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 20),
                                decoration: BoxDecoration(
                                  color: Color(
                                      graphique.color['special_bureautique_2']),
                                  border: Border(
                                      top: BorderSide(
                                          width: 1.0,
                                          color: Color(graphique
                                              .color['default_black'])),
                                      bottom: BorderSide(
                                          width: 1.0,
                                          color: Color(graphique
                                              .color['default_black']))),
                                ),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(left: 20),
                                        width: 200,
                                        height: 50,
                                        color: Color(graphique
                                            .color['special_bureautique_2']),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              FontAwesomeIcons.user,
                                              size: 17,
                                              color: Color(graphique
                                                  .color['default_black']),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            RichText(
                                              text: TextSpan(
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text: limitString(
                                                          text: contact[
                                                                  'nomContact'] +
                                                              ' ' +
                                                              contact[
                                                                  'prenomContact'],
                                                          limit_long: 15),
                                                      style: TextStyle(
                                                          color: Color(graphique
                                                                  .color[
                                                              'default_black']),
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      recognizer:
                                                          TapGestureRecognizer()
                                                            ..onTap = () {
                                                              Navigator.of(context).pushReplacement(MaterialPageRoute(
                                                                  builder: (context) => ViewContactPage(
                                                                      partenaire:
                                                                          nullPartenaire,
                                                                      from:
                                                                          'contactpage',
                                                                      dataContact:
                                                                          contact)));
                                                            }),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(left: 50),
                                        width: 300,
                                        height: 50,
                                        color: Color(graphique
                                            .color['special_bureautique_2']),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              FontAwesomeIcons.envelope,
                                              size: 17,
                                              color: Color(graphique
                                                  .color['default_black']),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              contact['emailContact'] == ''
                                                  ? 'N/A'
                                                  : contact['emailContact'],
                                              style: TextStyle(
                                                color: Color(graphique
                                                    .color['default_black']),
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(left: 20),
                                        width: 300,
                                        height: 50,
                                        color: Color(graphique
                                            .color['special_bureautique_2']),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      FontAwesomeIcons.phone,
                                                      size: 17,
                                                      color: Color(
                                                          graphique.color[
                                                              'default_black']),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      contact['telephone1Contact'] ==
                                                              ''
                                                          ? 'N/A'
                                                          : contact[
                                                              'telephone1Contact'],
                                                      style: TextStyle(
                                                        color: Color(graphique
                                                                .color[
                                                            'default_black']),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      FontAwesomeIcons.phone,
                                                      size: 17,
                                                      color: Color(
                                                          graphique.color[
                                                              'default_black']),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      contact['telephone2Contact'] ==
                                                              ''
                                                          ? 'N/A'
                                                          : contact[
                                                              'telephone2Contact'],
                                                      style: TextStyle(
                                                        color: Color(graphique
                                                                .color[
                                                            'default_black']),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(left: 20),
                                        height: 50,
                                        width: 200,
                                        decoration: BoxDecoration(
                                          color: Color(
                                              graphique.color['main_color_1']),
                                          border: Border.all(
                                              width: 1.0,
                                              color: Color(graphique
                                                  .color['default_black'])),
                                        ),
                                        child: StreamBuilder<QuerySnapshot>(
                                          stream: _contactpartenaire
                                              .where('idContact',
                                                  isEqualTo:
                                                      contact['idContact'])
                                              .snapshots(),
                                          builder: (BuildContext context,
                                              AsyncSnapshot<QuerySnapshot>
                                                  snapshot) {
                                            // print('snapshot ${snapshot.data}');
                                            if (snapshot.hasError) {
                                              return Text(
                                                  'Something went wrong');
                                            }
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return CircularProgressIndicator();
                                            }
                                            return SingleChildScrollView(
                                              child: Column(
                                                children: snapshot.data!.docs
                                                    .map((DocumentSnapshot
                                                        document_link_contactpartenaire) {
                                                  Map<String, dynamic>
                                                      link_contactpartenaire =
                                                      document_link_contactpartenaire
                                                              .data()!
                                                          as Map<String,
                                                              dynamic>;
                                                  // print('link_contactadresse $link_contactadresse');
                                                  return Container(
                                                    color: Color(graphique
                                                        .color['main_color_1']),
                                                    child: StreamBuilder<
                                                        QuerySnapshot>(
                                                      stream: FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              "Partenaire")
                                                          .where('idPartenaire',
                                                              isEqualTo:
                                                                  link_contactpartenaire[
                                                                      'idPartenaire'])
                                                          .snapshots(),
                                                      builder: (BuildContext
                                                              context,
                                                          AsyncSnapshot<
                                                                  QuerySnapshot>
                                                              snapshot) {
                                                        if (snapshot.hasError) {
                                                          return Text(
                                                              'Something went wrong');
                                                        }

                                                        if (snapshot
                                                                .connectionState ==
                                                            ConnectionState
                                                                .waiting) {
                                                          return CircularProgressIndicator();
                                                        }
                                                        return Column(
                                                          children: snapshot
                                                              .data!.docs
                                                              .map((DocumentSnapshot
                                                                  document_partenaire) {
                                                            Map<String, dynamic>
                                                                insidedataPartenaire =
                                                                document_partenaire
                                                                        .data()!
                                                                    as Map<
                                                                        String,
                                                                        dynamic>;

                                                            // print(
                                                            //     'insidedataContact $insidedataContact');
                                                            return Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Row(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      RichText(
                                                                        text:
                                                                            TextSpan(
                                                                          children: <
                                                                              TextSpan>[
                                                                            TextSpan(
                                                                                text: limitString(text: insidedataPartenaire['nomPartenaire'], limit_long: 15),
                                                                                style: TextStyle(
                                                                                  color: Color(graphique.color['default_red']),
                                                                                  fontSize: 15,
                                                                                  fontWeight: FontWeight.bold,
                                                                                ),
                                                                                recognizer: TapGestureRecognizer()
                                                                                  ..onTap = () {
                                                                                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ViewPartenairePage(partenaire: insidedataPartenaire)));
                                                                                  }),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                ]);
                                                          }).toList(),
                                                        );
                                                      },
                                                    ),
                                                  );
                                                }).toList(),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            color: Color(
                                                graphique.color['default_red']),
                                            border: Border.all(
                                              width: 1.0,
                                              color: Color(graphique
                                                  .color['default_black']),
                                            )),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                showEditPartenaireDialog(
                                                    context: context,
                                                    dataContact: contact);
                                              },
                                              icon: Icon(
                                                FontAwesomeIcons.edit,
                                                size: 15,
                                                color: Color(graphique
                                                    .color['default_black']),
                                              ),
                                              tooltip: graphique.languagefr[
                                                      'contact_page']
                                                  ['icon_button_1_title'],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ));
                          }).toList(),
                        );
                      },
                    ),
                  ),
                )
              ]))),
    ])));
  }

  showEditPartenaireDialog(
      {required BuildContext context, required Map dataContact}) {
    double form_width = MediaQuery.of(context).size.width * 0.7;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              child: Container(
            height: 800,
            width: form_width,
            decoration: BoxDecoration(
              color: Color(graphique.color['default_white']),
              border: Border.all(
                width: 1.0,
                color: Color(graphique.color['default_black']),
              ),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      height: 80,
                      alignment: Alignment(-0.9, 0),
                      decoration: BoxDecoration(
                        color: Color(graphique.color['special_bureautique_2']),
                        border: Border.all(
                            width: 1.0,
                            color: Color(graphique.color['default_black'])),
                      ),
                      child: Text(
                        graphique.languagefr['contact_page']
                                ['edit_partenaire_form']['form_title'] +
                            ': ' +
                            dataContact['nomContact'] +
                            ' ' +
                            dataContact['prenomContact'],
                        style: TextStyle(
                            color: Color(graphique.color['default_black']),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    height: 200,
                    width: form_width * 2 / 3,
                    decoration: BoxDecoration(
                      color: Color(graphique.color['default_green']),
                      border: Border.all(
                          width: 1.0,
                          color: Color(graphique.color['default_black'])),
                    ),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: _contactpartenaire
                          .where('idContact',
                              isEqualTo: dataContact['idContact'])
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        // print('snapshot ${snapshot.data}');
                        if (snapshot.hasError) {
                          return Text('Something went wrong');
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }
                        return SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: snapshot.data!.docs.map((DocumentSnapshot
                                document_link_contactpartenaire) {
                              Map<String, dynamic> link_contactpartenaire =
                                  document_link_contactpartenaire.data()!
                                      as Map<String, dynamic>;
                              // print('link_contactadresse $link_contactadresse');
                              return Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                width: form_width * 0.6,
                                height: 60,
                                decoration: BoxDecoration(
                                  color:
                                      Color(graphique.color['default_white']),
                                  border: Border.all(
                                      width: 1.0,
                                      color: Color(
                                        graphique.color['default_black'],
                                      )),
                                ),
                                child: StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection("Partenaire")
                                      .where('idPartenaire',
                                          isEqualTo: link_contactpartenaire[
                                              'idPartenaire'])
                                      .snapshots(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (snapshot.hasError) {
                                      return Text('Something went wrong');
                                    }

                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                    }
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: snapshot.data!.docs
                                          .map((DocumentSnapshot document) {
                                        Map<String, dynamic>
                                            insidedataPartenaire =
                                            document.data()!
                                                as Map<String, dynamic>;

                                        // print(
                                        //     'insidedataContact $insidedataContact');
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                                width: 400,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(width: 20),
                                                    Icon(
                                                      FontAwesomeIcons.flag,
                                                      color: Color(
                                                          graphique.color[
                                                              'default_black']),
                                                      size: 15,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    RichText(
                                                      text: TextSpan(
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                              text: insidedataPartenaire[
                                                                  'nomPartenaire'],
                                                              style: TextStyle(
                                                                  color: Color(graphique
                                                                          .color[
                                                                      'default_red']),
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                              recognizer:
                                                                  TapGestureRecognizer()
                                                                    ..onTap =
                                                                        () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pushReplacement(
                                                                              MaterialPageRoute(builder: (context) => ViewPartenairePage(partenaire: insidedataPartenaire)));
                                                                    }),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                            Container(
                                              width: 50,
                                              child: IconButton(
                                                onPressed: () async {
                                                  await _contact
                                                      .where('idContact',
                                                          isEqualTo:
                                                              dataContact[
                                                                  'idContact'])
                                                      .limit(1)
                                                      .get()
                                                      .then((QuerySnapshot
                                                          querySnapshot) {
                                                    querySnapshot.docs
                                                        .forEach((doc) {
                                                      _contact
                                                          .doc(doc.id)
                                                          .update({
                                                        'nombredePartenaire':
                                                            (int.parse(doc[
                                                                        'nombredePartenaire']) -
                                                                    1)
                                                                .toString(),
                                                      });
                                                    });
                                                  });

                                                  _contactpartenaire
                                                      .where("idContact",
                                                          isEqualTo:
                                                              dataContact[
                                                                  'idContact'])
                                                      .where('idPartenaire',
                                                          isEqualTo:
                                                              insidedataPartenaire[
                                                                  'idPartenaire'])
                                                      .get()
                                                      .then((value) {
                                                    value.docs
                                                        .forEach((doc) async {
                                                      await _partenaire
                                                          .where('idPartenaire',
                                                              isEqualTo:
                                                                  insidedataPartenaire[
                                                                      'idPartenaire'])
                                                          .limit(1)
                                                          .get()
                                                          .then((QuerySnapshot
                                                              querySnapshot) {
                                                        querySnapshot.docs
                                                            .forEach((doc) {
                                                          if (doc['nombredeContact'] ==
                                                              '1') {
                                                            _partenaire
                                                                .doc(doc.id)
                                                                .update({
                                                              'idContactPartenaire':
                                                                  'null',
                                                            });
                                                          }
                                                          _partenaire
                                                              .doc(doc.id)
                                                              .update({
                                                            'nombredeContact':
                                                                (int.parse(doc[
                                                                            'nombredeContact']) -
                                                                        1)
                                                                    .toString(),
                                                          });
                                                        });
                                                      });
                                                      _contactpartenaire
                                                          .doc(doc.id)
                                                          .delete()
                                                          .then((value) {
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                "Partenaire Removed",
                                                            gravity:
                                                                ToastGravity
                                                                    .TOP);
                                                        Navigator.of(context)
                                                            .pop();
                                                        showEditPartenaireDialog(
                                                            context: context,
                                                            dataContact:
                                                                dataContact);
                                                      });
                                                    });
                                                  });
                                                },
                                                icon: const Icon(
                                                  FontAwesomeIcons.minus,
                                                  size: 15,
                                                ),
                                                tooltip: graphique.languagefr[
                                                            'contact_page']
                                                        ['edit_partenaire_form']
                                                    ['icon_button_2'],
                                              ),
                                            ),
                                          ],
                                        );
                                      }).toList(),
                                    );
                                  },
                                ),
                              );
                            }).toList(),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    width: form_width * 2 / 3,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Color(graphique.color['default_blue']),
                      border: Border.all(
                          width: 1.0,
                          color: Color(graphique.color['default_black'])),
                    ),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: _partenaire
                          .where('nomPartenaire', isNotEqualTo: 'None')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        // print('snapshot ${snapshot.data}');
                        if (snapshot.hasError) {
                          return Text('Something went wrong');
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }
                        return SingleChildScrollView(
                          child: Column(
                            children: snapshot.data!.docs
                                .map((DocumentSnapshot document_partenaire) {
                              Map<String, dynamic> insidedataPartenaire =
                                  document_partenaire.data()!
                                      as Map<String, dynamic>;
                              // print('link_contactadresse $link_contactadresse');
                              return Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                width: form_width * 0.6,
                                height: 50,
                                decoration: BoxDecoration(
                                  color:
                                      Color(graphique.color['default_white']),
                                  border: Border.all(
                                    width: 1.0,
                                    color:
                                        Color(graphique.color['default_black']),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        width: 300,
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Icon(
                                              FontAwesomeIcons.flag,
                                              color: Color(graphique
                                                  .color['default_black']),
                                              size: 15,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            RichText(
                                              text: TextSpan(
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text:
                                                          insidedataPartenaire[
                                                              'nomPartenaire'],
                                                      style: TextStyle(
                                                          color: Color(graphique
                                                                  .color[
                                                              'default_red']),
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      recognizer:
                                                          TapGestureRecognizer()
                                                            ..onTap = () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pushReplacement(
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              ViewPartenairePage(partenaire: insidedataPartenaire)));
                                                            }),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )),
                                    Container(
                                        width: 100,
                                        child: Row(children: [
                                          IconButton(
                                            onPressed: () async {
                                              QuerySnapshot query =
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection(
                                                          'ContactPartenaire')
                                                      .where('idContact',
                                                          isEqualTo:
                                                              dataContact[
                                                                  'idContact'])
                                                      .where('idPartenaire',
                                                          isEqualTo:
                                                              insidedataPartenaire[
                                                                  'idPartenaire'])
                                                      .get();
                                              if (query.docs.isEmpty) {
                                                await _contact
                                                    .where('idContact',
                                                        isEqualTo: dataContact[
                                                            'idContact'])
                                                    .limit(1)
                                                    .get()
                                                    .then((QuerySnapshot
                                                        querySnapshot) {
                                                  querySnapshot.docs
                                                      .forEach((doc) {
                                                    _contact
                                                        .doc(doc.id)
                                                        .update({
                                                      'nombredePartenaire':
                                                          (int.parse(doc[
                                                                      'nombredePartenaire']) +
                                                                  1)
                                                              .toString(),
                                                    });
                                                  });
                                                });
                                                await _partenaire
                                                    .where('idPartenaire',
                                                        isEqualTo:
                                                            insidedataPartenaire[
                                                                'idPartenaire'])
                                                    .limit(1)
                                                    .get()
                                                    .then((QuerySnapshot
                                                        querySnapshot) {
                                                  querySnapshot.docs
                                                      .forEach((doc) {
                                                    if (doc['nombredeContact'] ==
                                                        '0') {
                                                      isPrincipal = 'true';
                                                      _partenaire
                                                          .doc(doc.id)
                                                          .update({
                                                        'idContactPartenaire':
                                                            dataContact[
                                                                'idContact'],
                                                      });
                                                    } else {
                                                      isPrincipal = 'false';
                                                    }
                                                    _partenaire
                                                        .doc(doc.id)
                                                        .update({
                                                      'nombredeContact':
                                                          (int.parse(doc[
                                                                      'nombredeContact']) +
                                                                  1)
                                                              .toString(),
                                                    });
                                                  });
                                                });
                                                await _contactpartenaire
                                                    .doc(_contactpartenaire
                                                        .doc()
                                                        .id)
                                                    .set({
                                                  'idContact':
                                                      dataContact['idContact'],
                                                  'idPartenaire':
                                                      insidedataPartenaire[
                                                          'idPartenaire'],
                                                  'isPrincipal': isPrincipal,
                                                }).then((value) {
                                                  print("Partenaire Added");
                                                  Fluttertoast.showToast(
                                                      msg: "Partenaire Added",
                                                      gravity:
                                                          ToastGravity.TOP);
                                                  Navigator.of(context).pop();
                                                  showEditPartenaireDialog(
                                                      context: context,
                                                      dataContact: dataContact);
                                                }).catchError((error) => print(
                                                        "Failed to add user: $error"));
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        'It has been added already',
                                                    gravity: ToastGravity.TOP);
                                              }
                                            },
                                            icon: Icon(
                                              FontAwesomeIcons.plus,
                                              size: 15,
                                              color: Color(graphique
                                                  .color['default_black']),
                                            ),
                                            tooltip: graphique.languagefr[
                                                        'contact_page']
                                                    ['edit_partenaire_form']
                                                ['icon_button_1'],
                                          ),
                                        ]))
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    width: form_width * 3 / 4,
                    height: 80,
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1.0,
                          color: Color(graphique.color['default_black'])),
                      color: Color(graphique.color['main_color_1']),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            width: 150,
                            decoration: BoxDecoration(
                                color: Color(graphique.color['default_yellow']),
                                borderRadius: BorderRadius.circular(10)),
                            margin: const EdgeInsets.only(
                                right: 10, top: 20, bottom: 20),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.delete,
                                    color:
                                        Color(graphique.color['default_black']),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    graphique.languagefr['contact_page']
                                        ['edit_partenaire_form']['button_1'],
                                    style: TextStyle(
                                      color: Color(
                                          graphique.color['default_black']),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                ]),
          ));
        });
  }
}
