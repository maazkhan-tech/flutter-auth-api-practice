// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:practice_api_second/common_widgets.dart/api_service.dart';
import 'package:practice_api_second/common_widgets.dart/my_button.dart';
import 'package:practice_api_second/common_widgets.dart/my_url.dart';
import 'package:practice_api_second/login_otp_page.dart';
import 'package:practice_api_second/register_api.dart';
import 'common_widgets.dart/my_textformfeild.dart';
import 'forget_pass.dart';

class PostApiExample extends StatefulWidget {
  const PostApiExample({super.key});

  @override
  State<PostApiExample> createState() => _PostApiExampleState();
}

class _PostApiExampleState extends State<PostApiExample> {
  final ApiService _apiService = ApiService();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
 
  Future<void> sendUserData(String email, String password) async {
    setState(() {
      _isLoading = true;
    });

    final Map<String, dynamic> userData = {
      "identifier": email,
      'password': password,
      'deviceId': '100',
    };

    final response = await _apiService.postRequest(
      context: context,
      url: Myurl.login,
      body: userData,
      successMessage: 'Please Verify Your OTP',
      errorMessage: 'Email or Password is incorrect',
    );
    if (response != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => LoginOtpPage(identifier: email),
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
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue,
        title: Text('Secure Login', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomValidatedFormField(
                controller: email,
                hintText: 'Enter Email or Phone Number',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter email/number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              CustomValidatedFormField(
                obscureText: true,
                controller: password,
                hintText: 'Password',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter correct password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ForgetPassword(),
                        ),
                      );
                    },
                    child: Text(
                      'Forget Password',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
              CustomLoadingButton(
                isLoading: _isLoading,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _isLoading = true;
                    });

                    await sendUserData(email.text, password.text);

                    setState(() {
                      _isLoading = false;
                    });
                  }
                },
                text: 'Login',
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => RegisterApi()),
                      );
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
