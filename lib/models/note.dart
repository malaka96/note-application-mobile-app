class Note {
  int id;
  String title;
  String body;
  bool isFavorite;

  Note({required this.id, required this.title, required this.body, required this.isFavorite});

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(id: json["id"], title: json["title"], body: json["body"], isFavorite: json["favorite"]);
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "title": title, "body": body, "isFavorite": isFavorite};
  }
}
