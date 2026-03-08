import 'package:dio/dio.dart';
import 'package:note_application_mobile_app/models/note.dart';
import 'package:http/http.dart' as http;
import 'package:note_application_mobile_app/services/secure_storage_service.dart';

class ApiServices {
  final Dio dio = Dio(BaseOptions(baseUrl: "http://10.0.2.2:8080"));

  ApiServices() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await SecureStorageService().getToken();
          if (token != null) {
            options.headers["Authorization"] = "Bearer $token";
          }
          return handler.next(options);
        },
      ),
    );
  }

  Future<List<Note>> fetchAllNotes() async {
    // final response = await http.get(Uri.parse("http://10.0.2.2:8080/"));

    // if (response.statusCode == 200) {
    //   final List<dynamic> jsonData = json.decode(response.body);

    //   return jsonData.map((item) {
    //     return Note.fromJson(item);
    //   }).toList();
    // } else {
    //   throw Exception("Failed to fetch all notes");
    // }

    // try {
    final response = await dio.get("/note/all");
    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;

      return data.map((item) {
        return Note.fromJson(item);
      }).toList();
    } else {
      throw Exception("Failed to fetch all notes");
    }
    // } on DioException {
    //   rethrow;
    // }
  }

  Future<void> registerUser(String email, String password) async {
    try {
      await dio.post(
        "/user/register",
        data: {"email": email, "password": password},
      );
    } on DioException {
      rethrow;
    }
  }

  Future<List<Note>> fetchFavoritesNotes() async {
    final response = await dio.get("/note/all/favorite");
    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;

      return data.map((item) => Note.fromJson(item)).toList();
    } else {
      throw Exception("Failed to fetch favorite notes");
    }
  }

  Future<void> updateNoteFavoriteState(int id, bool newState) async {
    try {
      await dio.put(
        "/note/update/favorite",
        queryParameters: {"id": id, "isFavorite": newState},
      );
    } on DioException {
      rethrow;
    }
  }

  Future<void> deleteNote(int id) async {
    final response = await http.delete(
      Uri.parse("http://10.0.2.2:8080/delete/$id"),
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
      final response = await dio.post(
        "/note/add",
        data: {"title": title, "body": body},
      );

      if (response.statusCode == 201) {
        //
      } else {
        throw Exception("Cannnot create note");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> updateNote(Note note) async {
    try {
      final response = await dio.put(
        "/note/update",
        data: {
          "title": note.title,
          "body": note.body,
          "isFavorite": note.isFavorite,
        },
        queryParameters: {"id": note.id},
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        // If server returns the created note with real id
      } else {
        throw Exception('Failed to update note');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
