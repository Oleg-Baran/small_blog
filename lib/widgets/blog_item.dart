// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:small_blog/screens/blog/blogs_screen_view_model.dart';
import 'package:small_blog/screens/posts/comments_view_model.dart';
import 'package:small_blog/screens/posts/post_comment_screen.dart';

import '../data/models/blog.dart';

class BlogItem extends StatelessWidget {
  BlogItem({
    super.key,
    required this.blogItem,
    required this.vm,
    required this.commentsVM
  });

  Blog blogItem;
  BlogsScreenViewModel vm;
  CommentsViewModel commentsVM;

  @override
  Widget build(BuildContext context) {
    // Title & UpdateBtn
    final titleTxt = Container(
      padding: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      // Title Text
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width - 75,
            child: Text(
              blogItem.title,
              maxLines: 3,
              overflow: TextOverflow.fade,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          // UpdateBtn
          InkWell(
            onTap: () =>
                vm.addEditBlog(context, true, blogItem: blogItem, vm: vm),
            child: const Icon(
              Icons.border_color_rounded,
              color: Colors.black,
            ),
          )
        ],
      ),
    );

    final bodyTxt = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        blogItem.body,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.start,
      ),
    );

    final commentBtn = Row(
      children: [
        IconButton(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => PostCommentScreen(
                blogItem: blogItem,
                cVM: commentsVM
              ),
            ),
          ),
          icon: const Icon(Icons.message_outlined),
        ),
        Text(commentsVM.commentForBlog(blogItem.id.toString()).length.toString())
      ],
    );

    final deleteIcon = Container(
      padding: const EdgeInsets.only(right: 25),
      alignment: Alignment.centerRight,
      child: const Icon(
        Icons.delete_sweep_outlined,
        size: 40,
        color: Colors.red,
      ),
    );

    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      background: deleteIcon,
      onDismissed: ((direction) => vm.blogsList.remove(blogItem)),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: const Color.fromARGB(225, 255, 255, 255),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  titleTxt,
                  bodyTxt,
                  const Divider(color: Colors.black),
                  commentBtn,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
