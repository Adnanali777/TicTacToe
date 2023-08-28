import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final List<Color> gradientColors;
  final String text;
  const CustomButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.gradientColors = const [Color(0xFFd62a8b), Color(0xFfa932ea)],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.6;

    return Container(
      decoration: const BoxDecoration(
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.blue,
          //     blurRadius: 5,
          //     spreadRadius: 0,
          //   )
          // ],
          ),
      child: Container(
        width: width,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient:
              LinearGradient(colors: gradientColors),
        ),
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
              elevation: 0.0,
              // shape: RoundedRectangleBorder(
              //   borderRadius: BorderRadius.circular(20),
              // ),
              backgroundColor: Colors.transparent),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
