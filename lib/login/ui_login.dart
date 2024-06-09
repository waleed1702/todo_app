import 'package:todo_app/widgets/textfeild.dart';
import 'package:todo_app/utils/app_colors.dart';
import 'package:todo_app/login/ui_l_login.dart';
import 'package:todo_app/widgets/w_button.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  final uilogic = UILoginLogin();
  Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to ToDo App',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Consumer<UILoginLogin>(
              builder: (context, provider, child) {
                if (provider.id == null) {
                  return const SizedBox();
                } else if (provider.id!.isEmpty) {
                  return const Text('Invalid');
                } else {
                  return const Text('Welcome');
                }
              },
            ),
            TextFeild(
              controller: uilogic.userName,
              label: 'User name',
            ),
            TextFeild(
              controller: uilogic.password,
              label: 'Password',
              obscure: true,
            ),
            Consumer<UILoginLogin>(
              builder: (context, provider, child) {
                return WidgetButton(
                  isEnabled: provider.buttonEnable,
                  label: 'Login',
                  onTap: () async {
                    provider.userName.text = uilogic.userName.text;
                    provider.password.text = uilogic.password.text;
                    await provider.fetchData();
                    if (provider.id != null && provider.id!.isNotEmpty) {
                      Navigator.pushReplacementNamed(context, '/home');
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
