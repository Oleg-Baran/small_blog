import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:small_blog/screens/blog/blogs_screen_view_model.dart';
import 'package:small_blog/screens/auth/reset_password_screen.dart';
import 'package:small_blog/screens/auth/sign_in_screen.dart';
import 'package:small_blog/screens/blog/blogs_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:small_blog/screens/posts/add_or_edit_post.dart';
import 'package:small_blog/screens/posts/comments_view_model.dart';
import 'package:small_blog/screens/posts/post_comment_screen.dart';

import 'firebase_options.dart';
import 'screens/auth/sign_up_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BlogsScreenViewModel>(create: (_) => BlogsScreenViewModel()),
        ChangeNotifierProvider<CommentsViewModel>(create: (_) => CommentsViewModel()),
      ],
      child: MaterialApp(
        title: 'Small Blog',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Colors.black,
          ),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/blogs',
        routes: {
          '/sign_in': (ctx) => const AuthScreen(),
          '/sign_up': (ctx) => const SignUpScreen(),
          '/forgot_password': (ctx) => const ForgotPasswordScreen(),
          '/blogs': (ctx) => const BlogsScreen(),
          '/add_edit_post': (ctx) => AddEditPostScreen(),
          '/comments' : (ctx) => PostCommentScreen()
        },
      ),
    );
  }
}
