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
  List<DropdownItemModel> _selectedDropdownItems = [];
  List<DropdownItemModel> _dropdownItems = [
    DropdownItemModel(value: '외출(기본)', items: ['워치 충전하기', '휴대폰 충전하기', '인공눈물', '락토프리 약', '에어팟', '애플 워치', '틴프 파우치', '휴대폰']),
    DropdownItemModel(value: '운동', items: ['Item 4', 'Item 5', 'Item 6']),
    DropdownItemModel(value: '숙박', items: ['Item 7', 'Item 8', 'Item 9']),
    // Add additional dropdown items here.
  ];
  
  @override
  void initState () {
    _selectedDropdownItems.add(_dropdownItems.first);
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
        children: _dropdownItems.map((dropdownItem) {
          bool isSelected = _selectedDropdownItems.contains(dropdownItem);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: () => toggleDropdownItem(dropdownItem),
                child: Container(
                  height: 28,
                  margin: dropdownItem != _dropdownItems.first ? const EdgeInsets.only(top: 12) : null,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color : Colors.black,
                      width : 1.0,
                    ),
                  ),
                  child: CustomListTile(
                    title: dropdownItem.value,
                    isChecked: isSelected,
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
                    itemCount: dropdownItem.items.length,
                    itemBuilder: (BuildContext context, int index) {
                      final item = dropdownItem.items[index];
                      return Column(
                        children: [
                          Container(
                            height: 19,
                            padding: const EdgeInsets.only(left : 15),
                            child : CustomListTile(
                              title : item,
                              isChecked : false,
                              fontSize : 8,
                            ),
                          ),
                          if (index != dropdownItem.items.length - 1)
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

  void toggleDropdownItem(DropdownItemModel dropdownItem) {
    setState(() {
      if (_selectedDropdownItems.contains(dropdownItem)) {
        _selectedDropdownItems.remove(dropdownItem);
      } else {
        _selectedDropdownItems.add(dropdownItem);
      }
    });
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

class CustomListTile extends StatelessWidget {
  final String title;
  final bool isChecked;
  final double? fontSize;

  const CustomListTile({
    required this.title,
    required this.isChecked,
    this.fontSize,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            title,
            style: TextStyle(
              color : isChecked ? Colors.black : Colors.grey,
              fontSize : this.fontSize ?? 10,
              fontWeight : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}