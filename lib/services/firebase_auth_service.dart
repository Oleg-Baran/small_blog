import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import '../util/common.dart';

class FirebaseAuthService {
  Future<void> submitSignIn({
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required BuildContext ctx,
  }) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          )
          .then(
            (value) => Navigator.of(ctx).pushNamedAndRemoveUntil(
                '/blogs', (Route<dynamic> route) => false),
          );
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);

      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        Common.showErrorDialog('Wrong email or password', ctx);
      }
    }
  }

  Future<void> submitSignUp({
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required BuildContext ctx,
  }) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          )
          .then((value) => Navigator.of(ctx).popAndPushNamed('/sign_in'));
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);

      if (e.code == 'email-already-in-use') {
        Common.showErrorDialog("Such email already exists", ctx);
      }
    }
  }

  Future<void> submitRecoverPass({
    required TextEditingController emailController,
    required BuildContext ctx,
  }) async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(
            email: emailController.text.trim(),
          )
          .then((value) => Navigator.of(ctx).popAndPushNamed('/sign_in'));
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);

      if (e.code == 'user-not-found') {
        Common.showErrorDialog("User not found", ctx);
      }
    }
  }

  Future<void> signOut(BuildContext ctx) async {
    final nav = Navigator.of(ctx);
    await FirebaseAuth.instance.signOut();
    nav.pushNamedAndRemoveUntil('/sign_in', (Route<dynamic> route) => false);
  }
}
