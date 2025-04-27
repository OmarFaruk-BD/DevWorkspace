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
                const SizedBox(height: 10),
                const Text(
                  'Select Option',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                ...List.generate(
                  list.length,
                  (index) => CheckboxListTile(
                    title: Text(
                      list[index],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    value: selectedItem == list[index],
                    onChanged: (value) {
                      Navigator.pop(context);
                      onSelected?.call(list[index]);
                    },
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

// class ItemSelectionPopUpV2 extends StatefulWidget {
//   const ItemSelectionPopUpV2({
//     super.key,
//     this.onSelected,
//     this.selectedItem,
//     required this.list,
//   });

//   final List<String> list;
//   final String? selectedItem;
//   final Function(String?)? onSelected;

//   @override
//   State<ItemSelectionPopUpV2> createState() => _ItemSelectionPopUpV2State();
// }

// class _ItemSelectionPopUpV2State extends State<ItemSelectionPopUpV2> {
//   final controller = TextEditingController();
//   List<String> searchItemList = [];
//   List<String> allItemList = [];

//   @override
//   void initState() {
//     super.initState();
//     allItemList = widget.list;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Card(
//         margin: const EdgeInsets.all(15),
//         child: Container(
//           padding: const EdgeInsets.all(15),
//           constraints: BoxConstraints(
//             maxHeight: MediaQuery.of(context).size.height * 0.75,
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Text(
//                 'Select Option',
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.black,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               const SizedBox(height: 10),
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(4),
//                   border: Border.all(color: Colors.grey),
//                 ),
//                 child: ListTile(
//                   dense: true,
//                   leading: const Icon(Icons.search),
//                   title: TextFormField(
//                     controller: controller,
//                     decoration: const InputDecoration(
//                       hintText: 'Search',
//                       isDense: true,
//                       border: InputBorder.none,
//                       contentPadding: EdgeInsets.all(0),
//                     ),
//                     onChanged: _onSearchTextChanged,
//                   ),
//                   trailing: InkWell(
//                     onTap: () {
//                       controller.clear();
//                       _onSearchTextChanged('');
//                     },
//                     child: const Icon(Icons.cancel),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               Expanded(
//                 child: searchItemList.isNotEmpty || controller.text.isNotEmpty
//                     ? ListView.builder(
//                         padding: EdgeInsets.zero,
//                         itemCount: searchItemList.length,
//                         itemBuilder: (context, index) {
//                           return _buildItem(searchItemList[index]);
//                         },
//                       )
//                     : ListView.builder(
//                         padding: EdgeInsets.zero,
//                         itemCount: allItemList.length,
//                         itemBuilder: (context, index) {
//                           return _buildItem(allItemList[index]);
//                         },
//                       ),
//               ),
//               const SizedBox(height: 10),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   _onSearchTextChanged(String text) async {
//     searchItemList.clear();
//     if (text.isEmpty) {
//       setState(() {});
//       return;
//     }
//     for (var item in allItemList) {
//       if (item.toLowerCase().contains(text) || item.contains(text)) {
//         searchItemList.add(item);
//       }
//     }
//     setState(() {});
//   }

//   Widget _buildItem(String item) {
//     return CheckboxListTile(
//       title: Text(
//         item,
//         style: const TextStyle(
//           fontSize: 16,
//           color: Colors.black,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//       value: item == widget.selectedItem,
//       onChanged: (value) {
//         widget.onSelected?.call(item);
//         Navigator.pop(context);
//       },
//     );
//   }
// }
