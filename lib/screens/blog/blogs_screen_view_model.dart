import 'package:flutter/material.dart';

import 'package:small_blog/screens/posts/add_or_edit_post.dart';

import '../../data/models/blog.dart';
import '../../services/getDataFromApi.dart';

class BlogsScreenViewModel with ChangeNotifier {
  List<Blog> blogsList = [];

  Future<void> fetchDataFromAPI() async {
    final response = await DataResponse().fetchData();
    blogsList.addAll(response);
    notifyListeners();
  }

  void addBlog(String title, String body) {
    blogsList.insert(0, Blog(id: UniqueKey(), title: title, body: body));
    notifyListeners();
  }

  void editBlog(Blog? blogItem, String title, String body) {
    blogItem!.title = title;
    blogItem.body = body;
    notifyListeners();
  }

  void addEditBlog(BuildContext ctx, bool isEdit,
      {Blog? blogItem, BlogsScreenViewModel? vm}) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (ctx) => AddEditPostScreen(
          isEdit: isEdit,
          blog: blogItem,
          vm: vm,
        ),
      ),
    );
  }
}
