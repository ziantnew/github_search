import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterSelectBox extends ConsumerStatefulWidget {
  const FilterSelectBox({
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  final ValueChanged<String>? onChanged;

  @override
  _FilterSelectBoxState createState() => _FilterSelectBoxState();
}

class _FilterSelectBoxState extends ConsumerState<FilterSelectBox> {
  late String selectedItem = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> items = ['Best Match(기본 선택)', 'Most Stars', 'Recently Updated'];

    return Container(
      margin: const EdgeInsets.fromLTRB(18, 30, 18, 5),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey, style: BorderStyle.solid, width: 0.80),
      ),
      // dropdown below..
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          isExpanded: false,
          items: items.map(
                (item) => DropdownMenuItem<String>(
              value: item.isNotEmpty ? item : '',
              child: Text(
                item,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ).toList(),
          value: selectedItem.isNotEmpty ? selectedItem : items[0],
          onChanged: (value) {
            setState(() {
              selectedItem = value as String;
              widget.onChanged!(selectedItem);
            });
          },
        ),
      ),
    );
  }
}
