import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:tn09_app_web_demo/google_map/blocs/application_bloc.dart';
import 'package:tn09_app_web_demo/login_page/login_page.dart';
import 'package:tn09_app_web_demo/decoration/graphique.dart' as graphique;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ApplicationBloc(),
      child: MaterialApp(
        title: 'TN09 App Web Demo',
        theme: ThemeData(
          accentColor: Colors.green,
          primarySwatch: Colors.blue,
          colorScheme: ColorScheme.light(
              primary: Color(graphique.color['special_bureautique_2'])),
          buttonTheme:
              const ButtonThemeData(textTheme: ButtonTextTheme.primary),
        ),
        home: LoginPage(),
      ),
    );
  }
}
