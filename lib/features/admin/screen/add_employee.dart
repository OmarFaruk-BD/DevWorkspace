import 'package:flutter/material.dart';
import 'package:workspace/core/utils/app_styles.dart';
import 'package:workspace/core/components/app_bar.dart';
import 'package:workspace/core/components/app_button.dart';
import 'package:workspace/core/service/app_validator.dart';
import 'package:workspace/core/components/app_text_field.dart';

class AddEmployeePage extends StatefulWidget {
  const AddEmployeePage({super.key});

  @override
  State<AddEmployeePage> createState() => _AddEmployeePageState();
}

class _AddEmployeePageState extends State<AddEmployeePage> {
  final TextEditingController _departmentTEC = TextEditingController();
  final TextEditingController _positionTEC = TextEditingController();
  final TextEditingController _passwordTEC = TextEditingController();
  final TextEditingController _phoneTEC = TextEditingController();
  final TextEditingController _emailTEC = TextEditingController();
  final TextEditingController _nameTEC = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AppValidator _validator = AppValidator();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Add Employee', hasBackButton: false),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(25),
            children: [
              Text('Employee Name', style: AppStyles.mediumGrey),
              const SizedBox(height: 12),
              AppTextField(
                controller: _nameTEC,
                hintText: 'Enter Employee Name',
                validator: _validator.validateName,
              ),
              SizedBox(height: 20),
              AppTextField(
                controller: _emailTEC,
                hintText: 'Enter Employee Email',
                validator: _validator.validateEmail,
              ),
              SizedBox(height: 20),
              AppTextField(
                controller: _passwordTEC,
                hintText: 'Enter Employee Password',
                validator: _validator.validatePassword,
              ),
              SizedBox(height: 20),
              AppTextField(
                controller: _positionTEC,
                hintText: 'Enter Employee Position',
                validator: _validator.validate,
              ),
              SizedBox(height: 20),
              AppTextField(
                controller: _phoneTEC,
                hintText: 'Enter Employee Phone',
                validator: _validator.validatePhoneNo,
                textInputType: TextInputType.phone,
              ),
              SizedBox(height: 20),
              AppTextField(
                controller: _departmentTEC,
                hintText: 'Enter Employee Department',
                validator: _validator.validate,
              ),
              const SizedBox(height: 30),
              AppButton(
                isLoading: isLoading,
                onTap: _createEmployee,
                text: 'Create Employee',
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  void _createEmployee() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => isLoading = false);
  }
}
