import 'package:flutter/material.dart';

class CommonTabBar extends StatelessWidget {
  final List<TabBarItem> items;
  final void Function(TabBarItem) onTap;
  final int initialIndex;

  const CommonTabBar({
    super.key,
    required this.items,
    required this.initialIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: items.length,
      initialIndex: initialIndex,
      child: TabBar(
        tabs: items.map((e) => Tab(text: e.title)).toList(),
        onTap: (index) {
          onTap(items[index]);
        },
      ),
    );
  }
}

class TabBarItem {
  final String title;
  final String tag;

  TabBarItem(this.title, this.tag);
}
