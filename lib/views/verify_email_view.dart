
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Email'),
      ),
      body:  Column(
          children: [
            const Text("We've sent you an email with a link to verify your account. "),
            const Text('If you haven\'t received an email yet, press the button below to send it again.'),
            TextButton(onPressed: () {
             final user = FirebaseAuth.instance.currentUser;
              user?.sendEmailVerification();
            }, child: const Text('Send Verification Email')),
             TextButton(onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, (route) => false);
            }, child: const Text('Go to Login')),
          ],
        ),
    );
  }
}