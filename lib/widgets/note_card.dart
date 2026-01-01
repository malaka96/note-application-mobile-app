import 'package:flutter/material.dart';

class NoteCard extends StatefulWidget {
  final int id;
  final String title;
  final String body;
  final bool isFavorite;
  final void Function() delete;
  final void Function() toggleFavorite;
  final void Function() showBottomSheet;
  const NoteCard({
    super.key,
    required this.id,
    required this.title,
    required this.body,
    required this.isFavorite,
    required this.delete,
    required this.toggleFavorite,
    required this.showBottomSheet,
  });

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
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
                widget.delete();
              },
              child: const Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  late bool currentFavoriteState;

  @override
  void initState() {
    currentFavoriteState = widget.isFavorite;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: GestureDetector(
        onTap: widget.showBottomSheet,
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
                      widget.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            widget.toggleFavorite();
                            setState(() {
                              currentFavoriteState = !currentFavoriteState;
                            });
                          },
                          icon: Icon(
                            Icons.favorite,
                            color: currentFavoriteState
                                ? Colors.black
                                : Colors.grey,
                          ),
                        ),
                        IconButton(
                          onPressed: () => _deleteNote(context, widget.id),
                          icon: Icon(Icons.delete, color: Colors.red),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                const Divider(),
                const SizedBox(height: 2),
                Text(widget.body),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
