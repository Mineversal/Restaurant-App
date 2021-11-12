import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:restaurant/common/styles.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({
    required this.focusNode,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  final ValueChanged<String> onChanged;
  final FocusNode focusNode;

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Styles.searchBackground,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 4,
          vertical: 8,
        ),
        child: Row(
          children: [
            const Icon(
              CupertinoIcons.search,
              color: Styles.searchIconColor,
            ),
            Expanded(
              child: CupertinoTextField(
                controller: controller,
                focusNode: widget.focusNode,
                style: Styles.searchText,
                cursorColor: Styles.searchCursorColor,
                decoration: null,
                onChanged: widget.onChanged,
              ),
            ),
            GestureDetector(
              onTap: controller.clear,
              child: const Icon(
                CupertinoIcons.clear_thick_circled,
                color: Styles.searchIconColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
