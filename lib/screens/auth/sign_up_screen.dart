import 'package:flutter/material.dart';
import 'package:small_blog/services/firebase_auth_service.dart';

import 'package:small_blog/util/common.dart';
import 'package:small_blog/widgets/custom_btn.dart';
import 'package:small_blog/widgets/custom_progress.dart';

import '../../util/validation.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static const routeName = '/sign_up';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _hidePassword = true;
  bool _hideRePassword = true;

  var _isLoading = false;

  var _isEmailEditedAfterSubmit = true;
  var _isPasswordEditedAfterSubmit = true;
  var _isRePasswordEditedAfterSubmit = true;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _rePasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final registerTxt = Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          const Text(
            "Registration",
            style: TextStyle(
                color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );

    final emailTextField = Padding(
      padding: const EdgeInsets.only(top: 25),
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

    final passTextField = Padding(
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

    final rePassTextField = Padding(
      padding: const EdgeInsets.only(top: 25),
      child: TextFormField(
        cursorColor: Colors.white,
        style: const TextStyle(color: Colors.white),
        decoration: Common.getInputDecoration(
          'Repeat Password',
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _hideRePassword = !_hideRePassword;
              });
            },
            color: Colors.white,
            icon:
                Icon(_hideRePassword ? Icons.visibility_off : Icons.visibility),
          ),
        ),
        keyboardType: TextInputType.text,
        controller: _rePasswordController,
        onSaved: (input) => _rePasswordController.text = input!,
        validator: (v) {
          return _isRePasswordEditedAfterSubmit
              ? null
              : Validation.secondPasswordValidator(v, _passwordController.text);
        },
        onChanged: (value) {
          _isRePasswordEditedAfterSubmit = true;
        },
        obscureText: _hidePassword,
      ),
    );

    final createBtn = Padding(
      padding: const EdgeInsets.only(top: 30),
      child: CustButton(
          text: 'Create',
          buttonAction: () {
            submit();
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
                      registerTxt,
                      emailTextField,
                      passTextField,
                      rePassTextField,
                      _isLoading ? const CustProgress() : createBtn,
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

    _isEmailEditedAfterSubmit = false;
    _isPasswordEditedAfterSubmit = false;
    _isRePasswordEditedAfterSubmit = false;

    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    setState(() {
      _isLoading = true;
    });

    FirebaseAuthService()
        .submitSignUp(
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
