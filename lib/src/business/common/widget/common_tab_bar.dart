import 'package:flutter/material.dart';

class CommonTabBar extends StatelessWidget {
  final List<TabBarItem> items;
  final void Function(int, TabBarItem) onTap;
  final int initialIndex;

  const CommonTabBar({
    super.key,
    required this.items,
    required this.initialIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(context).tabBarTheme.labelStyle;
    final unselectedLabelStyle = Theme.of(context).tabBarTheme.unselectedLabelStyle;
    return DefaultTabController(
      length: items.length,
      initialIndex: initialIndex,
      child: TabBar(
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        indicatorColor: Colors.pink,
        padding: EdgeInsets.zero,
        labelPadding: EdgeInsets.only(right: 20, bottom: 5),
        tabs: List.generate(items.length, (index) {
          final item = items[index];
          return Builder(builder: (ctx) => HoverTextTab(item.title, DefaultTabController.of(ctx), index, unselectedLabelStyle, labelStyle));
        }),
        dividerColor: Colors.transparent,
        onTap: (index) {
          onTap(index, items[index]);
        },
      ),
    );
  }
}

class HoverTextTab extends StatefulWidget {
  final String text;
  final TabController? tabController;
  final int tabIndex;
  final TextStyle? style;
  final TextStyle? hoveredStyle;

  const HoverTextTab(this.text, this.tabController, this.tabIndex, this.style, this.hoveredStyle);

  @override
  State<HoverTextTab> createState() => _HoverTextTabState();
}

class _HoverTextTabState extends State<HoverTextTab> {
  bool _hovering = false;

  @override
  void initState() {
    super.initState();

    widget.tabController?.addListener((){
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final selected = widget.tabController?.index == widget.tabIndex;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: Text(
        widget.text,
        style: (_hovering || selected) ? widget.hoveredStyle : widget.style,
      ),
    );
  }
}

class TabBarItem {
  final String title;
  final String tag;

  TabBarItem(this.title, this.tag);
}
