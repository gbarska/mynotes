import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/utilities/show_error_dialog.dart';

import '../services/auth/auth_exceptions.dart';
import '../utilities/get_it_provider.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authService = getIt<AuthService>();
    return Scaffold(
      appBar: AppBar(title: const Text('Register'), ),
      body: Column(
                      children: [
                        TextField(controller: _email,  enableSuggestions: false, autocorrect: false, keyboardType: TextInputType.emailAddress, decoration: const InputDecoration(hintText: 'Enter your email here'),),
                        TextField(controller: _password, obscureText: true, enableSuggestions: false, autocorrect: false, decoration: const InputDecoration(hintText: 'Enter your password here'),),
                        TextButton(onPressed:() async {
                          final email = _email.text;
                          final password = _password.text;
    
                          try {
                            await authService.createUser(email: email, password: password);
                            final user = authService.currentUser;
                            authService.sendEmailVerification();
                            Navigator.of(context).pushNamed(verifyEmailRoute);       
                          } on WeakPasswordAuthException catch (e) {
                                await showErrorDialog(
                                context,
                                'The password provided is too weak.'
                               );
                          } on EmailAlreadyInUseAuthException catch (e) {
                                 await showErrorDialog(
                                context,
                                'There is already an account with that email.');
                          } on InvalidEmailAuthException {
                                await showErrorDialog(
                                context,
                                'This is an invalid email address.');
                          } on GenericAuthException {
                              await showErrorDialog(context, 'An error occured. Please try again later.');
                          }
    
                        }, child: const Text('Register')),
                        TextButton(onPressed:  () {  
                           Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, (route) => false);                        
                        }, child: const Text('Already registered? Login here'))
                      ],
                    ),
    
    );
  }
}