import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '/pages/loading_screen.dart'; // Import LoadingScreen

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String rfidNumber = "Tap CEC card / Pitt Card"; // Default text for the tile

  void generateRFID() {
    final random = Random();

    // Generate RFID number
    setState(() {
      rfidNumber = (random.nextInt(999999) + 100000).toString(); // Generate a 6-digit random number
    });

    // Reset RFID number after 5 seconds
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        rfidNumber = "Tap CEC card / Pitt Card";
      });
    });

    // Navigate to LoadingScreen after a delay
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoadingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(179, 244, 209, 187),
      body: SafeArea(
        child: Center( // Center everything
          child: Column(
            mainAxisSize: MainAxisSize.min, // Center the column content vertically
            children: [
              // Logo
              ClipOval(
                child: Image.asset(
                  '/Users/jeeevantsingh/Documents/event/lib/image/Unknown.png',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 30), // Space between the image and the button

              // RFID reading tile
              GestureDetector(
                onTap: generateRFID, // Call generateRFID on click
                child: Container(
                  width: 250,
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 14, 39, 130),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      rfidNumber, // Display the RFID number or default text
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}