// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:small_blog/data/models/blog.dart';
import 'package:small_blog/screens/blog/blogs_screen_view_model.dart';

import '../../util/common.dart';
import '../../util/validation.dart';
import '../../widgets/custom_btn.dart';
import '../../widgets/custom_progress.dart';

class AddEditPostScreen extends StatefulWidget {
  AddEditPostScreen({super.key, this.isEdit = false, this.vm, this.blog});
  static const routeName = '/add_edit_blog';
  bool isEdit;
  Blog? blog;
  BlogsScreenViewModel? vm;

  @override
  State<AddEditPostScreen> createState() => _AddEditPostScreenState();
}

class _AddEditPostScreenState extends State<AddEditPostScreen> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  var _isTitleEditedAfterSubmit = true;
  var _isBodyEditedAfterSubmit = true;

  var _isLoading = false;

  @override
  void initState() {
    if (widget.blog != null) {
      _titleController.text = widget.blog!.title;
      _bodyController.text = widget.blog!.body;
    }
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.isEdit;

    final addEditTxt = Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          Text(
            isEdit ? "Edit Blog" : "Add Blog",
            style: const TextStyle(
                color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );

    final titleTextField = Padding(
      padding: const EdgeInsets.only(top: 25),
      child: SizedBox(
        child: TextFormField(
          maxLines: 3,
          cursorColor: Colors.white,
          autocorrect: false,
          style: const TextStyle(color: Colors.white),
          decoration: Common.getInputDecoration("Title"),
          controller: _titleController,
          keyboardType: TextInputType.emailAddress,
          validator: (v) {
            return _isTitleEditedAfterSubmit
                ? null
                : Validation.notEmptyText(v);
          },
          onSaved: (value) {
            _titleController.text = value.toString();
          },
          onChanged: (value) {
            setState(() {
              _isTitleEditedAfterSubmit = true;
            });
          },
        ),
      ),
    );

    final bodyTextField = Padding(
      padding: const EdgeInsets.only(top: 25),
      child: TextFormField(
        minLines: 5,
        maxLines: 20,
        cursorColor: Colors.white,
        autocorrect: false,
        style: const TextStyle(color: Colors.white),
        decoration: Common.getInputDecoration("Description"),
        controller: _bodyController,
        keyboardType: TextInputType.text,
        validator: (v) {
          return _isBodyEditedAfterSubmit ? null : Validation.notEmptyText(v);
        },
        onSaved: (value) {
          _bodyController.text = value.toString();
        },
        onChanged: (value) {
          setState(() {
            _isBodyEditedAfterSubmit = true;
          });
        },
      ),
    );

    final addEditBtn = Padding(
      padding: const EdgeInsets.only(top: 30),
      child: CustButton(
          text: isEdit ? "Save" : "Create",
          buttonAction: () {
            submit(widget.blog);
          }),
    );

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SafeArea(
            child: InkWell(
              splashColor: Colors.black,
              highlightColor: Colors.black,
              onTap: () => Common.hideKeyboard(context),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Center(
                  child: Column(
                    children: [
                      addEditTxt,
                      titleTextField,
                      bodyTextField,
                      _isLoading ? const CustProgress() : addEditBtn,
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

  Future<void> submit(Blog? blogItem) async {
    Common.hideKeyboard(context);

    _isTitleEditedAfterSubmit = false;
    _isBodyEditedAfterSubmit = false;

    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    setState(() {
      _isLoading = true;
    });

    try {
      widget.isEdit
          ? widget.vm!.editBlog(blogItem, _titleController.text.trim(),
              _bodyController.text.trim())
          : widget.vm!.addBlog(
              _titleController.text.trim(), _bodyController.text.trim());
      setState(() {
        _isLoading = false;
      });
      Navigator.pop(context);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
