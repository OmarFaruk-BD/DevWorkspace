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
import 'package:workspace/features/auth/screen/login_page.dart';
import 'package:workspace/core/components/app_network_image.dart';
import 'package:workspace/features/auth/service/auth_service.dart';

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
    final user1 = context.read<AuthCubit>().state.user;
    userModel = user1;
    setState(() {});
    final user2 = await AuthService().getUserProfile();
    final user3 = UserModel(
      firstName: user1?.firstName ?? user2?.firstName,
      lastName: user1?.lastName ?? user2?.lastName,
      username: user1?.username ?? user2?.username,
      email: user1?.email ?? user2?.email,
      companyEmail: user1?.companyEmail ?? user2?.companyEmail,
      position: user1?.position ?? user2?.position,
      department: user1?.department ?? user2?.department,
      workingYears: user1?.workingYears ?? user2?.workingYears,
    );
    userModel = user3;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Profile',
        hasMenuButton: false,
        onBackTap: () => Navigator.pop(context),
      ),
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 50),
                height: MediaQuery.of(context).size.height * 0.18,
                color: AppColors.red,
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
              userModel?.username ?? '',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          Center(child: Text(userModel?.position ?? 'N/A')),
          SizedBox(height: 20),
          _buildItem('First Name', userModel?.firstName ?? 'N/A'),
          _buildDivider(),
          _buildItem('Last Name', userModel?.lastName ?? 'N/A'),
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
          _buildItem('Company E-mail', userModel?.companyEmail ?? 'N/A'),
          _buildDivider(),
          _buildItem('Working years', userModel?.workingYears ?? 'N/A'),
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
    AppNavigator.pushAndRemoveUntil(context, const LoginPage());
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
