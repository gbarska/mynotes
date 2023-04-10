import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_exceptions.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import '../utilities/dialogs/error_dialog.dart';
import '../utilities/get_it_provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
      appBar: AppBar(title: const Text('Login'), ),
      body: Column(
                      children: [
                        TextField(controller: _email,  enableSuggestions: false, autocorrect: false, keyboardType: TextInputType.emailAddress, decoration: const InputDecoration(hintText: 'Enter your email here'),),
                        TextField(controller: _password, obscureText: true, enableSuggestions: false, autocorrect: false, decoration: const InputDecoration(hintText: 'Enter your password here'),),
                        TextButton(onPressed:() async {
                          final email = _email.text;
                          final password = _password.text;
    
                          try {

                             await authService.logIn(email: email, password: password);

                             final user = authService.currentUser;
                              
                              if(user != null){
                                if(user?.isEmailVerified ?? false){
                                    Navigator.of(context).pushNamedAndRemoveUntil(notesRoute, (route) => false);
                                } else {
                                    await authService.sendEmailVerification();
                                    Navigator.of(context).pushNamedAndRemoveUntil(verifyEmailRoute, (route) => false);
                                }
                              } else {
                                await showErrorDialog(context, 'Authentication failed, please try again later.');
                              }

                          } on WrongCredentialsAuthException catch (e) {
                             await showErrorDialog(context, 'Invalid email or password');
                          } on GenericAuthException catch (e) {
                             await showErrorDialog(context, 'Authentication failed');
                          } 
    
                        }, child: const Text('Login')),
                        TextButton(onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(registerRoute, (route) => false);
                        }, child: const Text('Not registered? Register here!')),
                      ],
                    ),
    );
  }
}

