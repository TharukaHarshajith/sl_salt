import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sl_salt/routes/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthState();
  }

  Future<void> _checkAuthState() async {
    try {
      await Future.delayed(const Duration(seconds: 5)); // Simulate loading delay
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Navigate to Home Page if user is authenticated
        Navigator.pushReplacementNamed(context, RouteNames.login);
      } else {
        // Navigate to Login Page if user is not authenticated
        Navigator.pushReplacementNamed(context, RouteNames.login);
      }
    } catch (e) {
      // Show error message if Firebase connection fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 146, 213, 245), // Set the background color to light blue
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Sri Lanka Salt Logo
            Image(
              image: AssetImage('assets/images/srilanka_salt_logo.png'),
              width: 400, // Adjust width as needed
              height: 400, // Adjust height as needed
            ),
            SizedBox(height: 20), // Add spacing below the logo
            CircularProgressIndicator(color: Colors.blue), // Loading indicator
          ],
        ),
      ),
    );
  }
}
