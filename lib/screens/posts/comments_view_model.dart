import 'package:flutter/material.dart';
import 'package:small_blog/data/models/comment.dart';

class CommentsViewModel with ChangeNotifier {
  List<Comment> commentsList = [
    Comment('1', 'ran@mail.com', 'TestComment'),
    Comment('2', 'random@mail.com', 'Test222Comment')
  ];

  List<Comment> commentForBlog(String postId) {
    List<Comment> validComment = [];
    for (var el in commentsList) {
      if (el.postId.trim() == postId.trim()) {
        validComment.add(el);
      }
    }
    return validComment;
  }

  void addComment(String postId, String email, String comment) {
    commentsList.insert(0, Comment(postId, email, comment));
    notifyListeners();
  }

  void deleteComment(Comment comment) {
    commentsList.remove(comment);
    debugPrint(commentsList.toString());
    notifyListeners();
  }
}
