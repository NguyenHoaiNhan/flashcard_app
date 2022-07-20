import 'package:flashcard_app/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/app_assets.dart';
import '../config/app_styles.dart';
import '../config/shared_keys.dart';

class ControlPage extends StatefulWidget {
  const ControlPage({Key? key}) : super(key: key);

  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  double sliderValue = 5;
  late SharedPreferences prefs;

  getStoredWordCount() async {
    prefs = await SharedPreferences.getInstance();
    int value = prefs.getInt(SharedKeys.counter) ?? 5;
    setState(() {
      sliderValue = value.toDouble();
    });
  }

  @override
  void initState() {
    super.initState();
    getStoredWordCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondColor,
      appBar: AppBar(
        backgroundColor: AppColors.secondColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Your control',
          style: AppStyles.h3.copyWith(
            color: AppColors.textColor,
            fontSize: 36,
          ),
        ),
        leading: InkWell(
          onTap: () async {
            Navigator.pop(context);
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setInt(SharedKeys.counter, sliderValue.toInt());
          },
          child: Image.asset(AppAssets.leftArrow),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            const Spacer(),
            Text(
              'How much a number word at at once?',
              style: AppStyles.h4.copyWith(
                color: AppColors.lightGrey,
                fontSize: 14,
              ),
            ),
            const Spacer(),
            Text(
              '${sliderValue.toInt()}',
              style: AppStyles.h1.copyWith(
                color: AppColors.primaryColor,
                fontSize: 150,
                fontWeight: FontWeight.bold,
              ),
            ),
            Slider(
              value: sliderValue,
              min: 5,
              max: 100,
              divisions: 95,
              activeColor: AppColors.primaryColor,
              inactiveColor: AppColors.primaryColor,
              onChanged: (value) {
                setState(() {
                  sliderValue = value;
                });
              },
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              alignment: Alignment.centerLeft,
              child: Text(
                'slide to set',
                style: AppStyles.h5.copyWith(
                  color: AppColors.textColor,
                ),
              ),
            ),
            const Spacer(),
            const Spacer(),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
