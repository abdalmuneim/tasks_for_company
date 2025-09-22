import 'package:flutter/material.dart';
import 'package:tab_container/tab_container.dart';

class CustomTabs extends StatefulWidget {
  const CustomTabs({super.key});

  @override
  State<CustomTabs> createState() => _CustomTabsState();
}

class _CustomTabsState extends State<CustomTabs> {
  int selectedIndex = 0;

  final List<IconData> tabIcons = [
    Icons.info_outline,
    Icons.description_outlined,
    Icons.person_outline,
  ];

  final List<String> tabTitles = ["Info", "Documents", "Profile"];

  final List<Widget> tabContents = [
    const Text("Info tab content goes here."),
    const Text("Documents tab content goes here."),
    const Text("Profile tab content goes here."),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: TabContainer(
            tabEdge: TabEdge.right,
            tabsStart: 0.1,
            tabsEnd: 0.9,
            tabMaxLength: 100,
            borderRadius: BorderRadius.circular(10),
            tabBorderRadius: BorderRadius.circular(10),
            childPadding: const EdgeInsets.all(20.0),
            selectedTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 15.0,
            ),
            unselectedTextStyle: const TextStyle(
              color: Colors.black,
              fontSize: 13.0,
            ),
            colors: [Colors.red, Colors.green, Colors.blue],
            tabs: [Text('Tab 1'), Text('Tab 2'), Text('Tab 3')],
            children: [
              Container(child: Text('Child 1')),
              Container(child: Text('Child 2')),
              Container(child: Text('Child 3')),
            ],
          ),
        ),
      ),
    );
  }
}
