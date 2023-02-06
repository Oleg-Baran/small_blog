import 'package:flutter/material.dart';

import 'package:small_blog/services/firebase_auth_service.dart';

import 'package:small_blog/util/common.dart';
import 'package:small_blog/widgets/custom_btn.dart';
import 'package:small_blog/widgets/custom_progress.dart';

import '../../util/validation.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  static const routeName = '/sign_in';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _hidePassword = true;

  bool _isLoading = false;

  bool _isEmailEditedAfterSubmit = true;
  bool _isPasswordEditedAfterSubmit = true;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topImage = Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: BoxDecoration(
          image: const DecorationImage(
              image: AssetImage('assets/images/sm.jpeg'), fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(12)),
    );

    const welcomeTxt = Padding(
      padding: EdgeInsets.only(top: 40),
      child: Text(
        "Welcome!",
        style: TextStyle(
            color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
      ),
    );

    final loginTextField = Padding(
      padding: const EdgeInsets.only(top: 30),
      child: TextFormField(
        cursorColor: Colors.white,
        autocorrect: false,
        style: const TextStyle(color: Colors.white),
        decoration: Common.getInputDecoration('Email'),
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (v) {
          return _isEmailEditedAfterSubmit
              ? null
              : Validation.emailValidator(v);
        },
        onSaved: (value) {
          _emailController.text = value.toString();
        },
        onChanged: (value) {
          setState(() {
            _isEmailEditedAfterSubmit = true;
          });
        },
      ),
    );

    final passwordTextField = Padding(
      padding: const EdgeInsets.only(top: 25),
      child: TextFormField(
        cursorColor: Colors.white,
        style: const TextStyle(color: Colors.white),
        decoration: Common.getInputDecoration(
          'Password',
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _hidePassword = !_hidePassword;
              });
            },
            color: Colors.white,
            icon: Icon(_hidePassword ? Icons.visibility_off : Icons.visibility),
          ),
        ),
        keyboardType: TextInputType.text,
        controller: _passwordController,
        onSaved: (input) => _passwordController.text = input!,
        validator: (v) {
          return _isPasswordEditedAfterSubmit
              ? null
              : Validation.passwordValidator(v);
        },
        onChanged: (value) {
          _isPasswordEditedAfterSubmit = true;
        },
        obscureText: _hidePassword,
      ),
    );

    final forgotPass = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () => Navigator.of(context).pushNamed('/forgot_password'),
          child: const Text(
            'Forgot password?',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );

    final signInBtn = Padding(
      padding: const EdgeInsets.only(top: 30),
      child: CustButton(
          text: 'Sign In',
          buttonAction: () {
            submit();
          }),
    );

    final createAccountBtn = Padding(
      padding: const EdgeInsets.only(top: 10),
      child: CustButton(
        text: 'Create Account',
        buttonAction: () => Navigator.pushNamed(
          context,
          '/sign_up',
        ).then((value) {
          _emailController.clear();
          _passwordController.clear();
        }),
      ),
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
                      topImage,
                      welcomeTxt,
                      loginTextField,
                      passwordTextField,
                      forgotPass,
                      _isLoading ? const CustProgress() : signInBtn,
                      createAccountBtn,
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

  Future<void> submit() async {
    Common.hideKeyboard(context);

    _isPasswordEditedAfterSubmit = false;
    _isEmailEditedAfterSubmit = false;

    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    setState(() {
      _isLoading = true;
    });

    FirebaseAuthService()
        .submitSignIn(
            ctx: context,
            emailController: _emailController,
            passwordController: _passwordController)
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }
}
