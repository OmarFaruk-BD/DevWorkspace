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
import 'package:workspace/features/admin/service/employee_task_service.dart';

class AddEmployeeTaskPage extends StatefulWidget {
  const AddEmployeeTaskPage({super.key, this.user});
  final UserModel? user;

  @override
  State<AddEmployeeTaskPage> createState() => _AddEmployeeTaskPageState();
}

class _AddEmployeeTaskPageState extends State<AddEmployeeTaskPage> {
  final EmployeeTaskService _taskService = EmployeeTaskService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AppValidator _validator = AppValidator();
  final _description = TextEditingController();
  final _comments = TextEditingController();
  final _client = TextEditingController();
  final _amount = TextEditingController();
  final _title = TextEditingController();
  DateTime _dueDate = DateTime.now();
  final String _status = 'Pending';
  final String _attachments = '';
  String _taskType = 'Sales';
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
                Text('Task Title'),
                SizedBox(height: 8),
                AppTextField(
                  controller: _title,
                  hintText: 'Enter task title',
                  validator: _validator.validate,
                ),
                SizedBox(height: 20),
                Text('Task Description'),
                SizedBox(height: 8),
                AppTextField(
                  controller: _description,
                  hintText: 'Enter task description',
                  validator: _validator.validate,
                ),
                SizedBox(height: 20),
                Text('Client Name (Optional)'),
                SizedBox(height: 8),
                AppTextField(
                  controller: _client,
                  hintText: 'Enter client name',
                ),
                SizedBox(height: 20),
                Text('Target Amount (Optional)'),
                SizedBox(height: 8),
                AppTextField(
                  controller: _amount,
                  hintText: 'Enter target amount',
                  textInputType: TextInputType.number,
                ),
                SizedBox(height: 20),
                Text('Comments (Optional)'),
                SizedBox(height: 8),
                AppTextField(controller: _comments, hintText: 'Enter comments'),
                SizedBox(height: 20),
                Text('Due Date'),
                SizedBox(height: 8),
                AppTextField(
                  readOnly: true,
                  controller: TextEditingController(
                    text: _dueDate.toDateString(),
                  ),
                  validator: _validator.validate,
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: _dueDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (date != null) {
                      setState(() => _dueDate = date);
                    }
                  },
                ),
                SizedBox(height: 20),
                Text('Task Type'),
                SizedBox(height: 8),
                AppTextField(
                  readOnly: true,
                  controller: TextEditingController(text: _taskType),
                  validator: _validator.validate,
                  onTap: () async {
                    await AppPopup.show(
                      context: context,
                      child: ItemSelectionPopUp(
                        selectedItem: _taskType,
                        list: const ['Sales', 'Marketing', 'Support'],
                        onSelected: (value) =>
                            setState(() => _taskType = value ?? 'Sales'),
                      ),
                    );
                  },
                ),
                SizedBox(height: 20),
                Text('Task Priority'),
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
                  text: 'Assign Task',
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
    final result = await _taskService.createTask(
      status: _status,
      title: _title.text,
      assignedTo: _assignedTo,
      description: _description.text,
      priority: _priority,
      taskType: _taskType,
      client: _client.text,
      amount: _amount.text,
      dueDate: _dueDate.toDateString() ?? '',
      comments: _comments.text,
      attachments: _attachments,
    );
    setState(() => _isLoading = false);
    result.fold((error) => AppSnackBar.show(context, error), (data) {
      AppSnackBar.show(context, data);
    });
  }
}
