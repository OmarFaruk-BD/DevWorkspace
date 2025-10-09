import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workspace/core/utils/app_colors.dart';
import 'package:workspace/core/utils/app_images.dart';
import 'package:workspace/core/helper/navigation.dart';
import 'package:workspace/core/components/app_bar.dart';
import 'package:workspace/core/components/app_popup.dart';
import 'package:workspace/core/components/app_button.dart';
import 'package:workspace/features/auth/cubit/auth_cubit.dart';
import 'package:workspace/features/auth/model/user_model.dart';
import 'package:workspace/core/components/approval_popup.dart';
import 'package:workspace/core/components/app_network_image.dart';
import 'package:workspace/features/auth/service/auth_service.dart';
import 'package:workspace/features/admin/screen/admin_login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserModel? userModel;

  @override
  void initState() {
    super.initState();
    _getProfile();
  }

  void _getProfile() async {
    userModel = context.read<AuthCubit>().state.user;
    setState(() {});
    final user2 = await AuthService().getUserProfile();
    userModel = user2;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarV2(
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
                color: AppColors.primary,
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
          _buildItem('Password', '*********'),
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
          Padding(
            padding: const EdgeInsets.all(35),
            child: AppButton(
              text: 'Sign Out',
              onTap: () {
                AppPopup.show(
                  context: context,
                  child: ApprovalWidget(
                    onApprove: () => _signOut(context),
                    title: 'Sign Out',
                    description: 'Are you sure you want to sign out?',
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _signOut(BuildContext context) async {
    context.read<AuthCubit>().signOut();
    await AuthService().removeData();
    if (!context.mounted) return;
    AppNavigator.pushAndRemoveUntil(context, const AdminLoginPage());
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
