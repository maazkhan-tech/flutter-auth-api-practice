import 'package:flutter/material.dart';

class CustomLoadingButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;
  final String text;
  final Color backgroundColor;
  final Color textColor;

  const CustomLoadingButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
    required this.text,
    this.backgroundColor = Colors.blue,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          backgroundColor: backgroundColor,
        ),
        child: isLoading
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 4,
                ),
              )
            : Text(
                text,
                style: TextStyle(color: textColor),
              ),
      ),
    );
  }
}
