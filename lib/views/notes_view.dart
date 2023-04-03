
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'dart:developer' as devtools show log;

enum MenuAction {
  logout,
}

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Main UI'),
          actions: [
            PopupMenuButton<MenuAction>(
              onSelected: (value) async {
                  devtools.log('Selected $value');
                  switch(value) {
                    case MenuAction.logout:
                     final shouldLogout = await showLogOutDialog(context);

                      if(shouldLogout){
                        await FirebaseAuth.instance.signOut();
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          '/login',
                         (_) => false);
                      }

                     break;
                  }
              }, itemBuilder: (context) {
                return [
                  const PopupMenuItem<MenuAction>(
                    value: MenuAction.logout,
                    child: Text('Sign out'),
                  )
                ];
              },
            )
          ],
          ),
          body: const Text('Hello World'),
        );
  }
}

Future<bool> showLogOutDialog(BuildContext context) async {
 return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Sign out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(onPressed: () { Navigator.of(context).pop(false); }, child: const Text('Cancel')),
          TextButton(onPressed: () { Navigator.of(context).pop(true); }, child: const Text('Yes'),
          ),
        ],
      );
    },
  ).then((value) => value ?? false);
}