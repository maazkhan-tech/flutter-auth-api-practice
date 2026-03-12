// ignore_for_file: use_build_context_synchronously, avoid_print
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:practice_api_second/common_widgets.dart/api_service.dart';
import 'package:practice_api_second/common_widgets.dart/my_button.dart';
import 'package:practice_api_second/common_widgets.dart/my_textformfeild.dart';
import 'package:practice_api_second/common_widgets.dart/my_url.dart';

import 'forgot_pass_change.dart';

class OtpPage extends StatefulWidget {
  final String identifier;
  const OtpPage({super.key, required this.identifier});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  @override
  void initState() {
    super.initState();
    email.text = widget.identifier;
  }

  final _formKey = GlobalKey<FormState>();
  bool _isloading = false;
  TextEditingController email = TextEditingController();
  TextEditingController otp = TextEditingController();
  final ApiService _apiService = ApiService();
  Future<void> sendUserData(String number, String otp) async {
    setState(() {
      _isloading = true;
    });
    final Map<String, String> userData = {"identifier": number, "otp": otp};
    final response = await _apiService.postRequest(
      context: context,
      url: Myurl.verFrgtPassOtp,
      body: userData,
      errorMessage: "Invalid OTP",
      successMessage:
          'OTP verified successfully. You can now reset your password.',
    );
    if (response == null) return;
    var res = jsonDecode(response.body);
    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (context) => ForgotPassChange(
              resetToken: res['resetToken'].toString(),
              identifier: number,
            ),
          ),
        )
        .then(
          (value) => setState(() {
            _isloading = false;
          }),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('OTP', style: TextStyle(color: Colors.white)),
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
                hintText: 'Email or Phone Number',
                controller: email,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter Email/Number";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              CustomValidatedFormField(
                keyboardType: TextInputType.numberWithOptions(),
                hintText: 'OTP',
                controller: otp,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter OTP";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              CustomLoadingButton(
                isLoading: _isloading,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _isloading = true;
                    });
                    await sendUserData(email.text, otp.text);
                  }
                  setState(() {
                    _isloading = false;
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
