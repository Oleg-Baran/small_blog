// ignore_for_file: file_names
import 'dart:convert';

import 'package:small_blog/data/models/blog.dart';
import 'package:http/http.dart' as http;

class DataResponse {
  Future<List<Blog>> fetchData() async {
    var url = Uri.parse('https://blog-api-t6u0.onrender.com/posts');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      List<Blog> blogList =
          jsonResponse.map((data) => Blog.fromJson(data)).toList();
      return blogList;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }
}
