import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tn09_app_web_demo/header.dart';
import 'package:tn09_app_web_demo/menu/menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class VehiculePage extends StatefulWidget {
  @override
  _VehiculePageState createState() => _VehiculePageState();
}

class _VehiculePageState extends State<VehiculePage> {
  final _createVehiculeKeyForm = GlobalKey<FormState>();
  final _modifyVehiculeKeyForm = GlobalKey<FormState>();
  String _siteVehicule = 'Bordeaux';
  int _orderVehicule = 1;
  List<String> list_site = ['Bordeaux', 'Paris', 'Lille'];
  List<int> list_order = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  Color _colorVehicule = Colors.red;
  TextEditingController _nomVehiculeController = TextEditingController();
  TextEditingController _numeroImmatriculationVehicule =
      TextEditingController();
  TextEditingController _typeVehiculeController = TextEditingController();
  TextEditingController _nomModifyVehiculeController = TextEditingController();
  TextEditingController _numeroModifyImmatriculationVehicule =
      TextEditingController();
  TextEditingController _typeModifyVehiculeController = TextEditingController();
  CollectionReference _vehicule =
      FirebaseFirestore.instance.collection("Vehicule");
  Stream<QuerySnapshot> _vehiculeStream = FirebaseFirestore.instance
      .collection("Vehicule")
      .orderBy('orderVehicule')
      .snapshots();
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
                  width: 800,
                  height: 1000,
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
                                  FontAwesomeIcons.truck,
                                  size: 17,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Vehicule',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: 500,
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
                                      onTap: () {
                                        showCreateVehicule();
                                      },
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
                                            'New Vehicule',
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
                                  Icon(
                                    FontAwesomeIcons.truck,
                                    size: 17,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Nom Vehicule',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 100,
                                  ),
                                  Text(
                                    'Immatriculation',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 100,
                                  ),
                                  Text(
                                    'Site',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 150,
                                  ),
                                  Icon(
                                    FontAwesomeIcons.sortNumericDown,
                                    size: 17,
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
                        stream: _vehiculeStream,
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
                              Map<String, dynamic> vehicule =
                                  document.data()! as Map<String, dynamic>;
                              // print('$vehicule');
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
                                          buildVehiculeIcon(
                                              icontype:
                                                  vehicule['typeVehicule'],
                                              iconcolor:
                                                  vehicule['colorIconVehicule']
                                                      .toUpperCase()),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            alignment: Alignment(-1, 0.15),
                                            width: 100,
                                            height: 50,
                                            color: Colors.green,
                                            child: Row(
                                              children: [
                                                Text(
                                                  vehicule['nomVehicule'],
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 100,
                                          ),
                                          Container(
                                            alignment: Alignment(-1, 0.15),
                                            width: 100,
                                            height: 50,
                                            color: Colors.green,
                                            child: Row(
                                              children: [
                                                Text(
                                                  vehicule[
                                                      'numeroImmatriculation'],
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 120,
                                          ),
                                          Container(
                                            alignment: Alignment(-1, 0.15),
                                            width: 150,
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
                                                  vehicule['siteVehicule'],
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
                                            width: 50,
                                          ),
                                          Container(
                                            alignment: Alignment(-1, 0.15),
                                            width: 30,
                                            height: 50,
                                            color: Colors.green,
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  vehicule['orderVehicule'],
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
                                            width: 40,
                                          ),
                                          Container(
                                            alignment: Alignment(-1, 0.15),
                                            width: 50,
                                            height: 50,
                                            color: Colors.green,
                                            child: IconButton(
                                              icon: const Icon(Icons.edit),
                                              tooltip: 'Modify Vehicule',
                                              onPressed: () {
                                                showModifyVehiculeDialog(
                                                    context: context,
                                                    dataVehicule: vehicule);
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
            )
          ],
        ),
      ),
    );
  }

  showCreateVehicule() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              height: 800,
              width: 800,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                        height: 80,
                        alignment: Alignment(-0.9, 0),
                        color: Colors.blue,
                        child: Text(
                          'New Vehicule',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        )),
                    Divider(
                      thickness: 5,
                    ),
                    Container(
                      height: 450,
                      color: Colors.green,
                      child: Form(
                          key: _createVehiculeKeyForm,
                          child: Column(
                            children: [
                              Container(
                                width: 400,
                                color: Colors.red,
                                child: TextFormField(
                                  controller: _nomVehiculeController,
                                  decoration: InputDecoration(
                                    labelText: 'Nom Vehicule* :',
                                  ),
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value == '') {
                                      return 'This can not be null';
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: 400,
                                color: Colors.red,
                                child: TextFormField(
                                  controller: _numeroImmatriculationVehicule,
                                  decoration: InputDecoration(
                                    labelText: 'Immatriculation* :',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'This can not be null';
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: 400,
                                color: Colors.red,
                                child: TextFormField(
                                  controller: _typeVehiculeController,
                                  decoration: InputDecoration(
                                    labelText: 'Type* :',
                                  ),
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value == '') {
                                      return 'This can not be null';
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: 400,
                                height: 50,
                                color: Colors.red,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.place,
                                      size: 30,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('Site',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600)),
                                    SizedBox(width: 10),
                                    //dropdown have bug
                                    DropdownButton<String>(
                                        onChanged: (String? changedValue) {
                                          setState(() {
                                            _siteVehicule = changedValue!;
                                            // print(
                                            //     '$_siteVehicule  $changedValue');
                                          });
                                        },
                                        value: _siteVehicule,
                                        items: list_site.map((String value) {
                                          return new DropdownMenuItem<String>(
                                            value: value,
                                            child: new Text(value),
                                          );
                                        }).toList()),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: 400,
                                height: 50,
                                color: Colors.red,
                                child: Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.sortNumericDown,
                                      size: 30,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('Order',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600)),
                                    SizedBox(width: 10),
                                    //dropdown have bug
                                    DropdownButton<int>(
                                        onChanged: (int? changedValue) {
                                          setState(() {
                                            _orderVehicule = changedValue!;
                                            // print(
                                            //     '$_orderVehicule  $changedValue');
                                          });
                                        },
                                        value: _orderVehicule,
                                        items: list_order.map((int value) {
                                          return new DropdownMenuItem<int>(
                                            value: value,
                                            child: new Text('$value'),
                                          );
                                        }).toList()),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: 400,
                                height: 50,
                                color: Colors.red,
                                child: Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.fillDrip,
                                      size: 30,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('Color',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600)),
                                    SizedBox(width: 10),
                                    Container(
                                        alignment: Alignment(-0.8, 0),
                                        width: 150,
                                        decoration: BoxDecoration(
                                            //bug color not change
                                            color: _colorVehicule,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: GestureDetector(
                                          onTap: () {
                                            pickColor(context);
                                          },
                                          child: Text(
                                            'Pick Color',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          )),
                    ),
                    Divider(
                      thickness: 5,
                    ),
                    Container(
                      width: 800,
                      height: 80,
                      color: Colors.red,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 400,
                          ),
                          Container(
                              width: 150,
                              decoration: BoxDecoration(
                                  color: Colors.yellow,
                                  borderRadius: BorderRadius.circular(10)),
                              margin: const EdgeInsets.only(
                                  right: 10, top: 20, bottom: 20),
                              child: GestureDetector(
                                onTap: () {
                                  _nomVehiculeController.text = '';
                                  _numeroImmatriculationVehicule.text = '';
                                  _siteVehicule = 'Bordeaux';
                                  _typeVehiculeController.text = '';
                                  _orderVehicule = 1;
                                  _colorVehicule = Colors.red;
                                  Navigator.of(context).pop();
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Cancel',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                          Container(
                              width: 150,
                              decoration: BoxDecoration(
                                  color: Colors.yellow,
                                  borderRadius: BorderRadius.circular(10)),
                              margin: const EdgeInsets.only(
                                  right: 10, top: 20, bottom: 20),
                              child: GestureDetector(
                                onTap: () async {
                                  if (_createVehiculeKeyForm.currentState!
                                      .validate()) {
                                    if (_typeVehiculeController.text == '') {
                                      _typeVehiculeController.text = 'null';
                                    }
                                    await _vehicule
                                        .doc(_vehicule.doc().id)
                                        .set({
                                      'nomVehicule':
                                          _nomVehiculeController.text,
                                      'numeroImmatriculation':
                                          _numeroImmatriculationVehicule.text,
                                      'siteVehicule': _siteVehicule,
                                      'typeVehicule': _typeVehiculeController
                                          .text
                                          .toLowerCase(),
                                      'orderVehicule':
                                          _orderVehicule.toString(),
                                      'colorIconVehicule': _colorVehicule
                                          .toString()
                                          .substring(6, 16),
                                      'idVehicule': _vehicule.doc().id
                                    }).then((value) {
                                      _nomVehiculeController.text = '';
                                      _numeroImmatriculationVehicule.text = '';
                                      _typeVehiculeController.text = '';
                                      _colorVehicule = Colors.red;
                                      print("Vehicule Added");
                                      Navigator.of(context).pop();
                                    }).catchError((error) => print(
                                            "Failed to add user: $error"));
                                  }
                                },
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
                                      'Save',
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
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  pickColor(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Select Color For Icon Vehicule'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ColorPicker(
                      pickerColor: _colorVehicule,
                      onColorChanged: (color) {
                        // print('color Vehicule: ${_colorVehicule.toString()}');
                        // print('color : ${_colorVehicule.toString()}');
                        setState(() {
                          this._colorVehicule = color;
                        });
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    child: Text(
                      'Select',
                      style: TextStyle(fontSize: 15),
                    ),
                    onPressed: () {
                      // print('${_colorVehicule.toString()}');
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ));
  }

  Widget buildVehiculeIcon(
      {required String icontype, required String iconcolor}) {
    switch (icontype) {
      case 'camion':
        {
          return Icon(
            FontAwesomeIcons.truck,
            size: 17,
            color: Color(int.parse(iconcolor)),
          );
        }
      case 'velo':
        {
          return Icon(
            FontAwesomeIcons.bicycle,
            size: 17,
            color: Color(int.parse(iconcolor)),
          );
        }
      case 'voiture':
        {
          return Icon(
            FontAwesomeIcons.car,
            size: 17,
            color: Color(int.parse(iconcolor)),
          );
        }
      default:
        {
          return Icon(
            FontAwesomeIcons.truck,
            size: 17,
            color: Color(int.parse(iconcolor)),
          );
          ;
        }
    }
  }

  showModifyVehiculeDialog(
      {required BuildContext context, required Map dataVehicule}) {
    String _siteModifyVehicule = dataVehicule['siteVehicule'];
    int _orderModifyVehicule = int.parse(dataVehicule['orderVehicule']);
    _nomModifyVehiculeController.text = dataVehicule['nomVehicule'];
    _numeroModifyImmatriculationVehicule.text =
        dataVehicule['numeroImmatriculation'];
    _typeModifyVehiculeController.text = dataVehicule['typeVehicule'];
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              height: 800,
              width: 800,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                        height: 80,
                        alignment: Alignment(-0.9, 0),
                        color: Colors.blue,
                        child: Text(
                          'Modify Vehicule',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        )),
                    Divider(
                      thickness: 5,
                    ),
                    Container(
                      height: 450,
                      color: Colors.green,
                      child: Form(
                          key: _modifyVehiculeKeyForm,
                          child: Column(
                            children: [
                              Container(
                                width: 400,
                                color: Colors.red,
                                child: TextFormField(
                                  controller: _nomModifyVehiculeController,
                                  decoration: InputDecoration(
                                    labelText: 'Nom Vehicule* :',
                                  ),
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value == '') {
                                      return 'This can not be null';
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: 400,
                                color: Colors.red,
                                child: TextFormField(
                                  controller:
                                      _numeroModifyImmatriculationVehicule,
                                  decoration: InputDecoration(
                                    labelText: 'Immatriculation* :',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'This can not be null';
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: 400,
                                color: Colors.red,
                                child: TextFormField(
                                  controller: _typeModifyVehiculeController,
                                  decoration: InputDecoration(
                                    labelText: 'Type* :',
                                  ),
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value == '') {
                                      return 'This can not be null';
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: 400,
                                height: 50,
                                color: Colors.red,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.place,
                                      size: 30,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('Site',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600)),
                                    SizedBox(width: 10),
                                    //dropdown have bug
                                    DropdownButton<String>(
                                        onChanged: (String? changedValue) {
                                          setState(() {
                                            _siteModifyVehicule = changedValue!;
                                            // print(
                                            //     '$_siteVehicule  $changedValue');
                                          });
                                        },
                                        value: _siteModifyVehicule,
                                        items: list_site.map((String value) {
                                          return new DropdownMenuItem<String>(
                                            value: value,
                                            child: new Text(value),
                                          );
                                        }).toList()),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: 400,
                                height: 50,
                                color: Colors.red,
                                child: Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.sortNumericDown,
                                      size: 30,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('Order',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600)),
                                    SizedBox(width: 10),
                                    //dropdown have bug
                                    DropdownButton<int>(
                                        onChanged: (int? changedValue) {
                                          setState(() {
                                            _orderModifyVehicule =
                                                changedValue!;
                                            // print(
                                            //     '$_orderVehicule  $changedValue');
                                          });
                                        },
                                        value: _orderModifyVehicule,
                                        items: list_order.map((int value) {
                                          return new DropdownMenuItem<int>(
                                            value: value,
                                            child: new Text('$value'),
                                          );
                                        }).toList()),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: 400,
                                height: 50,
                                color: Colors.red,
                                child: Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.fillDrip,
                                      size: 30,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('Color',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600)),
                                    SizedBox(width: 10),
                                    Container(
                                        alignment: Alignment(-0.8, 0),
                                        width: 150,
                                        decoration: BoxDecoration(
                                            //bug color not change
                                            color: _colorVehicule,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: GestureDetector(
                                          onTap: () {
                                            pickColor(context);
                                          },
                                          child: Text(
                                            'Pick Color',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          )),
                    ),
                    Divider(
                      thickness: 5,
                    ),
                    Container(
                      width: 800,
                      height: 80,
                      color: Colors.red,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 400,
                          ),
                          Container(
                              width: 150,
                              decoration: BoxDecoration(
                                  color: Colors.yellow,
                                  borderRadius: BorderRadius.circular(10)),
                              margin: const EdgeInsets.only(
                                  right: 10, top: 20, bottom: 20),
                              child: GestureDetector(
                                onTap: () {
                                  _nomModifyVehiculeController.text = '';
                                  _numeroModifyImmatriculationVehicule.text =
                                      '';
                                  _siteModifyVehicule = 'Bordeaux';
                                  _typeModifyVehiculeController.text = '';
                                  _orderModifyVehicule = 1;
                                  _colorVehicule = Colors.red;
                                  Navigator.of(context).pop();
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Cancel',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                          Container(
                              width: 150,
                              decoration: BoxDecoration(
                                  color: Colors.yellow,
                                  borderRadius: BorderRadius.circular(10)),
                              margin: const EdgeInsets.only(
                                  right: 10, top: 20, bottom: 20),
                              child: GestureDetector(
                                onTap: () async {
                                  if (_modifyVehiculeKeyForm.currentState!
                                      .validate()) {
                                    if (_typeVehiculeController.text == '') {
                                      _typeVehiculeController.text = 'null';
                                    }
                                    await _vehicule
                                        .where('idVehicule',
                                            isEqualTo:
                                                dataVehicule['idVehicule'])
                                        .limit(1)
                                        .get()
                                        .then((QuerySnapshot querySnapshot) {
                                      querySnapshot.docs.forEach((doc) {
                                        _vehicule.doc(doc.id).update({
                                          'nomVehicule':
                                              _nomModifyVehiculeController.text,
                                          'numeroImmatriculation':
                                              _numeroModifyImmatriculationVehicule
                                                  .text,
                                          'siteVehicule': _siteModifyVehicule,
                                          'typeVehicule':
                                              _typeModifyVehiculeController.text
                                                  .toLowerCase(),
                                          'orderVehicule':
                                              _orderModifyVehicule.toString(),
                                          'colorIconVehicule': _colorVehicule
                                              .toString()
                                              .substring(6, 16),
                                        }).then((value) {
                                          _nomModifyVehiculeController.text =
                                              '';
                                          _numeroModifyImmatriculationVehicule
                                              .text = '';
                                          _typeModifyVehiculeController.text =
                                              '';
                                          _colorVehicule = Colors.red;
                                          print("Vehicule MOdified");
                                          Navigator.of(context).pop();
                                        }).catchError((error) => print(
                                            "Failed to update user: $error"));
                                      });
                                    });
                                  }
                                },
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
                                      'Save',
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
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
