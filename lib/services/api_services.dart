import 'dart:convert';

import 'package:note_application_mobile_app/models/note.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  Future<List<Note>> fetchAllNotes() async {
    final response = await http.get(Uri.parse("http://localhost:8080/"));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);

      return jsonData.map((item) {
        return Note.fromJson(item);
      }).toList();
    } else {
      throw Exception("Failed to fetch all notes");
    }
  }

  Future<List<Note>> fetchFavoritesNotes() async {
    final response = await http.get(Uri.parse("http://localhost:8080/"));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);

      return jsonData
          .map((item) => Note.fromJson(item))
          .where((note) => note.isFavorite)
          .toList();
    } else {
      throw Exception("Failed to fetch all notes");
    }
  }

  Future<void> deleteNote(int id) async {
    final response = await http.delete(
      Uri.parse("http://localhost:8080/delete/$id"),
      headers: {'Accept': 'application/json'},
    );
    if (response.statusCode == 200 || response.statusCode == 204) {
      //
    } else {
      throw Exception("Failed to delete Note");
    }
  }

  Future<void> createNote(String title, String body) async {
    try {
      final response = await http.post(
        Uri.parse("http://localhost:8080/add"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(
          Note(id: 0, title: title, body: body, isFavorite: false).toJson(),
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        // If server returns the created note with real id
      } else {
        throw Exception(
          'Failed to create note • Status: ${response.statusCode}\n${response.body}',
        );
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> updateNote(Note note) async {
    try {
      final response = await http.put(
        Uri.parse("http://localhost:8080/update"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(note.toJson()),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        // If server returns the created note with real id
      } else {
        throw Exception(
          'Failed to update note • Status: ${response.statusCode}\n${response.body}',
        );
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
