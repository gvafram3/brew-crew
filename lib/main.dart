import 'package:brew_crew/firebase_options.dart';
import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/screens/wrapper.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<CustomUser?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        theme: ThemeData(primaryColor: Colors.brown),
        debugShowCheckedModeBanner: false,
        title: 'The Brew Crew',
        home: Wrapper(),
      ),
    );
  }
}
