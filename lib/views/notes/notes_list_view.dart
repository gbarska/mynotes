
import 'package:flutter/material.dart';
import '../../models/database_note.dart';
import '../../utilities/dialogs/delete_dialog.dart';

typedef DeleteNoteCallback = void Function(DatabaseNote note);

class NotesListView extends StatelessWidget {
  final List<DatabaseNote> notes;
  final DeleteNoteCallback onDeleteNote;

  const NotesListView({super.key, required this.notes, required this.onDeleteNote});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
                            itemCount: notes.length,
                            itemBuilder: (context, index) {
                              final note = notes[index];
                              return ListTile(
                                title: Text(
                                    note.text,
                                    maxLines: 1,
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () async {
                                    final shouldDelete = await showDeleteDialog(context);
                                    
                                    if(shouldDelete) {
                                      onDeleteNote(note);
                                    }
                                  },
                                ),
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    'noteRoute',
                                    arguments: note,
                                  );
                                },
                              );
                            },
                          );  
  }

}