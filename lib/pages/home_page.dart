import 'package:flutter/material.dart';
import 'package:note_application_mobile_app/services/api_services.dart';
import 'package:note_application_mobile_app/widgets/note_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Page")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
          future: ApiServices().fetchAllNotes(),
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
                  return NoteCard(title: note.title, body: note.body);
                },
              );
            }
          },
        ),
      ),
    );
  }
}
