import 'package:flutter/material.dart';

class ItemSelectionPopUp extends StatelessWidget {
  const ItemSelectionPopUp({
    super.key,
    this.onSelected,
    this.selectedItem,
    required this.list,
  });

  final List<String> list;
  final String? selectedItem;
  final Function(String?)? onSelected;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(15),
        child: Container(
          padding: const EdgeInsets.all(15),
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.6,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const FilterHeader(),
                const SizedBox(height: 10),
                ...List.generate(
                  list.length,
                  (index) => SizedBox(
                    width: double.infinity,
                    child: PopupItem(
                      title: list[index],
                      isSelected: selectedItem == list[index],
                      onSelected: () {
                        Navigator.pop(context);
                        onSelected?.call(list[index]);
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FilterHeader extends StatelessWidget {
  const FilterHeader({super.key, this.title = 'Select Option'});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(width: 15),
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        InkWell(
          onTap: () => Navigator.pop(context),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text('Close'),
          ),
        ),
      ],
    );
  }
}

class PopupItem extends StatelessWidget {
  const PopupItem({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onSelected,
  });
  final String title;
  final bool isSelected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: InkWell(
        onTap: onSelected,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? Colors.cyan.shade50 : Colors.white,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: isSelected ? Colors.cyan : Colors.grey),
          ),
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
