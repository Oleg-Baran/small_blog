// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class Blog extends Equatable {
  Blog({
    required this.id,
    required this.title,
    required this.body,
  });

  dynamic id;
  String title;
  String body;

  factory Blog.fromJson(Map<String, dynamic> json) => Blog(
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "body": body,
      };

  @override
  List<Object?> get props => [id, title, body];
}
