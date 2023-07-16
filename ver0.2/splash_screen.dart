import "package:flutter/material.dart";

void main() {
  runApp(SplashScreen());
}

// splash screen theme
class SplashScreenTheme {
  static const Color primaryColorMalachite = Color(0xff00cb08);
  static const Color secondaryColorMustard = Color(0xfffed058);
  
  static const TextStyle bodyText1 = TextStyle(
    color : Colors.black,
    fontSize : 15.0,
    fontWeight : FontWeight.w600,
  );
  static const TextStyle bodyText2 = TextStyle(
    color : Colors.black,
    fontSize : 15.0,
    fontWeight : FontWeight.w400,
  );
  static const TextStyle titleText = TextStyle(
    color : Colors.black,
    fontSize : 20.0,
    fontWeight : FontWeight.w800,
  );
  static const double underlineWidth = 30;
}

// splash screen
class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner : false,
      home : Scaffold(
        body : Center(
          child : Column(
            mainAxisAlignment : MainAxisAlignment.center,
            children : [

              // first line
              Row(
                mainAxisAlignment : MainAxisAlignment.center,
                children : [
                  Stack(
                    children : [
                      Row(
                        children : [
                          const SizedBox(width : 2.5),
                          Column( 
                            children : [
                              const SizedBox(width : SplashScreenTheme.underlineWidth, height : 10),
                              Container(
                                width : SplashScreenTheme.underlineWidth,
                                height : 7,
                                color : SplashScreenTheme.secondaryColorMustard,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Row(
                        children : [
                          Text(
                            " 여행",
                            style : SplashScreenTheme.bodyText1,
                          ),
                          Text(
                            " 갈 때,",
                            style : SplashScreenTheme.bodyText2,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              // second line
              const Text(
                "쉽고 빠른 짐싸기",
                style : SplashScreenTheme.bodyText2,
              ),
              const SizedBox(height : 8.0),
              Container(
                width : 1.0,
                height : 50.0,
                color : Colors.black,
              ),
              const SizedBox(height : 8.0),

              // logo icon
              const Icon(
                Icons.lock_outline,
                size : 60.0,
                color : SplashScreenTheme.primaryColorMalachite,
              ),

              // logo
              const Text(
                "짐고",
                style : SplashScreenTheme.titleText,
              ),
            ],
          ),
        ),
      ),
    );
  }
} 