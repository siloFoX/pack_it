import "package:flutter/material.dart";

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner : false,
      home : PackingScreen(dataHandler : DataHandler()),
    ),
  );
}

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
            padding : const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child : Column(            
              children : [
                progressBar(widget.dataHandler.delayedListOfStuff.length + widget.dataHandler.tmpListOfCheckedStuff.length, numberOfStuffs),

                renderStuff(widget.dataHandler.tmpListOfStuff),
                renderDelayedStuff(widget.dataHandler.delayedListOfStuff),
                renderCheckedStuff(widget.dataHandler.tmpListOfCheckedStuff),
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
    return Column(
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
}

class CustomTile extends StatelessWidget {
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
  }) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap : () => isChecked || !isDelay ? onTap!(titleContent) : null,
      child : Container(
        decoration : BoxDecoration(
          border : Border(
            bottom : BorderSide(
              color : isChecked ? Colors.grey : Colors.black,
              width : 1.0,
            ),
          ),
        ),
        child : Dismissible(
          direction : isChecked ? DismissDirection.none : DismissDirection.endToStart,
          key : UniqueKey(),
          onDismissed : (direction) => isDelay || !isChecked ? onDismissed!(titleContent) : null,
          child : Center(
            child : Text(
              titleContent,
              style : TextStyle(
                fontSize : 10.0,
                fontWeight : FontWeight.w500,
                color : isDelay ? Colors.blue : (isChecked ? Colors.grey : Colors.black),
              ),
            ),
          ),
        ),
      ),
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
  late DateTime whenIPackIt;

  DelayedStuff({
    required this.stuffName,
    whenIPackIt,
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