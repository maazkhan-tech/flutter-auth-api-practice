// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:practice_api_second/common_widgets.dart/api_service.dart';
import 'package:practice_api_second/common_widgets.dart/my_button.dart';
import 'package:practice_api_second/common_widgets.dart/my_textformfeild.dart';
import 'package:practice_api_second/common_widgets.dart/my_url.dart';
import 'forgot_pass_otp.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController userNumber = TextEditingController();
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final ApiService _apiService = ApiService();
  Future<void> sendUserData(String enterNumber) async {
    setState(() {
      _isLoading = true;
    });
    final Map<String, String> userData = {"identifier": enterNumber};
    final response = await _apiService.postRequest(
      context: context,
      url: Myurl.reqForgotPass,
      body: userData,
      successMessage:
          "OTP has been sent to your email/number. Please check and verify.",
      errorMessage: 'Enter Correct Email',
    );
    if (response != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => OtpPage(identifier: enterNumber),
        ),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Forgot Password', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomValidatedFormField(
                hintText: 'Email or Phone Number',
                controller: userNumber,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Correct Email/Number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),
              CustomLoadingButton(
                isLoading: _isLoading,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _isLoading = true;
                    });
                    await sendUserData(userNumber.text);
                  }
                  setState(() {
                    _isLoading = false;
                  });
                },
                text: 'Submit',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
