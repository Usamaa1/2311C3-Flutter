import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginsignup/Login.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    validateUser() async {
      try {
        final user = FirebaseAuth.instance.currentUser;

        if (user == null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Login()),
          );
        }
      } catch (e) {
        print(e);
      }
    }

    validateUser();

    return Scaffold(
      body: Center(child: Text("Home Screen", style: TextStyle(fontSize: 24))),
    );
  }
}
