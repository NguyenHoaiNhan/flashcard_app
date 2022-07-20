import 'package:flashcard_app/config/app_colors.dart';
import 'package:flashcard_app/route/route_names.dart';
import 'package:flutter/material.dart';

import '../modules/oauth/google_oauth.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lighBlue,
      body: Center(
        child: TextButton(
          onPressed: () {
            Future user = GoogleSignInApi.login();

            user.then((value) {
              print('Login ok');
              Navigator.popAndPushNamed(context, RouteNames.homePage);
            }).catchError((onError) {
              print('Login failed');
            });
          },
          child: const Text(
            'Sign in with Google',
          ),
        ),
      ),
    );
  }
}
