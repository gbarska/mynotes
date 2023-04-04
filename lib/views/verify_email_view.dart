import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_service.dart';

import '../utilities/get_it_provider.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    final authService = getIt<AuthService>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Email'),
      ),
      body:  Column(
          children: [
            const Text("We've sent you an email with a link to verify your account. "),
            const Text('If you haven\'t received an email yet, press the button below to send it again.'),
            TextButton(onPressed: () {
             authService.sendEmailVerification();
            }, child: const Text('Send new Verification Email')),
             TextButton(onPressed: () async {
                await authService.logOut();
                Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, (route) => false);
            }, child: const Text('Back to Login')),
          ],
        ),
    );
  }
}