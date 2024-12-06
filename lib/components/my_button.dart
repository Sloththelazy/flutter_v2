import 'package:flutter/material.dart';

class MyButton extends StatefulWidget {
  final Function()? onTap; // Callback for button press
  final String text; // Button text
  final Color color; // Background color
  final Color textColor; // Text color

  const MyButton({
    super.key,
    required this.onTap,
    this.text = "Sign In",
    this.color = const Color.fromARGB(255, 40, 85, 231), // Light Navy Blue
    this.textColor = Colors.white, // White text
  });

  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 45),
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(8),
          boxShadow: _isPressed
              ? []
              : [
                  const BoxShadow(
                    color: Color.fromARGB(66, 70, 70, 70),
                    blurRadius: 50,
                    offset: Offset(0, 10),
                  ),
                ],
        ),
        child: Center(
          child: Text(
            widget.text,
            style: TextStyle(
              color: widget.textColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}