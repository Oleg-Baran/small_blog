import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:small_blog/screens/posts/comments_view_model.dart';

import 'package:small_blog/services/firebase_auth_service.dart';
import 'package:small_blog/widgets/custom_progress.dart';

import '../../widgets/blog_item.dart';
import 'blogs_screen_view_model.dart';

class BlogsScreen extends StatefulWidget {
  const BlogsScreen({super.key});
  static const routeName = '/blogs';

  @override
  State<BlogsScreen> createState() => _BlogsScreenState();
}

class _BlogsScreenState extends State<BlogsScreen> {
  @override
  void initState() {
    final BlogsScreenViewModel blogsProvider =
        Provider.of<BlogsScreenViewModel>(context, listen: false);
    blogsProvider.fetchDataFromAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final BlogsScreenViewModel vm =
        Provider.of<BlogsScreenViewModel>(context, listen: true);
    final CommentsViewModel cVM =
        Provider.of<CommentsViewModel>(context, listen: true);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 29, 29, 29),
        title: const Text('Small Blog'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout_rounded,
              color: Colors.white,
            ),
            onPressed: () => FirebaseAuthService().signOut(context),
          )
        ],
      ),
      body: vm.blogsList.isEmpty
          ? const Center(
              child: CustProgress(),
            )
          : listView(vm, cVM),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey,
        onPressed: (() {
          vm.addEditBlog(context, false, vm: vm);
        }),
        child: const Icon(Icons.add),
      ),
    );
  }

  ListView listView(BlogsScreenViewModel vm, CommentsViewModel cVM) {
    return ListView.builder(
      padding: const EdgeInsets.all(4),
      itemCount: vm.blogsList.length,
      itemBuilder: (BuildContext context, int index) {
        return BlogItem(
          blogItem: vm.blogsList[index],
          vm: vm,
          commentsVM: cVM,
        );
      },
    );
  }
}
