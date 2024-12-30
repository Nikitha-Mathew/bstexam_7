import 'package:bstexam_7/firebaseauth.dart';
import 'package:bstexam_7/home.dart';
import 'package:bstexam_7/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDt4jwwxugAKI_JUdBcTXtXov7mqiDLQQM",
          appId: "1:936563371123:android:ae3b9d8964fe571af14e06",
          messagingSenderId: "",
          projectId: "bstexam2"));

  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  final email = TextEditingController();
  final pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.deepPurple.shade400,
                  Colors.deepPurple.shade800
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.deepPurple.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 15,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedContainer(
                  duration: Duration(seconds: 1),
                  curve: Curves.bounceOut,
                  child: const Icon(
                    Icons.person_add,
                    size: 80,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Create Your Account",
                  style: GoogleFonts.bodoniModa(
                    textStyle: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: email,
                    decoration: const InputDecoration(
                      hintText: "Enter your email",
                      prefixIcon: Icon(Icons.email, color: Colors.deepPurple),
                      border: InputBorder.none,
                    ),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: pass,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: "Enter your password",
                      prefixIcon: Icon(Icons.lock, color: Colors.deepPurple),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Register Button
                ElevatedButton(
                  onPressed: () {
                    String emaill = email.text.trim();
                    String password = pass.text.trim();

                    FireBaseFunctions()
                        .registerUser(email: emaill, pwd: password)
                        .then((response) {
                      if (response == null) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => SchoolApp()));
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(response)));
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple.shade900,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 60, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text("Register", style: TextStyle(fontSize: 18)),
                ),
                const SizedBox(height: 20),

                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Fire_Login()));
                  },
                  child: RichText(
                    text: const TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(color: Colors.white70),
                      children: [
                        TextSpan(
                          text: "Login Here",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
