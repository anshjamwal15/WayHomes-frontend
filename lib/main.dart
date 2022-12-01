import 'package:dumper/Screens/Welcome/splash_screen.dart';
import 'package:dumper/constants/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

const SERVER_IP = 'http://192.168.1.6:8080';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Way Homes',
      theme: ThemeData(
          primaryColor: kPrimaryColor, scaffoldBackgroundColor: Colors.white),
      home: const SplashScreen(),
    );
  }
}
