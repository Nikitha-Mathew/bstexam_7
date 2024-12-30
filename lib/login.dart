
import 'package:bstexam_7/firebaseauth.dart';
import 'package:bstexam_7/home.dart';
import 'package:bstexam_7/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Fire_Login extends StatelessWidget {
  final email = TextEditingController();
  final pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("Welcome Here",
            style: GoogleFonts.cookie(color: Colors.white, fontSize: 40)),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.lock_outline,
                  size: 80,
                  color: Colors.deepPurple,
                ),
                SizedBox(height: 20),
                Text("Login to Your Account",
                    style: GoogleFonts.zeyada(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        color: Colors.deepPurple)),
                SizedBox(height: 30),
                // Email TextField
                TextField(
                  controller: email,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Enter your email",
                    prefixIcon:
                        const Icon(Icons.email, color: Colors.deepPurple),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: pass,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Enter your password",
                    prefixIcon:
                        const Icon(Icons.lock, color: Colors.deepPurple),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                ElevatedButton(
                  onPressed: () {
                    FireBaseFunctions()
                        .loginUser(
                            emaill: email.text.trim(), pwd: pass.text.trim())
                        .then((response) {
                      if (response == null) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => SchoolApp()));
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child:
                      const Text("Login Here", style: TextStyle(fontSize: 16)),
                ),
                SizedBox(height: 15),

                TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => MyApp()));
                  },
                  child: RichText(
                    text: TextSpan(
                      text: "Not a user? ",
                      style: TextStyle(color: Colors.deepPurple.shade700),
                      children: const [
                        TextSpan(
                          text: "Register Here!",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
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