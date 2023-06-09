import "package:flutter/material.dart";

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner : false,
      home : HomeScreen(),
    ),
  );
}

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String currentTabName = "회사";
  double tabBarHeight = 35.0;
  double tabBarExtendedHeight = 5.0;

  @override
  Widget build (BuildContext context) {
    return SafeArea(
      top : true,
      bottom : true,
      child : Scaffold(
        backgroundColor : Colors.white,

        // appBar
        appBar : PreferredSize(
          preferredSize : const Size.fromHeight(30.0),
          child : Container(

            // appBar-title
            child : Row(
              children : [
                Expanded(
                  child : Container(
                    alignment : Alignment.centerLeft,
                    margin : const EdgeInsets.only(left : 10),
                    child : const Text(
                      "LOGO",
                      style : TextStyle(
                        color : Colors.black,
                        fontSize : 20,
                        fontWeight : FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                // appBar-settings
                Expanded(
                  child : Container(
                    alignment : Alignment.centerRight,
                    child : TextButton(
                      onPressed : () {},
                      style : TextButton.styleFrom(
                        foregroundColor : Colors.white,
                        backgroundColor : Colors.white,
                      ),
                      child : const Text(
                        "편집",
                        style : TextStyle(
                          color : Colors.black,
                          fontSize : 10,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // body
        body : Column(
          crossAxisAlignment : CrossAxisAlignment.stretch,
          children : [

            // body-tabBar
            Container(
              padding : const EdgeInsets.symmetric(horizontal : 7),
              width : MediaQuery.of(context).size.width,
              height : tabBarHeight + tabBarExtendedHeight,
              child : SingleChildScrollView(
                scrollDirection : Axis.horizontal,
                child : Row(
                  mainAxisAlignment : MainAxisAlignment.start,
                  crossAxisAlignment : CrossAxisAlignment.start,
                  children : renderTabs(),
                ),
              ),
            ),

            // body-contents
            Expanded(
              child : Container(
                padding : const EdgeInsets.fromLTRB(10, 8, 10, 0),
                child : Container(
                  child : renderTabContents(currentTabName),
                ),
              ),
            ),

            // body-ad banner
            Container(
              height : 35.0,
              color : Colors.blue,
              child : const Center(
                child : Text(
                  "Ad Banner",
                  style : TextStyle(
                    color : Colors.white,
                  ),
                ),
              ),
             ),

            // body-start button
            Container(
              height : 35.0,
              padding : const EdgeInsets.symmetric(horizontal : 10),
              child : ElevatedButton(
                onPressed : () {},
                style : ElevatedButton.styleFrom(
                  backgroundColor : Colors.black,
                ),
                child : const Text(
                  "시작하기",
                  style : TextStyle(
                    fontSize : 12,
                    color : Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // tab list
  List<Widget> renderTabs () {
    return [eachTab("회사"), eachTab("본가"), eachTab("친구네"), eachTab("자취방")];
  }

  // each tab
  Widget eachTab (String tabName) {
    bool isSelected = currentTabName == tabName;
    return Container(
      width : 45.0,
      height : isSelected ? tabBarHeight + tabBarExtendedHeight : tabBarHeight,
      margin : const EdgeInsets.symmetric(horizontal : 3),
      padding : const EdgeInsets.all(0),
      child : OutlinedButton(
        onPressed : () {
          setState(() {
            currentTabName = tabName;
          });
        },
        style : OutlinedButton.styleFrom(
          backgroundColor : isSelected ? Colors.black : Colors.white,
          minimumSize : Size.zero,
          padding : const EdgeInsets.all(3),
          side : const BorderSide(
            color : Colors.black,
            width : 1,
          ),
          shape : RoundedRectangleBorder(
            borderRadius : BorderRadius.circular(0),
          ),
        ),
        child : Container(
          height : tabBarHeight,
          margin : isSelected ? EdgeInsets.only(bottom : tabBarExtendedHeight) : null,
          child : Center(
            child : Text(
              tabName,
              style : TextStyle(
                fontSize : 10,
                color : isSelected ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // contents
  Widget renderTabContents (String currentTabName) {
    return Center(
      child : Text("$currentTabName 에 관련된 checklist"),
    );
  }
}