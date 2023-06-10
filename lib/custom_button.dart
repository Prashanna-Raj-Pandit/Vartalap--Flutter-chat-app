import 'package:flutter/material.dart';

class CustomButtons extends StatelessWidget {
  const CustomButtons({required this.color,required this.text,required this.onPressed
  });

  final String text;
  final Color color;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: color,
        elevation: 10,
        child: MaterialButton(
          minWidth: 200,
          height: 42.0,
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }
}