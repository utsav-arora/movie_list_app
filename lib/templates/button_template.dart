import 'package:flutter/material.dart';

class ButtonTemplate extends StatelessWidget {

  final Color buttonColor;
  final String buttonText;
  final VoidCallback onPress;

  ButtonTemplate({required this.buttonColor, required this.buttonText , required this.onPress}) ;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: buttonColor,
        borderRadius: BorderRadius.circular(15.0),
        child: MaterialButton(
          onPressed: onPress,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            buttonText,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
