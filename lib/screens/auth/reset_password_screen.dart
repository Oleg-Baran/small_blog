import 'package:flutter/material.dart';

import '../../util/common.dart';
import '../../util/validation.dart';
import '../../widgets/custom_btn.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});
  static const routeName = '/forgot_password';

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  bool _isEmailEditedAfterSubmit = true;

  @override
  Widget build(BuildContext context) {
    final resetTxt = Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          const Text(
            "Reset password",
            style: TextStyle(
                color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );

    const topText = Padding(
      padding: EdgeInsets.only(top: 32),
      child: Text(
        'Enter your email to reset your password',
        style: TextStyle(color: Colors.white, fontSize: 32),
        textAlign: TextAlign.center,
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
          return _isEmailEditedAfterSubmit ? null : Validation.emailValidator(v);
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

    final sendBtn = Padding(
      padding: const EdgeInsets.only(top: 30),
      child: CustButton(text: 'Send', buttonAction: () => submit()),
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
                  children: [resetTxt, topText, emailTextField, sendBtn],
                )),
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

    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    
  }
}
