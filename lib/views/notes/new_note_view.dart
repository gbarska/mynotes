import 'package:flutter/material.dart';
import 'package:mynotes/models/database_note.dart';
import 'package:mynotes/services/crud/notes_service.dart';

import '../../services/auth/auth_service.dart';
import '../../utilities/get_it_provider.dart';

class NewNoteView extends StatefulWidget {
  const NewNoteView({super.key});

  @override
  State<NewNoteView> createState() => _NewNoteViewState();
}



class _NewNoteViewState extends State<NewNoteView> {
  DatabaseNote? _note;

  late final NotesService _notesService;
  late final AuthService _authService;

  late final TextEditingController _textController;

  @override
  void initState() {
    _authService = getIt<AuthService>();
    _notesService = NotesService();
    _textController = TextEditingController();
    super.initState();
  } 

  @override
    void dispose() {
      _deleteNoteIfTextIsEmpty();
      _saveNoteIfTextIsNotEmpty();
      _textController.dispose();
      super.dispose();
    } 

  void _textControllerListener() async {
    final note = _note;

    if (note == null) return;

    final text  = _textController.text;

    await _notesService.updateNote(
      note: note,
      text: text,
    );

    _saveNoteIfTextIsNotEmpty();
  }   

   void _setupTextControllerListener() async {
    _textController.removeListener(_textControllerListener);
    _textController.addListener(_textControllerListener);
   }

  Future<DatabaseNote> createNewNote() async {
    final existingNote = _note;

    if (existingNote != null) {
      return existingNote;
    }

    final currentUser = _authService.currentUser!;
    final email = currentUser.email!;
    final owner = await _notesService.getUser(email: email );

    return await _notesService.createNote(owner: owner);
  }

  void _deleteNoteIfTextIsEmpty(){
    final note = _note;
    if(_textController.text.isEmpty && note != null){
      _notesService.deleteNote(id: note.id);
    }
  }

   void _saveNoteIfTextIsNotEmpty() async {
    final note = _note;
    final text  = _textController.text;

    if(note != null && text.isNotEmpty){
      await _notesService.updateNote(
        note: note,
        text: text,
      );
    }
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Note'),
      ),
      body: FutureBuilder(
        future: createNewNote(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final note = snapshot.data as DatabaseNote;
             _note = note;
             _setupTextControllerListener();

              return TextField(
                keyboardType: TextInputType.multiline,
                controller: _textController,
                maxLines: null,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter your note here',
                ),
              );
              
            default:
              return const Center(
                child: CircularProgressIndicator(),
              );
          }
        },),
    );
  }
}