import 'package:flutter/material.dart';
import 'package:workspace/core/utils/app_colors.dart';
import 'package:workspace/core/utils/app_images.dart';
import 'package:workspace/core/components/app_bar.dart';
import 'package:workspace/features/auth/model/user_model.dart';
import 'package:workspace/core/components/app_network_image.dart';

class EmployeeDetailPage extends StatefulWidget {
  const EmployeeDetailPage({super.key, required this.userModel});
  final UserModel userModel;

  @override
  State<EmployeeDetailPage> createState() => _EmployeeDetailPageState();
}

class _EmployeeDetailPageState extends State<EmployeeDetailPage> {
  bool showPassword = false;
  UserModel? userModel;

  @override
  void initState() {
    super.initState();
    userModel = widget.userModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Profile',
        onBackTap: () => Navigator.pop(context),
      ),
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 50),
                height: MediaQuery.of(context).size.height * 0.18,
                color: AppColors.blue,
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Center(
                  child: Container(
                    width: 150,
                    height: 150,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(150),
                    ),
                    child: AppCachedImage(AppImages.demoAvaterURL, radius: 100),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Center(
            child: Text(
              userModel?.name ?? '',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          Center(child: Text(userModel?.position ?? 'N/A')),
          SizedBox(height: 20),
          _buildItem('First Name', userModel?.name ?? 'N/A'),
          _buildDivider(),
          _buildItem('Last Name', userModel?.name ?? 'N/A'),
          _buildDivider(),
          InkWell(
            onTap: () async {
              setState(() => showPassword = !showPassword);
              await Future.delayed(const Duration(seconds: 3));
              setState(() => showPassword = false);
            },
            child: _buildItem(
              'Password',
              showPassword ? userModel?.password ?? '' : '*********',
            ),
          ),
          _buildDivider(),
          _buildItem('Position', userModel?.position ?? 'N/A'),
          _buildDivider(),
          _buildItem('Department', userModel?.department ?? 'N/A'),
          _buildDivider(),
          _buildItem('Birthday', 'N/A'),
          _buildDivider(),
          _buildItem('Personal E-mail', userModel?.email ?? 'N/A'),
          _buildDivider(),
          _buildItem('Company E-mail', userModel?.email ?? 'N/A'),
        ],
      ),
    );
  }

  Container _buildDivider() {
    return Container(
      height: 1,
      width: double.maxFinite,
      color: AppColors.grey,
      margin: EdgeInsets.symmetric(horizontal: 40),
    );
  }

  Padding _buildItem(String key, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(key, style: TextStyle(color: AppColors.grey)),
          Text(value, style: TextStyle(color: AppColors.grey)),
        ],
      ),
    );
  }
}
