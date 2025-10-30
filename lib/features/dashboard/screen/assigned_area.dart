import 'package:flutter/material.dart';
import 'package:workspace/core/components/app_bar.dart';
import 'package:workspace/features/auth/model/user_model.dart';
import 'package:workspace/core/components/loading_or_empty.dart';
import 'package:workspace/features/area/model/my_area_model.dart';
import 'package:workspace/features/admin/service/e_attendance_service.dart';

class MyAssignedArea extends StatefulWidget {
  const MyAssignedArea({super.key, this.user});
  final UserModel? user;

  @override
  State<MyAssignedArea> createState() => _MyAssignedAreaState();
}

class _MyAssignedAreaState extends State<MyAssignedArea> {
  final EAssignLocationService _service = EAssignLocationService();
  List<MyAreaModel> areas = [];
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    getAssignedLocation();
  }

  void getAssignedLocation() async {
    setState(() => isLoading = true);
    areas = await _service.getAllAssignLocationsByEmployee(
      widget.user?.id ?? '',
    );
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'My Assigned Area'),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          LoadingOrEmptyText(
            isLoading: isLoading,
            isEmpty: areas.isEmpty,
            emptyText: 'No assigned area found.',
          ),
          ...List.generate(areas.length, (index) {
            final area = areas[index];
            return ListTile(
              title: Text(area.start ?? ''),
              subtitle: Text(area.end ?? ''),
            );
          }),
        ],
      ),
    );
  }
}
