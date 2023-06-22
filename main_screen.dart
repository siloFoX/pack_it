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
//   TextEdittingController controller;
  double tabBarHeight = 35.0;
  double tabBarExtendedHeight = 5.0;
  bool isEditMode = false;

  DataHandler dataHandler = DataHandler();
  late String selectedSet = dataHandler.listOfSet[0];
  
  // initState 부분은 DB 에서 가져올 부분을 위해 내버려둠
  @override
  void initState () {
//     controller = TextEdittingController();
    super.initState();
  }

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

                // appBar-edit
                Expanded(
                  child : Container(
                    alignment : Alignment.centerRight,
                    child : TextButton(
                      onPressed : () {
                        setState(() {
                          isEditMode = !isEditMode;
                        });
                      },
                      style : TextButton.styleFrom(
                        foregroundColor : Colors.white,
                        backgroundColor : Colors.white,
                      ),
                      child : Text(
                        isEditMode ? "완료" : "편집",
                        style : const TextStyle(
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
              decoration : isEditMode ? null : const BoxDecoration(
                border : Border(
                  bottom : BorderSide(
                    color : Colors.black,
                    width : 1.0,
                  ),
                ),
              ),
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
                padding : const EdgeInsets.fromLTRB(10, 5, 10, 0),
                child : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Container(
                        child: SingleChildScrollView(
                          child: ScrollableDropdown(
                            dataHandler : dataHandler,
                            selectedSet : selectedSet,
                            isEditMode : isEditMode,
                          ),
                        ),
                      ),
                    ),
                  ],
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
            if (!isEditMode)
              Container(
                height : 35.0,
                padding : const EdgeInsets.symmetric(horizontal : 10),
                child : ElevatedButton(
                  onPressed : () => pressStartButton(),
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

  Future<void> pressStartButton() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder : (context) => PackingScreen(dataHandler : dataHandler),
      ),
    );

    setState(() {});
  }

  // tab list
  List<Widget> renderTabs() {
    List<Widget> listOfTabs = dataHandler.listOfSet.map((eachSetName) => eachTab(eachSetName)).toList();

    if (isEditMode) {
      listOfTabs.insert(0, tabToAdd());
    }

    return listOfTabs;
  }

  Widget tabToAdd() {
    return Container(
      width : 45.0,
      height : tabBarHeight,
      padding : const EdgeInsets.all(0),
      child : Stack(
        children : [
          Container(
            margin : const EdgeInsets.fromLTRB(3, 3, 3, 0),
            child : OutlinedButton(
              onPressed : () {},
              style : OutlinedButton.styleFrom(
                backgroundColor : Colors.white,
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
                child : const Center(
                  child : Text(
                    "+ 추가",
                    style : TextStyle(
                      fontSize : 10,
                      color : Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // each tab
  Widget eachTab(String tabName) {
    bool isSelectedTab = isEditMode ? false : selectedSet == tabName;
    return Container(
      width : 45.0,
      height : isSelectedTab ? tabBarHeight + tabBarExtendedHeight : tabBarHeight,
      padding : const EdgeInsets.all(0),
      child : Stack(
        children : [
          Container(
            margin : const EdgeInsets.fromLTRB(3, 3, 3, 0),
            child : OutlinedButton(
              onPressed : () {
                if(!isEditMode) {
                  setState(() {
                    selectedSet = tabName;
                    dataHandler.pressSet(selectedSet);
                  });
                }
              },
              style : OutlinedButton.styleFrom(
                backgroundColor : isSelectedTab ? Colors.black : Colors.white,
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
                margin : isSelectedTab ? EdgeInsets.only(bottom : tabBarExtendedHeight) : null,
                child : Center(
                  child : Text(
                    tabName,
                    style : TextStyle(
                      fontSize : 10,
                      color : isSelectedTab ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (isEditMode)
            Positioned(
              top : 0,
              right : 1,
              child : GestureDetector(
                onTap : () {},
                child : const Icon(
                  Icons.remove_circle,
                  size : 10,
                  color : Colors.red,
                ),
              ),
            ),
        ],
      ),
    );
  }
}


class ScrollableDropdown extends StatefulWidget {
  final DataHandler dataHandler;
  final String selectedSet;
  final bool isEditMode;

  const ScrollableDropdown({
    required this.dataHandler,
    required this.selectedSet,
    required this.isEditMode,
  });

  @override
  State<ScrollableDropdown> createState() => ScrollableDropdownState();
}

class ScrollableDropdownState extends State<ScrollableDropdown> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data : ThemeData(
        splashColor : Colors.white,
        highlightColor : Colors.white,
      ),
      child : Column(
        children : renderDropdown(),
      ),
    );
  }

  List<Widget> renderDropdown() {
    List<Widget> dropdownList = widget.dataHandler.listOfCategory.map((eachCategory) {
      bool isSelectedDropdown = widget.isEditMode ? true : eachCategory.isCheckedCategoryBySet[widget.selectedSet]!;
      return Column(
        crossAxisAlignment : CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap : () => widget.isEditMode ? () {} : tapCategory(eachCategory),
            child : Container(
              height : 28,
              margin : eachCategory != widget.dataHandler.listOfCategory.first ? const EdgeInsets.only(top: 12) : null,
              decoration : BoxDecoration(
                border : Border.all(
                  color : Colors.black,
                  width : 1.0,
                ),
              ),
              child : customDropdownTile(
                category : eachCategory,
              ),
            ),
          ),
          if (isSelectedDropdown)
            Column(
              children : renderStuffTiles(eachCategory),
            ),
        ],
      );
    }).toList();
    
    if (widget.isEditMode) {
      dropdownList.add(addingCategoryTile());
    }

    return dropdownList;
  }

  void tapCategory(Category category) {
    setState(() {
      widget.dataHandler.pressCategory(category, widget.selectedSet);
    });
  }

  void tapStuff(StuffWithCheckPair pair) {
    setState(() {
      widget.dataHandler.pressStuff(pair, widget.selectedSet);
    });
  }

  List<Widget> renderStuffTiles(Category category) {
    List<Widget> stuffList = category.listOfPair.map((pair) {
      return GestureDetector(
        onTap : () => widget.isEditMode ? () {} : tapStuff(pair),
        child : Container(
          height : 19,
          decoration : const BoxDecoration(
            border : Border(
              left : BorderSide(
                color : Colors.black,
                width : 1.0,
              ),
              right : BorderSide(
                color : Colors.black,
                width : 1.0,
              ),
              bottom : BorderSide(
                color : Colors.black,
                width : 1.0,
              ),
            ),
          ),
          child : customDropdownTile(
            pair : pair,
          ),
        ),
      );
    }).toList();

    if(widget.isEditMode) {
      stuffList.insert(0, addingStuffTile());
    }

    return stuffList;
  }

  Widget addingCategoryTile() {
    return Column(
      crossAxisAlignment : CrossAxisAlignment.stretch,
      children: [
        addingTile(isPair : false),
      ],
    );
  }

  Widget addingStuffTile() {
    return addingTile(isPair : true);
  }

  Widget addingTile({required isPair}) {
    return GestureDetector(
      onTap : isPair ? () {} : () {},
      child : Container(
        height : isPair ? 19 : 28,
        margin : isPair ? null : const EdgeInsets.only(top: 12),
        decoration : BoxDecoration(
          color : Colors.white,
          border : isPair ? const Border(
            left : BorderSide(
              color : Colors.black,
              width : 1.0,
            ),
            right : BorderSide(
              color : Colors.black,
              width : 1.0,
            ),
            bottom : BorderSide(
              color : Colors.black,
              width : 1.0,
            ),
          ): Border.all(),
        ),
        child : Center(
          child : Text(
            isPair ? "+ 추가하기" : "+ 카테고리 추가",
            style : TextStyle(
              color : Colors.black,
              fontSize : isPair ? 8 : 10,
              fontWeight : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget customDropdownTile({StuffWithCheckPair? pair, Category? category}) {
    final isPair = pair != null;
    bool isChecked = isPair ? pair.isCheckedStuffBySet[widget.selectedSet]! : category!.isCheckedCategoryBySet[widget.selectedSet]!;
    isChecked = widget.isEditMode ? true : isChecked;
    return Container(
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          isPair ? const SizedBox(width : 18) : const SizedBox(width : 6),
          if (!widget.isEditMode)
            Icon(
              isChecked ? Icons.check_box_outlined : Icons.check_box_outline_blank,
              size : 10,
              color : isChecked ? Colors.black : Colors.grey,
            ),
          const SizedBox(width : 4),
          Text(
            isPair ? pair.stuffName : category!.categoryName,
            style: TextStyle(
              color : isChecked ? Colors.black : Colors.grey,
              fontSize : isPair ? 8 : 10,
              fontWeight : FontWeight.w500,
            ),
          ),
          if(widget.isEditMode)
            Expanded(
              child : Container(
                alignment : Alignment.centerRight,
                margin : EdgeInsets.only(right : isPair ? 6 : 5),
                child : GestureDetector(
                  onTap : () {},
                  child : Icon(
                    Icons.remove_circle,
                    size : isPair ? 10 : 12,
                    color : Colors.red,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}


// page for demo
class PackingScreen extends StatefulWidget {
  final DataHandler dataHandler;

  const PackingScreen({
    required this.dataHandler,
    Key? key,
  }) : super(key : key);

  @override
  State<PackingScreen> createState() => PackingScreenState();
}

class PackingScreenState extends State<PackingScreen> {
  late final int numberOfStuffs;
  static const double spaceBetweenRow = 10;
  static const double spaceLeftAndRight = 10;

  @override
  void initState() {
    numberOfStuffs = widget.dataHandler.tmpListOfStuff.length;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top : true,
      bottom : true,
      child :Scaffold(
        body : Center(
          child : Container(
            padding : const EdgeInsets.only(top : 20),
            child : Column(
              crossAxisAlignment : CrossAxisAlignment.stretch,
              children : [
                progressBar(widget.dataHandler.delayedListOfStuff.length + widget.dataHandler.tmpListOfCheckedStuff.length, numberOfStuffs),
                Expanded(
                  child : Container(
                    margin : const EdgeInsets.symmetric(horizontal : spaceLeftAndRight),
                    child : SingleChildScrollView(
                      child : Column(            
                        children : [
                          renderStuff(widget.dataHandler.tmpListOfStuff),
                          renderDelayedStuff(widget.dataHandler.delayedListOfStuff),
                          renderCheckedStuff(widget.dataHandler.tmpListOfCheckedStuff),
                        ],
                      ),
                    ),
                  ),
                ),

                // ad-banner
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

                if (widget.dataHandler.delayedListOfStuff.length + widget.dataHandler.tmpListOfCheckedStuff.length == numberOfStuffs)
                  renderCompeleteButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void pressStuff(String stuffName) {
    widget.dataHandler.pressTmpStuff(stuffName);
  }

  void swipeStuff(String stuffName) {
    widget.dataHandler.swipeTmpStuff(stuffName);
  }

  Widget progressBar(int nowLength, int fullLength) {
    return Container(
      margin : const EdgeInsets.symmetric(horizontal : spaceLeftAndRight),
      child : Column(
        children : [
          Container(
            child : LinearProgressIndicator(
              value : nowLength / fullLength,
              minHeight : 6.0,
              backgroundColor : Colors.grey,
              valueColor : const AlwaysStoppedAnimation<Color>(Colors.black),
            ),
          ),
          const SizedBox(height : 3),
          Container(
            child : Center(
              child : Text(
                "$nowLength/$fullLength",
                style : const TextStyle(
                  fontSize : 10.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget renderStuff(List<String> tmpListOfStuff) {
    return tmpListOfStuff.isEmpty ? Container() : Column(
      children : [
        const SizedBox(height : spaceBetweenRow),
        Container(
          decoration : containerDecoration(false),
          child : Column(
            children : tmpListOfStuff.map((stuffName) => CustomTile(titleContent : stuffName, onTap : tap, onDismissed : swipe, isDelay : false, isChecked : false)).toList(),
          ),
        ),
      ]
    );
  }

  Widget renderDelayedStuff(List<DelayedStuff> delayedListOfStuff) {
    return delayedListOfStuff.isEmpty ? Container() : Column(
      children : [
        const SizedBox(height : spaceBetweenRow),
        Row(
          mainAxisAlignment : MainAxisAlignment.end,
          children : [
            Container(
              child : Text(
                "나중에",
                style : TextStyle(
                  fontSize : 9.0,
                  fontWeight : FontWeight.w500,
                  color : Colors.grey[700],
                ),
              ),
            ),
            Expanded(
              child : Container(
                alignment : Alignment.centerRight,
                child : GestureDetector(
                  child : Row(
                    mainAxisAlignment : MainAxisAlignment.end,
                    children : [
                      const Icon(
                        Icons.access_time,
                        size : 10.0,
                        color : Colors.blue,
                      ),
                      const SizedBox(width : 3),
                      Container(
                        child : const Text(
                          "알림 설정",
                          style : TextStyle(
                            fontSize : 9.0,
                            fontWeight : FontWeight.w500,
                            color : Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height : 3),
        Container(
          decoration : containerDecoration(false),
          child : Column(
            children : delayedListOfStuff.map((delayedStuff) => CustomTile(titleContent : delayedStuff.stuffName, onDismissed : swipe, isDelay : true, isChecked : false)).toList(),
          ),
        ),
      ],
    );
  }

  Widget renderCheckedStuff(List<String> tmpListOfCheckedStuff) {
    return tmpListOfCheckedStuff.isEmpty ? Container() : Column(
      children : [
        const SizedBox(height : spaceBetweenRow),
        Container(
          alignment : Alignment.centerLeft,
          child : Text(
            "완료됨",
            style : TextStyle(
              fontSize : 9.0,
              fontWeight : FontWeight.w500,
              color : Colors.grey[700],
            ),
          ),
        ),
        const SizedBox(height : 3),
        Container(
          decoration : containerDecoration(true),
          child : Column(
            children : tmpListOfCheckedStuff.map((stuffName) => CustomTile(titleContent : stuffName, onTap : tap, isDelay : false, isChecked : true)).toList(),
          ),
        ),
      ]
    );
  }

  void tap(String stuffName) {
    setState(() {
      pressStuff(stuffName);
    });
  }

  void swipe(String stuffName) {
    setState(() {
      swipeStuff(stuffName);
    });
  }

  Decoration containerDecoration(bool isChecked) {
    return BoxDecoration(
      border : Border(
        left : BorderSide(
          color : isChecked ? Colors.grey : Colors.black,
          width : 1.0,
        ),
        top : BorderSide(
          color : isChecked ? Colors.grey : Colors.black,
          width : 1.0,
        ),
        right : BorderSide(
          color : isChecked ? Colors.grey : Colors.black,
          width : 1.0,
        ),
      ),
    );
  }

  Widget renderCompeleteButton() {
    return Container(
      height : 35,
      margin : const EdgeInsets.symmetric(horizontal : spaceLeftAndRight),
      child : OutlinedButton(
        onPressed : () => pressCompeleteButton(),
        style : OutlinedButton.styleFrom(
          backgroundColor : Colors.white,
          side : const BorderSide(
            color : Colors.black,
            width : 1.0,
          ),
        ),
        child : const Text(
          "완료",
          style : TextStyle(
            fontSize : 12,
            color : Colors.black,
          ),
        ),
      ),
    );
  }

  void pressCompeleteButton() {
    Navigator.pop(context);
  }
}


class CustomTile extends StatefulWidget {
  final String titleContent;
  final Function? onTap;
  final Function? onDismissed;
  final bool isDelay;
  final bool isChecked;

  const CustomTile({
    required this.titleContent,
    this.onTap,
    this.onDismissed,
    required this.isDelay,
    required this.isChecked,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomTile> createState() => CustomTileState();
}

class CustomTileState extends State<CustomTile> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment : MainAxisAlignment.start,
      children: [
        Expanded(
          child : Dismissible(
            direction : widget.isChecked ? DismissDirection.none : DismissDirection.endToStart,
            background : Container(
              color : widget.isDelay ? Colors.red : Colors.blue,
              child : Row(
                children : [
                  Expanded(child : Container()),
                  const Icon(
                    Icons.arrow_back,
                    color : Colors.white,
                    size : 18,
                  ),
                  const SizedBox(width : 3),
                  Text(
                    widget.isDelay ? "되돌리기" : "나중에",
                    style : const TextStyle(
                      fontSize : 10.0,
                      color : Colors.white,
                      fontWeight : FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width : 5),
                ],
              ),
            ),
            key : UniqueKey(),
            onDismissed : (direction) => widget.isDelay || !widget.isChecked ? widget.onDismissed!(widget.titleContent) : null,
            child : GestureDetector(
              onTap : () => widget.isChecked || !widget.isDelay ? widget.onTap!(widget.titleContent) : null,
              child : Container(
                height : 28,
                padding : const EdgeInsets.only(left : 6),
                decoration : BoxDecoration(
                  border : Border(
                    bottom : BorderSide(
                      color : widget.isChecked ? Colors.grey : Colors.black,
                      width : 1.0,
                    ),
                  ),
                ),
                child : Center(
                  child : Row(
                    children : [
                      Icon(
                        widget.isChecked ? Icons.check_box_outlined : Icons.check_box_outline_blank,
                        size : 10,
                        color : widget.isDelay ? Colors.blue : widget.isChecked ? Colors.grey : Colors.black,
                      ),
                      const SizedBox(width : 4),
                      Text(
                        widget.titleContent,
                        style : TextStyle(
                          fontSize : 10.0,
                          fontWeight : FontWeight.w500,
                          color : widget.isDelay ? Colors.blue : widget.isChecked ? Colors.grey : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// dataHandler part (분리해야하지만 데모 때문에 포함됨)

class StuffWithCheckPair implements Comparable<StuffWithCheckPair> {
  String stuffName;
  Map<String, bool> isCheckedStuffBySet = {};
  
  StuffWithCheckPair({
    required this.stuffName,
    List<String>? listOfSet,
  }) {
    if (listOfSet != null) 
      for (String eachSet in listOfSet) {
        isCheckedStuffBySet[eachSet] = false;
      }
  }
  
  void checkBySet(String setName) {
    isCheckedStuffBySet[setName] = true;
  }
  
  void uncheckBySet(String setName) {
    isCheckedStuffBySet[setName] = false;
  }

  void toggleBySet(String setName) {
    isCheckedStuffBySet[setName] = !isCheckedStuffBySet[setName]!;
  }
  
  void newSet(String setName) {
    uncheckBySet(setName);
  }

  void deleteSet(String setName) {
    isCheckedStuffBySet.remove(setName);
  }

  @override
  int compareTo(StuffWithCheckPair other) {
    return stuffName.compareTo(other.stuffName);
  }
  
  int compareToWithSetName(StuffWithCheckPair other, String setName) {
    if (isCheckedStuffBySet[setName] == other.isCheckedStuffBySet[setName]) 
      return compareTo(other);
    else 
      return isCheckedStuffBySet[setName]! ? -1 : 1;
  }
}

class Category implements Comparable<Category> {
  String categoryName;
  List<StuffWithCheckPair> listOfPair = [];
  Map<String, bool> isCheckedCategoryBySet = {};
  
  Category({
    required this.categoryName,
    List<String>? listOfSet,
  }) {
    if (listOfSet != null) 
      for (String eachSet in listOfSet) {
        isCheckedCategoryBySet[eachSet] = false;
      }
  }
  
  void checkBySet(String setName) {
    isCheckedCategoryBySet[setName] = true;
    for (StuffWithCheckPair pair in listOfPair) {
      pair.checkBySet(setName);
    }
  }
  
  void uncheckBySet(String setName) {
    isCheckedCategoryBySet[setName] = false;
    for (StuffWithCheckPair pair in listOfPair) {
      pair.uncheckBySet(setName);
    }
  }

  void toggleBySet(String setName) {
    isCheckedCategoryBySet[setName]! ? uncheckBySet(setName) : checkBySet(setName);
  }

  void newSet(String setName) {
    uncheckBySet(setName);
  }

  void deleteSet(String setName) {
    isCheckedCategoryBySet.remove(setName);
    for (StuffWithCheckPair pair in listOfPair) {
      pair.deleteSet(setName);
    }
  }

  void newStuff(String stuffName, List<String> listOfSet) {
    StuffWithCheckPair newStuff = StuffWithCheckPair(stuffName : stuffName, listOfSet : listOfSet);
    listOfPair.insert(0, newStuff);
  }

  void deleteStuff(StuffWithCheckPair pair) {
    listOfPair.remove(pair);
  }

  void sortListOfPairByListOfSet(List<String> listOfSet) {
    for (String eachSet in listOfSet) {
      sortListOfPair(eachSet);
    }
  }
  
  void sortListOfPair(String setName) {
    listOfPair.sort((a, b) => a.compareToWithSetName(b, setName));
  }

  @override
  int compareTo(Category other) {
    return categoryName.compareTo(other.categoryName);
  }

  int compareToWithSetName(Category other, String setName) {
    if (isCheckedCategoryBySet[setName] == other.isCheckedCategoryBySet[setName])
      return compareTo(other);
    else
      return isCheckedCategoryBySet[setName]! ? -1 : 1;
  }
}

class DelayedStuff {
  String stuffName;
  late DateTime? whenIPackIt;

  DelayedStuff({
    required this.stuffName,
    this.whenIPackIt = null,
  });
}

class ListOfCategoryWrapper {
  static void changeSet(List<Category> listOfCategory, String setName) {
    listOfCategory.sort((a, b) => a.compareToWithSetName(b, setName));
    sortEachCategories(listOfCategory, setName);
  }

  static void sortEachCategories(List<Category> listOfCategory, String setName) {
    for (Category eachCategory in listOfCategory) {
      eachCategory.sortListOfPair(setName);
    }
  }
}

class TmpListWrapper {
  static void delayToggle(String stuffName, List<String> tmpListOfStuff, List<DelayedStuff> delayedListOfStuff) {
    if (tmpListOfStuff.contains(stuffName)) {
      tmpListOfStuff.remove(stuffName);
      delayedListOfStuff.add(DelayedStuff(stuffName : stuffName));
    }
    else {
      tmpListOfStuff.add(stuffName);      
      delayedListOfStuff.remove(delayedListOfStuff.firstWhere((each) => each.stuffName == stuffName, orElse : () => DelayedStuff(stuffName : "")));
    }
  }

  static void checkToggle(String stuffName, List<String> tmpListOfStuff, List<String> tmpListOfCheckedStuff) {
    if (tmpListOfStuff.contains(stuffName)) {
      tmpListOfStuff.remove(stuffName);
      tmpListOfCheckedStuff.add(stuffName);
    }
    else {
      tmpListOfStuff.add(stuffName);
      tmpListOfCheckedStuff.remove(stuffName);
    }
  }
}

class DataHandler {
  List<String> listOfSet = [];
  List<Category> listOfCategory = [];

  List<String> tmpListOfStuff = [];
  List<DelayedStuff> delayedListOfStuff = [];
  List<String> tmpListOfCheckedStuff = [];
  
  DataHandler () {
    listOfSet = ["회사", "본가", "친구", "자취방"];
    final int listOfSetLength = listOfSet.length;
    
    List<String> categoryNames = ["외출(기본)", "운동", "숙박"];
    listOfCategory = categoryNames.map((eachName) => Category(categoryName : eachName)).toList();
    
    // Make category's stuff
    List<String> companyStuffs = ["워치 충전하기", "휴대폰 충전하기", "인공눈물", "락토프리 약", "에어팟", "애플 워치", "틴트 파우치", "휴대폰"];
    listOfCategory[0].listOfPair = companyStuffs.map((eachStuff) => StuffWithCheckPair(stuffName : eachStuff)).toList();

    List<String> exerciseStuffs = ["물", "이어폰"];
    listOfCategory[1].listOfPair = exerciseStuffs.map((eachStuff) => StuffWithCheckPair(stuffName : eachStuff)).toList();

    List<String> overdayStuffs = ["집들이 선물", "치약", "칫솔", "충전기"];
    listOfCategory[2].listOfPair = overdayStuffs.map((eachStuff) => StuffWithCheckPair(stuffName : eachStuff)).toList();

    // initialize every categories
    final int listOfCategoryLength = listOfCategory.length;
    for (int categoryIdx = 0; categoryIdx < listOfCategoryLength; categoryIdx++) {
      for (int setIdx = 0; setIdx < listOfSetLength; setIdx++) {
        listOfCategory[categoryIdx].uncheckBySet(listOfSet[setIdx]);
      }
    }
    listOfCategory[0].checkBySet("회사");
    tmpListOfStuff.addAll(companyStuffs);
    listOfCategory[1].checkBySet("회사");
    tmpListOfStuff.addAll(exerciseStuffs);

    final int companyListOfStuffLength = listOfCategory[0].listOfPair.length;
    listOfCategory[0].listOfPair[companyListOfStuffLength - 2].uncheckBySet("회사");
    tmpListOfStuff.removeAt(companyListOfStuffLength - 1);
    listOfCategory[0].listOfPair[companyListOfStuffLength - 1].uncheckBySet("회사");
    tmpListOfStuff.removeAt(companyListOfStuffLength - 2);

    initiativeSort();
  }
  
  void initiativeSort() {
    pressSet(listOfSet[0]);
  }

  void pressSet(String setName) {
    tmpListOfStuff.clear();
    listOfCategory.forEach((category) => category.listOfPair.forEach((pair) => pair.isCheckedStuffBySet[setName]! ? tmpListOfStuff.add(pair.stuffName) : null));
    ListOfCategoryWrapper.changeSet(listOfCategory, setName);
  }

  // check 또는 uncheck
  void pressStuff(StuffWithCheckPair pair, String setName) {
    pair.toggleBySet(setName);
    pair.isCheckedStuffBySet[setName]! 
    ? tmpListOfStuff.add(pair.stuffName) 
    : tmpListOfStuff.remove(pair.stuffName);
    ListOfCategoryWrapper.sortEachCategories(listOfCategory, setName);
  }

  void pressCategory(Category category, String setName) {
    category.toggleBySet(setName);
    category.isCheckedCategoryBySet[setName]!
    ? category.listOfPair.forEach((pair) => tmpListOfStuff.add(pair.stuffName))
    : category.listOfPair.forEach((pair) => tmpListOfStuff.remove(pair.stuffName));
    ListOfCategoryWrapper.changeSet(listOfCategory, setName);
  }

  void pressTmpStuff(String stuffName) {
    TmpListWrapper.checkToggle(stuffName, tmpListOfStuff, tmpListOfCheckedStuff);
  }

  void swipeTmpStuff(String stuffName) {
    TmpListWrapper.delayToggle(stuffName, tmpListOfStuff, delayedListOfStuff);
  }

  void newSet(String setName) {
    listOfSet.insert(0, setName);
    for (Category each in listOfCategory) {
      each.newSet(setName);
    }
  }

  void deleteSet(String setName) {
    listOfSet.remove(setName);
    for (Category each in listOfCategory) {
      each.deleteSet(setName);
    }
  }

  void newCategory(String categoryName) {
    Category newCategory = Category(categoryName : categoryName, listOfSet : listOfSet);
    listOfCategory.insert(0, newCategory);
  }

  void deleteCategory(Category category) {
    listOfCategory.remove(category);
    category.listOfPair.map((pair) => tmpListOfStuff.remove(pair.stuffName));
  }

  void newStuff(Category category, String stuffName) {
    category.newStuff(stuffName, listOfSet);
  }

  void deleteStuff(Category category, StuffWithCheckPair pair) {
    category.deleteStuff(pair);
    tmpListOfStuff.remove(pair.stuffName);
  }
}