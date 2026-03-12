// ignore_for_file: use_build_context_synchronously, avoid_print
import 'package:flutter/material.dart';
import 'package:practice_api_second/common_widgets.dart/api_service.dart';
import 'package:practice_api_second/common_widgets.dart/my_button.dart';
import 'package:practice_api_second/common_widgets.dart/my_text.dart';
import 'package:practice_api_second/common_widgets.dart/my_url.dart';
import 'common_widgets.dart/my_textformfeild.dart';
import 'login_page.dart';

class RegisterApi extends StatefulWidget {
  const RegisterApi({super.key});

  @override
  State<RegisterApi> createState() => _RegisterApiState();
}

class _RegisterApiState extends State<RegisterApi> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final ApiService _apiService = ApiService();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController countryCode = TextEditingController();
  TextEditingController dialCode = TextEditingController();
  TextEditingController password = TextEditingController();
  Future<void> sendUserData(
    String name,
    String email,
    String mobNo,
    String countCode,
    String dlCode,
    String pass,
  ) async {
    setState(() {
      _isLoading = true;
    });
    final Map<String, String> userData = {
      "name": name,
      "email": email,
      "mobile": mobNo,
      "country_code": countCode,
      "dial_code": dlCode,
      "password": pass,
      "deviceId": '1',
    };
    final response = await _apiService.postRequest(
      context: context,
      url: Myurl.register,
      body: userData,
      successMessage: 'Register Successfully',
      errorMessage: "User Already Exist",
    );

    if (response != null) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => PostApiExample()),
        (route) => false,
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
        title: Text('Register Api', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                LabelText(text: 'Full Name*'),
                SizedBox(height: 10),
                CustomValidatedFormField(
                  hintText: 'Full Name',
                  controller: name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill the feild';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                LabelText(text: 'Email*'),
                SizedBox(height: 10),
                CustomValidatedFormField(
                  hintText: 'Email',
                  controller: email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill the feild';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                LabelText(text: 'Ph Number*'),
                SizedBox(height: 10),
                CustomValidatedFormField(
                  hintText: 'Phone Number',
                  controller: mobileNumber,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill the feild';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                LabelText(text: 'Country Code*'),
                SizedBox(height: 10),
                CustomValidatedFormField(
                  hintText: 'Country Code',
                  controller: countryCode,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill the feild';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                LabelText(text: 'Dial Code*'),
                SizedBox(height: 10),
                CustomValidatedFormField(
                  hintText: 'Dial Code',
                  controller: dialCode,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill the feild';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                LabelText(text: 'Password*'),
                SizedBox(height: 10),
                CustomValidatedFormField(
                  hintText: 'Password',
                  controller: password,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill the feild';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),
                CustomLoadingButton(
                  isLoading: _isLoading,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await sendUserData(
                        name.text.toString(),
                        email.text.toString(),
                        mobileNumber.text.toString(),
                        countryCode.text.toString(),
                        dialCode.text.toString(),
                        password.text.toString(),
                      );
                      setState(() {
                        _isLoading = false;
                      });
                    }
                  },
                  text: 'Register',
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
