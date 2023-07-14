import "package:flutter/material.dart";

void main() {
  runApp(SplashScreen());
}

final splashScreenTheme  = ThemeData(
  scaffoldBackgroundColor : Colors.white,
  textTheme : const TextTheme(
    bodyText1 : TextStyle(
      color : Colors.black,
      fontSize : 10.0,
      fontWeight : FontWeight.w600,
    ),
    bodyText2 : TextStyle(
      color : Colors.black,
      fontSize : 10.0,
      fontWeight : FontWeight.w400,
    ),
  ),
);

const titleTheme = TextStyle(
  color : Colors.black,
  fontSize : 20.0,
  fontWeight : FontWeight.w800,
);

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner : false,
      theme : splashScreenTheme,
      home : Scaffold(
        body : Center(
          child : Column(
            mainAxisAlignment : MainAxisAlignment.center,
            children : [
              Row(
                mainAxisAlignment : MainAxisAlignment.center,
                children : [
                  Stack(
                    children : [
                      Container(
                        width : 25,
                        height : 17,
                        child : Column(
                          mainAxisAlignment : MainAxisAlignment.end,
                          children : [
                            Container(
                              height : 7,
                              color : const Color(0xfffed058), // 색상을 따로 빼야할 듯
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children : [
                          Text(
                            "여행",
                            style : Theme.of(context).textTheme.bodyText1,
                          ),
                          Text(
                            " 갈 때,",
                            style : Theme.of(context).textTheme.bodyText2,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                "쉽고 빠른 짐싸기",
                style : Theme.of(context).textTheme.bodyText2,
              ),
              const SizedBox(height : 8.0),
              Container(
                width : 1.0,
                height : 50.0,
                color : Colors.black,
              ),
              const SizedBox(height : 8.0),
              const Icon(
                Icons.lock_outline,
                size : 60.0,
                color : Color(0xff00cb08),
              ),
              Text(
                "짐고",
                style : titleTheme,
              ),
            ],
          ),
        ),
      ),
    );
  }
} 