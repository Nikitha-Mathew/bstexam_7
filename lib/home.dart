import 'package:bstexam_7/admissionform.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts

void main() {
  runApp(SchoolApp());
}

class SchoolApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bright Future School',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDE7F6), // Light purple background
      appBar: AppBar(
        title: Text('Bright Future School',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Color(0xFF6A1B9A), // Purple color for AppBar
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gradient Text with Google Fonts
            Center(
              child: ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [Colors.purple, Colors.pink, Colors.blue],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds),
                child: Text(
                  'Welcome to Bright Future!',
                  style: GoogleFonts.dancingScript(
                    // Use a Google font here
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            // School Info Section
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.school,
                    size: 80,
                    color: Color(0xFF6A1B9A), // Purple color for icon
                  ),
                  SizedBox(height: 10),
                  Text(
                    'A place of learning and excellence',
                    style: GoogleFonts.roboto(
                      // Use another Google font here
                      fontSize: 20,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            // Button to fill the admission form
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Navigation to Admission Form page (you can implement a new page for this)
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AdmissionFormScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Color(0xFF6A1B9A), // Purple color for the button
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Fill Admission Form',
                  style: GoogleFonts.roboto(
                    // Apply Google font for button text
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            // School Footer with contact info
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  Divider(color: Colors.black45),
                  SizedBox(height: 10),
                  Text(
                    'Contact us: info@brightfutureschool.com',
                    style: GoogleFonts.roboto(
                      // Apply Google font for footer text
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
