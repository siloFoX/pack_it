void main() {
  SetDataHandler setDataHandler = SetDataHandler();
  List<String> listOfSet = setDataHandler.listOfSet;
  String thisSetName = listOfSet[0];
  String thisCategoryName = setDataHandler.listOfCategory[0].categoryName;
  String thisStuffName = setDataHandler.listOfCategory[0].listOfPair[0].stuff;
  // setDataHandler.pressOtherSet(thisSetName);
  setDataHandler.pressStuff(thisCategoryName, thisStuffName, thisSetName);
  setDataHandler.pressOtherSet(thisSetName);
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

  // void newCategory(String categoryName, String setName)
  // void deleteCategory(String categoryName)
  // void newStuff(String categoryName, String stuffName, String setName)
  // void deleteStuff(String categoryName, String stuffName)
}