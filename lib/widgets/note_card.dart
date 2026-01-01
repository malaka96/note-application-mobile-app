import 'package:flutter/material.dart';
import 'package:note_application_mobile_app/models/note.dart';
import 'package:note_application_mobile_app/widgets/bottom_sheet_body.dart';

class NoteCard extends StatelessWidget {
  final int id;
  final String title;
  final String body;
  final bool isFavorite;
  final void Function() delete;
  const NoteCard({
    super.key,
    required this.id,
    required this.title,
    required this.body,
    required this.isFavorite,
    required this.delete,
  });

  void _deleteNote(BuildContext context, int noteId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Confirm Delete"),
          content: const Text("Are you sure you want to delete this note?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                delete();
              },
              child: const Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return BottomSheetBody(
          note: Note(
            id: id,
            title: title,
            body: body,
            isFavorite: isFavorite,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: GestureDetector(
        onTap: () => _showBottomSheet(context),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.favorite, color: Colors.grey),
                        ),
                        IconButton(
                          onPressed: () => _deleteNote(context, id),
                          icon: Icon(Icons.delete, color: Colors.red),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                const Divider(),
                const SizedBox(height: 2),
                Text(body),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
