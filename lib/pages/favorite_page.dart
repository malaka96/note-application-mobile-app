import 'package:flutter/material.dart';
import 'package:note_application_mobile_app/models/note.dart';
import 'package:note_application_mobile_app/services/api_services.dart';
import 'package:note_application_mobile_app/widgets/bottom_sheet_body.dart';
import 'package:note_application_mobile_app/widgets/note_card.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  Future<void> _deleteNote(int noteId) async {
    try {
      await ApiServices().deleteNote(noteId);
      if (!mounted) return;
      Navigator.of(context).pop();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Note deleted')));
      setState(() {});
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Error in deleting note")));
    }
  }

  void showBottomSheet(Note note) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return BottomSheetBody(
          note: note,
          onNoteUpdated: () {
            Navigator.of(context).pop();
            setState(() {});
          },
        );
      },
    );
  }

  Future<void> _toggleFavorite(Note note) async {
    try {
      await ApiServices().updateNote(
        Note(
          id: note.id,
          title: note.title,
          body: note.body,
          isFavorite: !note.isFavorite,
        ),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Toggled favorite")));
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to toggle favorite")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Favorites",style: TextStyle(fontWeight: FontWeight.bold))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
          future: ApiServices().fetchFavoritesNotes(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text("Error fetching notes"));
            } else if (!snapshot.hasData) {
              return const Center(child: Text("No any notes avaliable"));
            } else {
              final notes = snapshot.data!;
              return ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final note = notes[index];
                  // if (!note.isFavorite) {
                  //   return const SizedBox.shrink();
                  // }
                  return NoteCard(
                    id: note.id,
                    title: note.title,
                    body: note.body,
                    isFavorite: note.isFavorite,
                    delete: () {
                      _deleteNote(note.id);
                    },
                    toggleFavorite: () {
                      _toggleFavorite(note);
                    },
                    showBottomSheet: () {
                      showBottomSheet(note);
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
