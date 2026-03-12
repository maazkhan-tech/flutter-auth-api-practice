// ignore_for_file: use_build_context_synchronously, avoid_print
import 'package:flutter/material.dart';
import 'package:practice_api_second/common_widgets.dart/api_service.dart';
import 'package:practice_api_second/common_widgets.dart/my_button.dart';
import 'package:practice_api_second/common_widgets.dart/my_textformfeild.dart';
import 'package:practice_api_second/common_widgets.dart/my_url.dart';
import 'login_page.dart';

class ForgotPassChange extends StatefulWidget {
  const ForgotPassChange({
    super.key,
    required this.resetToken,
    required this.identifier,
  });
  final String resetToken;
  final String identifier;
  @override
  State<ForgotPassChange> createState() => _ForgotPassChangeState();
}

class _ForgotPassChangeState extends State<ForgotPassChange> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  TextEditingController newPass = TextEditingController();
  TextEditingController confPass = TextEditingController();
  final ApiService _apiService = ApiService();
  Future<void> sendUserData(String newpass, String cnfpass) async {
    setState(() {
      _isLoading = true;
    });
    final Map<String, String> userData = {
      "identifier": widget.identifier,
      "newPassword": newpass,
      "confirmNewPassword": cnfpass,
      "resetToken": widget.resetToken,
    };
    final response = await _apiService.postRequest(
      context: context,
      url: Myurl.forgotPassChange,
      body: userData,
      errorMessage: "Password Change Unsuccessfull",
      successMessage: "Password Change Successfully",
    );
    if (response != null) {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => PostApiExample()));
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
        title: Text('Change Password', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomValidatedFormField(
                hintText: 'New Password',
                controller: newPass,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please fill the feild';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              CustomValidatedFormField(
                hintText: 'Confirm New Password',
                controller: confPass,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please fill the feild';
                  }
                  if (value != newPass.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              SizedBox(height: 50),
              CustomLoadingButton(
                isLoading: _isLoading,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _isLoading = true;
                    });
                    await sendUserData(newPass.text, confPass.text);
                  }
                  setState(() {
                    _isLoading = false;
                  });
                },
                text: "Change Password",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
