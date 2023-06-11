import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scrollable Dropdown',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Scrollable Dropdown'),
        ),
        // 이 부분에 들어갈 예정
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
                child: Container(
                  child: SingleChildScrollView(
                    child: ScrollableDropdown(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScrollableDropdown extends StatefulWidget {
  @override
  _ScrollableDropdownState createState() => _ScrollableDropdownState();
}

class _ScrollableDropdownState extends State<ScrollableDropdown> {
  // 여기를 대체해서 handler 가 들어감
  // List<DropdownItemModel> _selectedDropdownItems = [];
  // List<DropdownItemModel> _dropdownItems = [
  //   DropdownItemModel(value: '외출(기본)', items: ['워치 충전하기', '휴대폰 충전하기', '인공눈물', '락토프리 약', '에어팟', '애플 워치', '틴프 파우치', '휴대폰']),
  //   DropdownItemModel(value: '운동', items: ['Item 4', 'Item 5', 'Item 6']),
  //   DropdownItemModel(value: '숙박', items: ['Item 7', 'Item 8', 'Item 9']),
  //   // Add additional dropdown items here.
  // ];
  late DataHandler dataHandler;
  late String selectedSet;
  
  // initState 부분은 DB 에서 가져올 부분을 위해 내버려둠
  @override
  void initState () {
    // _selectedDropdownItems.add(_dropdownItems.first);
    dataHandler = DataHandler();
    selectedSet = dataHandler.listOfSet[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.white,
        highlightColor: Colors.white,
      ),
      child: Column(
        children: dataHandler.listOfCategory.map((eachCategory) {
          bool isSelected = eachCategory.isCheckedCategoryBySet[selectedSet]!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: () => toggleDropdownItem(eachCategory),
                child: Container(
                  height: 28,
                  margin: eachCategory != dataHandler.listOfCategory.first ? const EdgeInsets.only(top: 12) : null,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color : Colors.black,
                      width : 1.0,
                    ),
                  ),
                  child: CustomListTile(
                    pair : null,
                    category : eachCategory.categoryName,
                    fontSize : null,
                  ),
                ),
              ),
              if (isSelected)
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
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
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: eachCategory.listOfPair.length,
                    itemBuilder: (BuildContext context, int idx) {
                      final pair = eachCategory.listOfPair[idx];
                      return Column(
                        children: [
                          Container(
                            height: 19,
                            padding: const EdgeInsets.only(left : 15),
                            child : CustomListTile(
                              pair : pair,
                              fontSize : 8,
                            ),
                          ),
                          if (idx != eachCategory.listOfPair.length - 1)
                            const Divider(
                              height: 1,
                              color: Colors.black,
                            ),
                        ],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) => const SizedBox(), // Empty separator
                  ),
                ),
            ],
          );
        }).toList(),
      ),
    );
  }

  void toggleDropdownItem(Category category) {
    setState(() {
      category.isCheckedCategoryBySet[selectedSet] = !category.isCheckedCategoryBySet[selectedSet]!;
    });
  }

  Widget CustomListTile(StuffWithCheckPair? pair, Category? category, double? fontSize) {
    final bool isChecked = pair != null ? pair.isCheckedStuffBySet[selectedSet]! : category!.isCheckedCategoryBySet[selectedSet]!;
    return Container(
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          const SizedBox(width : 6),
          Icon(
            isChecked ? Icons.check_box_outlined : Icons.check_box_outline_blank,
            size : 10,
            color : isChecked ? Colors.black : Colors.grey,
          ),
          const SizedBox(width : 6),
          Text(
            pair != null ? pair.stuff : category!.categoryName,
            style: TextStyle(
              color : isChecked ? Colors.black : Colors.grey,
              fontSize : fontSize ?? 10,
              fontWeight : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class DropdownItemModel {
  String value;
  List<String> items;

  DropdownItemModel({
    required this.value,
    required this.items,
  });
}

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
      pair.isCheckedStuffBySet[setName] = true;
    }
  }
  
  void uncheckBySet(String setName) {
    isCheckedCategoryBySet[setName] = false;
    for (StuffWithCheckPair pair in listOfPair) {
      pair.isCheckedStuffBySet[setName] = false;
    }
  }
  
  void newSetCategorySetting(List<String> listOfSet) {
    for (String eachSet in listOfSet) {
      isCheckedCategoryBySet[eachSet] = false;
    }
  }

  void setNewStuff(String stuffName, List<String> listOfSet) {
    StuffWithCheckPair newStuff = StuffWithCheckPair(stuff : stuffName, listOfSet : listOfSet);
    listOfPair.insert(0, newStuff);
    sortListOfPairByListOfSet(listOfSet);
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
    
    final int listOfCategoryLength = listOfCategory.length;
    
    // initialize every categories
    listOfCategory[0].checkBySet("회사");
    listOfCategory[0].uncheckBySet("본가");
    listOfCategory[0].uncheckBySet("친구");
    listOfCategory[0].uncheckBySet("자취방");
    for (int categoryIdx = 1; categoryIdx < listOfCategoryLength; categoryIdx++) {
      for (int setIdx = 0; setIdx < listOfSetLength; setIdx++) {
        listOfCategory[categoryIdx].uncheckBySet(listOfSet[setIdx]);
      }
    }
    
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

    final int companyListOfStuffLength = listOfCategory[0].listOfPair.length;    
    for (int stuffIdx = 0; stuffIdx < companyListOfStuffLength; stuffIdx++) {
      for (int setIdx = 0; setIdx < listOfSetLength; setIdx++) {
        listOfCategory[0].listOfPair[stuffIdx].uncheckBySet(listOfSet[setIdx]);
      }
    }
    
    for (int stuffIdx = 0; stuffIdx < companyListOfStuffLength - 2; stuffIdx++) { 
      listOfCategory[0].listOfPair[stuffIdx].checkBySet("회사");
    }
    listOfCategory[0].listOfPair[companyListOfStuffLength - 2].uncheckBySet("회사");
    listOfCategory[0].listOfPair[companyListOfStuffLength - 1].uncheckBySet("회사");    
    
    initiativeSort();
  }
  
  void initiativeSort() {
    pressOtherSet(listOfSet[0]);
  }

  void pressOtherSet(String setName) {
    ListOfCategoryWrapper.changeSet(listOfCategory, setName);
    for (Category eachCategory in listOfCategory) {
      print(eachCategory.categoryName);
      for (StuffWithCheckPair pair in eachCategory.listOfPair) {
        print(pair.stuff + " : " + pair.isCheckedStuffBySet[setName].toString());
      }
      print("---");
    }
  }

  // check 또는 uncheck
  void pressStuff(String categoryName, String stuffName, String setName) {
    Category category = listOfCategory.firstWhere((eachCategory) => eachCategory.categoryName == categoryName);
    StuffWithCheckPair pair = category.listOfPair.firstWhere((eachPair) => eachPair.stuff == stuffName);

    pair.isCheckedStuffBySet[setName] = !pair.isCheckedStuffBySet[setName]!;
    ListOfCategoryWrapper.sortEachCategories(listOfCategory, setName);
  }

  void pressCategory(String categoryName, String setName) {
    Category category = listOfCategory.firstWhere((eachCategory) => eachCategory.categoryName == categoryName);
    
    category.isCheckedCategoryBySet[setName] = !category.isCheckedCategoryBySet[setName]!;
    ListOfCategoryWrapper.sortEachCategories(listOfCategory, setName);
  }

  // void newCategory(String categoryName, String setName)
  // void deleteCategory(String categoryName)
  // void newStuff(String categoryName, String stuffName, String setName)
  // void deleteStuff(String categoryName, String stuffName)
}