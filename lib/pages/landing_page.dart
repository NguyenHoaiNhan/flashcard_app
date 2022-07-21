import 'package:flashcard_app/route/route_names.dart';
import 'package:flashcard_app/config/app_assets.dart';
import 'package:flashcard_app/config/app_colors.dart';
import 'package:flashcard_app/config/app_styles.dart';
import 'package:flutter/material.dart';

import '../modules/oauth/google_oauth.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Welcome to ',
                  style: AppStyles.h3,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'English',
                    style: AppStyles.h2.copyWith(
                      color: AppColors.blackGrey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      'Quotes"',
                      textAlign: TextAlign.right,
                      style: AppStyles.h4.copyWith(height: .5),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 100),
                child: RawMaterialButton(
                  onPressed: () {
                    Future user = GoogleSignInApi.login();
                    user.then((value) {
                      print('Login successfully');
                      Navigator.pushNamed(context, RouteNames.homePage);
                    }).catchError((onError) {
                      print('Login failed!');
                      Navigator.pushNamed(context, RouteNames.landingPage);
                    });
                  },
                  shape: const CircleBorder(),
                  fillColor: AppColors.lighBlue,
                  child: Image.asset(AppAssets.rightArrow),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
