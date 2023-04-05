import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/utilities/get_it_provider.dart';
import 'package:mynotes/views/login_view.dart';
import 'package:mynotes/views/notes/new_note_view.dart';
import 'package:mynotes/views/notes/notes_view.dart';
import 'package:mynotes/views/register_view.dart';
import 'package:mynotes/views/verify_email_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //DI
  getIt.registerSingleton<AuthService>(AuthService.instance());

  runApp( 
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const HomePage(),
      routes: {
        loginRoute: (context) => const LoginView(),
        verifyEmailRoute: (context) => const VerifyEmailView(),
        registerRoute: (context) => const RegisterView(),
        notesRoute: (context) => const NotesView(),
        newNoteRoute: (context) => const NewNoteView(),
      },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage ({super.key});
  
  @override
  Widget build(BuildContext context) {
    final authService = getIt<AuthService>();

    return FutureBuilder(
            future: authService.initialize(),  
            builder: (context, snapshot) {
              switch(snapshot.connectionState) {
                 case ConnectionState.done:
                      final user = authService.currentUser; 

                      if(user != null) {
                          if(user.isEmailVerified){
                              return const NotesView();
                          } else {
                              return const VerifyEmailView();
                          }
                      } else {
                          return const LoginView();
                      }
                
                default:
                  return const Center(child: CircularProgressIndicator());
              }
            },
      );
  }
}
