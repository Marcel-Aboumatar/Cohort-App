import 'package:flutter/material.dart';

import '../tab_item/tab_item_widget.dart';

class TabGroupWidget extends StatefulWidget {
  const TabGroupWidget({
    super.key,
    this.label1 = 'My Friends',
    this.label2 = 'Requests',
    this.label2Present = true,
    this.label3 = 'Add New',
    this.label3Present = true,
    this.label4 = '',
    this.label4Present = false,
    this.label5 = '',
    this.label5Present = false,
    this.initialIndex = 0,
    this.onTabChanged,
  });

  final String label1;
  final String label2;
  final bool label2Present;
  final String label3;
  final bool label3Present;
  final String label4;
  final bool label4Present;
  final String label5;
  final bool label5Present;

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

    final tabs = <String>[
      widget.label1,
      if (widget.label2Present) widget.label2,
      if (widget.label3Present) widget.label3,
      if (widget.label4Present) widget.label4,
      if (widget.label5Present) widget.label5,
    ];

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