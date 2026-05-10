import 'package:flutter/material.dart';

import '../tab_item/tab_item_widget.dart';

class TabGroupWidget extends StatefulWidget {
  const TabGroupWidget({
    super.key,
    this.labels = const ['My Friends', 'My  Requests'],
    this.initialIndex = 0,
    this.onTabChanged,
  });

  final List<String> labels;
  final int initialIndex;
  final ValueChanged<int>? onTabChanged;

  @override
  State<TabGroupWidget> createState() => _TabGroupWidgetState();
}

class _TabGroupWidgetState extends State<TabGroupWidget> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex;
  }

  void selectTab(int index) {
    setState(() {
      selectedIndex = index;
    });

    widget.onTabChanged?.call(index);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final tabs = widget.labels;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.outlineVariant),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          for (int i = 0; i < tabs.length; i++)
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => selectTab(i),
                child: TabItemWidget(
                  label: tabs[i],
                  selected: selectedIndex == i,
                ),
              ),
            ),
        ],
      ),
    );
  }
}