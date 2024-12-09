import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:mobile_clean_check/core/theme/themes.dart';
import 'package:mobile_clean_check/data/cubits/cubits.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic> userInfo = {};

  @override
  void initState() {
    super.initState();
    _getUserInfo();
  }

  Future<void> _getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user_json');
    if (userJson != null) {
      setState(() => userInfo = jsonDecode(userJson));
    }
  }

  final primaryColor = ColorSchemes.primary;
  final whiteColor = ColorSchemes.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CcAppBarWidget(title: 'Perfil'),
      body: CcHeaderTemplate(
        header: _buildHeader(),
        content: _buildContent(),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: whiteColor,
            foregroundColor: primaryColor,
            child: Text(userInfo['name']?[0] ?? 'N',
                style: const TextStyle(fontSize: 32)),
          ),
          Text(
            userInfo['name'],
            style: TextStyle(fontSize: 24, color: whiteColor),
          ),
          const SizedBox(height: 4.0),
          Text(
            userInfo['role']['description'],
            style: TextStyle(fontSize: 16, color: whiteColor),
          ),
          const SizedBox(height: 16.0),
          Text(userInfo['email'], style: TextStyle(color: whiteColor)),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CcButtonWidget(
            label: 'Cerrar sesión',
            isLoading: false,
            onPressed: () => _logout(),
            buttonType: ButtonType.elevated,
          ),
        ],
      ),
    );
  }

  void _logout() {
    context.read<AuthCubit>().logout();
    Navigator.of(context, rootNavigator: true).pushNamed('/');
  }
}
