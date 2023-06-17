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
                          dataHandler.pressEdit(isEditMode);
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
              child : customTile(
                category : eachCategory,
              ),
            ),
          ),
          if (isSelectedDropdown)
            Container(
              decoration : BoxDecoration(
                color : Colors.grey[100],
                border: const Border(
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
              child : ListView.separated(
                shrinkWrap : true,
                physics : const NeverScrollableScrollPhysics(),
                itemCount : eachCategory.listOfPair.length,
                itemBuilder : (BuildContext context, int idx) {
                  final pair = eachCategory.listOfPair[idx];
                  return Column(
                    children: [
                      GestureDetector(
                        onTap : () => widget.isEditMode ? () {} : tapStuff(pair),
                        child : Container(
                          height : 19,
                          padding : const EdgeInsets.only(left : 15),
                          child : customTile(
                            pair : pair,
                          ),
                        ),
                      ),
                      if (idx != eachCategory.listOfPair.length - 1)
                        const Divider(
                          height : 1,
                          color : Colors.black,
                        ),
                    ],
                  );
                },
                separatorBuilder : (BuildContext context, int index) => const SizedBox(), // Empty separator
              ),
            ),
        ],
      );
    }).toList();
    
    if (widget.isEditMode) {
      dropdownList.add(addingListTile(isPair : false));
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

  Widget addingListTile({required bool isPair}) {
    return Column(
      crossAxisAlignment : CrossAxisAlignment.stretch,
      children: [
        GestureDetector(
          onTap : () => isPair ? () {} : () {},
          child : Container(
            height : isPair ? 19 : 28,
            margin : isPair ? null : const EdgeInsets.only(top: 12),
            decoration : BoxDecoration(
              color : isPair ? Colors.grey[100] : Colors.white,
              border : Border.all(
                color : Colors.black,
                width : 1.0,
              ),
            ),
            child : Center(
              child : Text(
                isPair ? "+ 추가" : "+ 카테고리 추가",
                style : TextStyle(
                  color : Colors.black,
                  fontSize : isPair ? 8 : 10,
                  fontWeight : FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget customTile({StuffWithCheckPair? pair, Category? category}) {
    final isPair = pair != null;
    bool isChecked = isPair ? pair.isCheckedStuffBySet[widget.selectedSet]! : category!.isCheckedCategoryBySet[widget.selectedSet]!;
    isChecked = widget.isEditMode ? true : isChecked;
    return Container(
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          const SizedBox(width : 6),
          if (!widget.isEditMode)
            Icon(
              isChecked ? Icons.check_box_outlined : Icons.check_box_outline_blank,
              size : 10,
              color : isChecked ? Colors.black : Colors.grey,
            ),
          const SizedBox(width : 4),
          Text(
            isPair ? pair.stuff : category!.categoryName,
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

// dataHandler part (분리해야하지만 데모 때문에 포함됨)

class StuffWithCheckPair implements Comparable<StuffWithCheckPair> {
  String stuff;
  Map<String, bool> isCheckedStuffBySet = {};
  
  StuffWithCheckPair({
    required this.stuff,
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
    return stuff.compareTo(other.stuff);
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
    StuffWithCheckPair newStuff = StuffWithCheckPair(stuff : stuffName, listOfSet : listOfSet);
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

class DataHandler {
  List<String> listOfSet = [];
  List<Category> listOfCategory = [];
  
  DataHandler () {
    listOfSet = ["회사", "본가", "친구", "자취방"];
    final int listOfSetLength = listOfSet.length;
    
    listOfCategory = [
      Category(categoryName : "외출(기본)"),
      Category(categoryName : "운동"),
      Category(categoryName : "숙박"),
    ];
    
    // // Make '회사' category's stuff
    listOfCategory[0].listOfPair = [
      StuffWithCheckPair(stuff : "워치 충전하기"),
      StuffWithCheckPair(stuff : "휴대폰 충전하기"),
      StuffWithCheckPair(stuff : "인공눈물"),
      StuffWithCheckPair(stuff : "락토프리 약"),
      StuffWithCheckPair(stuff : "에어팟"),
      StuffWithCheckPair(stuff : "애플 워치"),
      StuffWithCheckPair(stuff : "틴트 파우치"),
      StuffWithCheckPair(stuff : "휴대폰"),
    ];
    listOfCategory[1].listOfPair = [
      StuffWithCheckPair(stuff : "물"),
      StuffWithCheckPair(stuff : "이어폰"),
    ];
    listOfCategory[2].listOfPair = [
      StuffWithCheckPair(stuff : "집들이 선물"),
      StuffWithCheckPair(stuff : "치약"),
      StuffWithCheckPair(stuff : "칫솔"),
      StuffWithCheckPair(stuff : "충전기"),
    ];

    // initialize every categories
    final int listOfCategoryLength = listOfCategory.length;
    for (int categoryIdx = 0; categoryIdx < listOfCategoryLength; categoryIdx++) {
      for (int setIdx = 0; setIdx < listOfSetLength; setIdx++) {
        listOfCategory[categoryIdx].uncheckBySet(listOfSet[setIdx]);
      }
    }
    listOfCategory[0].checkBySet("회사");
    listOfCategory[1].checkBySet("회사");

    final int companyListOfStuffLength = listOfCategory[0].listOfPair.length;
    listOfCategory[0].listOfPair[companyListOfStuffLength - 2].uncheckBySet("회사");
    listOfCategory[0].listOfPair[companyListOfStuffLength - 1].uncheckBySet("회사");    
    
    initiativeSort();
  }
  
  void initiativeSort() {
    pressSet(listOfSet[0]);
  }

  void pressSet(String setName) {
    ListOfCategoryWrapper.changeSet(listOfCategory, setName);
    // for (Category eachCategory in listOfCategory) {
    //   print(eachCategory.categoryName);
    //   for (StuffWithCheckPair pair in eachCategory.listOfPair) {
    //     print(pair.stuff + " : " + pair.isCheckedStuffBySet[setName].toString());
    //   }
    //   print("---");
    // }
  }

  // check 또는 uncheck
  void pressStuff(StuffWithCheckPair pair, String setName) {
    pair.toggleBySet(setName);
    ListOfCategoryWrapper.sortEachCategories(listOfCategory, setName);
  }

  void pressCategory(Category category, String setName) {
    category.toggleBySet(setName);
    ListOfCategoryWrapper.changeSet(listOfCategory, setName);
  }

  void pressEdit(bool isEditMode) {

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
  }

  void newStuff(Category category, String stuffName) {
    category.newStuff(stuffName, listOfSet);
  }

  void deleteStuff(Category category, StuffWithCheckPair pair) {
    category.deleteStuff(pair);
  }
}