// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  Future<http.Response?> postRequest({
    required BuildContext context,
    required String url,
    required Map<String, dynamic> body,
    String? successMessage,
    String? errorMessage,
  }) async {
    try {
      final Uri uri = Uri.parse(url);
      final http.Response response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (successMessage != null) {
          _showSnackBar(context, successMessage, color: Colors.green);
        }
        return response;
      } else {
        _showSnackBar(
          context,
          errorMessage ?? 'Something went wrong. Try again.',
          color: Colors.red,
        );
        return null;
      }
    } catch (e) {
      _showSnackBar(
        context,
        'Network error: ${e.toString()}',
        color: Colors.red,
      );
      return null;
    }
  }

  void _showSnackBar(
    BuildContext context,
    String message, {
    Color color = Colors.blue,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
