import 'package:bilibili_desktop/src/business/common/widget/common_tab_bar.dart';
import 'package:bilibili_desktop/src/business/main/search/search_view_model.dart';
import 'package:bilibili_desktop/src/utils/widget_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  @override
  Widget build(BuildContext context) {
    final primaryItems = ref.watch(
      searchViewModelProvider.select((e) => e.items),
    );
    final primaryIndex = ref.watch(
      searchViewModelProvider.select((e) => e.primaryIndex),
    );
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 40),
        child: Column(
          children: [
            CommonTabBar(
              items: primaryItems.map((e) {
                return TabBarItem(
                  e.type.name,
                  e.type.tag,
                  num: e.showNum ? e.total.toString() : null,
                );
              }).toList(),
              labelPadding: const EdgeInsets.only(right: 60, bottom: 5),
              initialIndex: 0,
              onTap: (index, tag) {},
            ),
            10.hSize,
            Divider(
              height: 1,
              thickness: 0.2,
              color: Colors.grey,
            ),
            10.hSize,
            // IndexedStack(
            //   index: primaryIndex,
            //   children: [
            //
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
