import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../views/home_page.dart';
import '../views/login_page.dart';

class AuthPage extends StatelessWidget{
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          //user is Logged In
          if (snapshot.hasData){
            return HomePage();
          }

          //user is not Logged In
          else {
            return LoginPage();
          }
        },
      ),
    );
  }

}