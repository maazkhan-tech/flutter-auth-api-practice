// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:practice_api_second/common_widgets.dart/api_service.dart';
import 'package:practice_api_second/common_widgets.dart/my_url.dart';
import 'package:practice_api_second/login_page.dart';

class LoginOtpPage extends StatefulWidget {
  final String identifier;
  const LoginOtpPage({super.key, required this.identifier});

  @override
  State<LoginOtpPage> createState() => _LoginOtpPageState();
}

class _LoginOtpPageState extends State<LoginOtpPage> {
  @override
  void initState() {
    super.initState();
    identity.text = widget.identifier;
  }

  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController identity = TextEditingController();
  TextEditingController otp = TextEditingController();
  final ApiService _apiService = ApiService();
  Future<void> sendUserData(String identifier, String otp) async {
    setState(() {
      isLoading = true;
    });
    final Map<String, String> userData = {
      "identifier": identifier,
      "otp": otp,
      "deviceId": '100',
    };
    final resp = await _apiService.postRequest(
      context: context,
      url: Myurl.loginOtp,
      body: userData,
      successMessage: 'OTP Confirm Successfully',
      errorMessage: "Please Enter Correct OTP",
    );
    if (resp != null) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => PostApiExample()),
        (route) => false,
      );
      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
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
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsetsGeometry.all(14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: identity,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Correct Email OR Number';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hint: Text('Enter Number/Email'),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                keyboardType: TextInputType.numberWithOptions(),
                controller: otp,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Correct OTP';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hint: Text('OTP'),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () async {
                      await _apiService.postRequest(
                        context: context,
                        url: Myurl.resendOtp,
                        body: <String, String>{
                          "identifier": identity.text,
                          "deviceId": "100",
                        },
                      );
                    },
                    child: Text('Resend', style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
              SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: isLoading
                      ? null
                      : () {
                          if (_formKey.currentState!.validate()) {
                            sendUserData(identity.text, otp.text);
                          }
                        },
                  child: isLoading
                      ? SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.grey,
                          ),
                        )
                      : Text('Submit', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
