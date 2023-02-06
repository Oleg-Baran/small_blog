import 'package:flutter/material.dart';
import 'package:small_blog/screens/posts/comments_view_model.dart';

import '../../data/models/blog.dart';
import '../../util/common.dart';
import '../../util/validation.dart';
import '../../widgets/comment_item.dart';

// ignore: must_be_immutable
class PostCommentScreen extends StatefulWidget {
  PostCommentScreen({super.key, this.blogItem, this.cVM});
  static const routeName = '/comments';

  Blog? blogItem;
  CommentsViewModel? cVM;
  @override
  State<PostCommentScreen> createState() => _PostCommentScreenState();
}

class _PostCommentScreenState extends State<PostCommentScreen> {
  final _formKey = GlobalKey<FormState>();

  final _commentController = TextEditingController();
  bool _isCommentEditedAfterSubmit = true;

  @override
  Widget build(BuildContext context) {
    final commentTxt = Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          const Text(
            "Comments",
            style: TextStyle(
                color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );

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
      child: Text(
        widget.blogItem!.title,
        maxLines: 3,
        overflow: TextOverflow.fade,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
      ),
    );

    final bodyTxt = Container(
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      child: Text(
        widget.blogItem!.body,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.start,
      ),
    );

    final sendCommentSection = Row(
      children: [
        // Add comment TextField
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width - 65,
            child: TextFormField(
              cursorColor: Colors.white,
              autocorrect: false,
              style: const TextStyle(color: Colors.white),
              decoration: Common.getInputDecoration('Add comment'),
              controller: _commentController,
              keyboardType: TextInputType.emailAddress,
              validator: (v) {
                return _isCommentEditedAfterSubmit
                    ? null
                    : Validation.notEmptyText(v);
              },
              onSaved: (value) {
                _commentController.text = value.toString();
              },
              onChanged: (value) {
                setState(() {
                  _isCommentEditedAfterSubmit = true;
                });
              },
            ),
          ),
        ),
        // Send Button
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: IconButton(
              onPressed: () {
                _isCommentEditedAfterSubmit = false;
                if (!_formKey.currentState!.validate()) {
                  return;
                }
                _formKey.currentState!.save();
                widget.cVM!.addComment(widget.blogItem!.id.toString(),
                    "User Name", _commentController.text.trim());
                debugPrint(widget.cVM!.commentsList.toString());
              },
              icon: const Icon(
                Icons.send,
                color: Colors.white,
                size: 34,
              )),
        )
      ],
    );

    const divider = Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Divider(thickness: 2, color: Colors.white),
    );

    SizedBox commentsListView() {
      return SizedBox(
        height: 470,
        child: ListView.builder(
          padding: const EdgeInsets.all(4),
          itemCount:
              widget.cVM!.commentForBlog(widget.blogItem!.id.toString()).length,
          itemBuilder: (BuildContext context, int index) {
            return CommentItem(
              commentItem: widget.cVM!
                  .commentForBlog(widget.blogItem!.id.toString())[index],
            );
          },
        ),
      );
    }

    ;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SafeArea(
            child: InkWell(
              splashColor: Colors.black,
              highlightColor: Colors.black,
              onTap: () => Common.hideKeyboard(context),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Center(
                  child: Column(
                    children: [
                      commentTxt,
                      titleTxt,
                      bodyTxt,
                      sendCommentSection,
                      divider,
                      commentsListView()
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
