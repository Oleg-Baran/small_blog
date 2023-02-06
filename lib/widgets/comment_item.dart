// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:small_blog/screens/posts/comments_view_model.dart';

import '../data/models/comment.dart';

class CommentItem extends StatelessWidget {
  CommentItem({super.key, required this.commentItem});

  Comment commentItem;

  @override
  Widget build(BuildContext context) {
    CommentsViewModel cVM = CommentsViewModel();
    final deleteIcon = Container(
      padding: const EdgeInsets.only(right: 25),
      alignment: Alignment.centerRight,
      child: const Icon(
        Icons.delete_sweep_outlined,
        size: 40,
        color: Colors.red,
      ),
    );

    final userTxt = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        commentItem.email,
        //blogItem.body,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
        textAlign: TextAlign.start,
      ),
    );

    final bodyTxt = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        commentItem.comment,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.start,
      ),
    );

    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      background: deleteIcon,
      onDismissed: ((direction) => cVM.deleteComment(commentItem)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: const Color.fromARGB(240, 255, 255, 255),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  userTxt,
                  const Divider(color: Colors.black),
                  bodyTxt,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
