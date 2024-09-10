import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_wall/components/my_button.dart';
import 'package:social_wall/components/my_textfield.dart';

import '../helper/helper_functions.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Text controller
  final TextEditingController usernameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  // Register user
  void registerUser() async {
    final currentContext = context;
    // Show loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // Check the password and confirm password match
    if (passwordController.text != confirmPasswordController.text) {
      Navigator.pop(context);

      // Show error message to user
      showErrorMessageToUser("Passwords don't match!", context);
    } else {
      // Try to create user
      try {
        // Create the user
        UserCredential? userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);

        // Create a user document and add to firestore
        createUserDocument(userCredential);

        if (currentContext.mounted) Navigator.pop(currentContext);
      } on FirebaseAuthException catch (e) {
        // Por the circle progress indicator
        if (currentContext.mounted) Navigator.pop(currentContext);

        // Display error message to user
        if (currentContext.mounted) {
          showErrorMessageToUser(e.code, currentContext);
        }
      }
    }
  }

  // Create a user document and collect them in firestore
  Future<void> createUserDocument(UserCredential? userCredential) async {
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.email)
          .set(
        {
          'email': userCredential.user!.email,
          'username': usernameController.text
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Icon(
                Icons.person,
                size: 80,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),

              const SizedBox(
                height: 25,
              ),

              // App name
              const Text(
                "S O C I A L  W A L L",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),

              const SizedBox(
                height: 50,
              ),

              // Email text field
              MyTextField(
                hintText: "Username",
                obscureText: false,
                controller: usernameController,
              ),

              const SizedBox(
                height: 10,
              ),

              // Email text field
              MyTextField(
                hintText: "Email",
                obscureText: false,
                controller: emailController,
              ),

              const SizedBox(
                height: 10,
              ),

              // Password text field
              MyTextField(
                hintText: "Password",
                obscureText: true,
                controller: passwordController,
              ),

              const SizedBox(
                height: 10,
              ),

              MyTextField(
                hintText: "Confirm Password",
                obscureText: true,
                controller: confirmPasswordController,
              ),

              const SizedBox(
                height: 10,
              ),

              // Forgot password
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Forgot Password",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 10,
              ),

              // Register button
              MyButton(text: "Register", onTap: registerUser),

              const SizedBox(
                height: 10,
              ),

              // Don't have an account? Register here
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? "),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      "Login Here!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
