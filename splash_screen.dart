import "package:flutter/material.dart";

void main() {
  runApp(SplashScreen());
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home : Scaffold(
				backgroundColor : Colors.white,
        body : Center(
          child : Column(
            mainAxisAlignment : MainAxisAlignment.center,
            children : [
              Text(
                "쉽고 빠른 짐싸기",
                style : TextStyle(
                  fontSize : 10,
                  fontWeight : FontWeight.w400,
                ),
              ),
              SizedBox(height : 3),
              Text(
                "LOGO",
                style : TextStyle(
                  fontSize : 20,
                  fontWeight : FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}