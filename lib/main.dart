import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:galaxy_ray_v2/controllers/google_sheet_api.dart';
import 'firebase_options.dart';
import 'models/auth_page.dart';
import 'package:dcdg/dcdg.dart';


void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  GoogleSheetApi().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthPage(),
      );
  }

}

