import 'package:flutter/material.dart';
import 'package:workspace/core/helper/extention.dart';
import 'package:workspace/core/components/app_bar.dart';
import 'package:workspace/core/components/app_popup.dart';
import 'package:workspace/core/components/app_button.dart';
import 'package:workspace/core/service/app_validator.dart';
import 'package:workspace/core/components/app_snack_bar.dart';
import 'package:workspace/core/components/app_text_field.dart';
import 'package:workspace/features/auth/model/user_model.dart';
import 'package:workspace/core/components/item_selection_popup.dart';
import 'package:workspace/features/admin/service/notification_service.dart';

class EmployeeAddNotificationPage extends StatefulWidget {
  const EmployeeAddNotificationPage({super.key, this.user});
  final UserModel? user;

  @override
  State<EmployeeAddNotificationPage> createState() =>
      _EmployeeAddNotificationPageState();
}

class _EmployeeAddNotificationPageState
    extends State<EmployeeAddNotificationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _taskService = EmployeeNotificationService();
  final AppValidator _validator = AppValidator();
  final _description = TextEditingController();
  final _comments = TextEditingController();
  final _title = TextEditingController();
  final DateTime _date = DateTime.now();
  String _priority = 'Low';
  String _assignedTo = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _assignedTo = widget.user?.id ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AdminAppBar(title: 'Add Employee Task'),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Notification Title'),
                SizedBox(height: 8),
                AppTextField(
                  controller: _title,
                  hintText: 'Enter notification title',
                  validator: _validator.validate,
                ),
                SizedBox(height: 20),
                Text('Notification Description'),
                SizedBox(height: 8),
                AppTextField(
                  controller: _description,
                  hintText: 'Enter notification description',
                  validator: _validator.validate,
                ),
                SizedBox(height: 20),
                Text('Notification Priority'),
                SizedBox(height: 8),
                AppTextField(
                  readOnly: true,
                  controller: TextEditingController(text: _priority),
                  validator: _validator.validate,
                  onTap: () async {
                    await AppPopup.show(
                      context: context,
                      child: ItemSelectionPopUp(
                        selectedItem: _priority,
                        list: const ['Low', 'Medium', 'High'],
                        onSelected: (value) =>
                            setState(() => _priority = value ?? 'Low'),
                      ),
                    );
                  },
                ),
                SizedBox(height: 30),
                AppButton(
                  text: 'Create Notification',
                  isLoading: _isLoading,
                  width: double.maxFinite,
                  onTap: _createTask,
                ),
                SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _createTask() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    final result = await _taskService.createNotification(
      title: _title.text,
      assignedTo: _assignedTo,
      description: _description.text,
      priority: _priority,
      date: _date.toDateString() ?? '',
      comments: _comments.text,
    );
    setState(() => _isLoading = false);
    result.fold((error) => AppSnackBar.show(context, error), (data) {
      AppSnackBar.show(context, data);
    });
  }
}
