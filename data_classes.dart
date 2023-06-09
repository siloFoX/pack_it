void main() {
  SetDataHandler setDataHandler = SetDataHandler();
  print("It works");
}

class StuffWithCheckPair {
  String stuff;
  Map<String, bool> isCheckedStuffBySet = {};
  
  StuffWithCheckPair({
    required this.stuff,
  });
  
  void checkBySet (String setName) {
    isCheckedStuffBySet[setName] = true;
  }
  
  void uncheckBySet (String setName) {
    isCheckedStuffBySet[setName] = false;
  }
  
  void newSetStuffSetting (String setName) {
    
  }
  
  // TODO : 비교연산자 만들어야 함
}

class Category {
  String categoryName;
  List<StuffWithCheckPair> listOfPair = [];
  Map<String, bool> isCheckedCategoryBySet = {};
  
  Category({
    required this.categoryName,
  });
  
  void checkBySet (String setName) {
    isCheckedCategoryBySet[setName] = true;
  }
  
  void uncheckBySet (String setName) {
    isCheckedCategoryBySet[setName] = false;
  }
  
  void newSetCategorySetting (String setName) {
    
  }
  
  void sortListOfPair () {
    
  }
  
  // TODO : 비교연산자 만들어야 함
}

class ListOfCategoryWrapper {
  static void sortListOfCategory(List<Category> listOfCategory) {
    // 리스트를 정렬하는 작업 수행
  }
}

class SetDataHandler {
  List<String> listOfSet = [];
  List<Category> listOfCategory = [];
  
  SetDataHandler () {
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
    
    // TODO : sort listOfCategory
    
    // Make '회사' category's stuff
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
    
    // TODO : sort listOfPair
    
    for (int stuffIdx = 0; stuffIdx < companyListOfStuffLength; stuffIdx++) {
      print(listOfCategory[0].listOfPair[stuffIdx].stuff);
    }
  }
  
  void sortListOfCategory () {
    ListOfCategoryWrapper.sortListOfCategory(listOfCategory);
  }
}