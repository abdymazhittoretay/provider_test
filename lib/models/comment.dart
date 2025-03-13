import 'dart:convert';

List<Comment> commentFromJson(String str) =>
    List<Comment>.from(json.decode(str).map((x) => Comment.fromJson(x)));

String commentToJson(List<Comment> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Comment {
  String email;
  String body;

  Comment({required this.email, required this.body});

  factory Comment.fromJson(Map<String, dynamic> json) =>
      Comment(email: json["email"], body: json["body"]);

  Map<String, dynamic> toJson() => {"email": email, "body": body};
}
