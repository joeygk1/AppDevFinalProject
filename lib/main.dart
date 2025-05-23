import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyB0RTL6LarpRaKsSd-vyeM28ggjqAbO0AA",
          appId: "528531621935",
          messagingSenderId: "528531621935",
          projectId: "appdevproject-9f5d9"
      )
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magic Sole',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: SplashScreen(),
    );
  }
}
