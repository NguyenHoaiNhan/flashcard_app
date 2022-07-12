import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:english_words/english_words.dart';
import 'package:flashcard_app/Widgets/app_button.dart';
import 'package:flashcard_app/models/english_today.dart';
import 'package:flashcard_app/pages/all_words_page.dart';
import 'package:flashcard_app/pages/control_page.dart';
import 'package:flashcard_app/values/app_assets.dart';
import 'package:flashcard_app/values/app_colors.dart';
import 'package:flashcard_app/values/app_styles.dart';
import 'package:flashcard_app/values/shared_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  late PageController _pageController;

  List<EnglishToday> words = [];

  List<int> fixedListRandom({int len = 1, int max = 120, int min = 1}) {
    if (len > max || len < min) {
      return [];
    }

    List<int> newList = [];
    Random random = Random();
    int count = 1;

    while (count <= len) {
      int val = random.nextInt(max);
      if (newList.contains(val)) {
        continue;
      } else {
        newList.add(val);
        count++;
      }
    }

    return newList;
  }

  getEnglishToday() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    int WordNum = pref.getInt(SharedKeys.counter) ?? 5;

    // newList chứa danh sách chứa các word
    List<String> newList = [];

    // rans chứa danh sách các vị trí các word trong nouns
    List<int> rans = fixedListRandom(len: WordNum, max: nouns.length);

    for (var index in rans) {
      newList.add(nouns[index]);
    }

    setState(() {
      words = newList.map((e) => EnglishToday(noun: e)).toList();
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _pageController = PageController(viewportFraction: .9);
    getEnglishToday();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.secondColor,
      appBar: AppBar(
        backgroundColor: AppColors.secondColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'English today',
          style: AppStyles.h3.copyWith(
            color: AppColors.textColor,
            fontSize: 36,
          ),
        ),
        leading: InkWell(
          onTap: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          child: Image.asset(AppAssets.menu),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            getEnglishToday();
          });
        },
        backgroundColor: AppColors.primaryColor,
        child: Image.asset(AppAssets.exchange),
      ),
      body: Container(
        width: double.infinity,
        color: AppColors.secondColor,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              height: size.height * 1 / 10,
              alignment: Alignment.centerLeft,
              child: Text(
                '"It is amazing how complete is the delusion that beauty is goodness."',
                style: AppStyles.h5.copyWith(
                  fontSize: 12,
                  color: AppColors.textColor,
                ),
              ),
            ),
            Container(
              height: size.height * 2 / 3,
              color: AppColors.secondColor,
              child: PageView.builder(
                  controller: _pageController,
                  itemCount: words.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    String currentWord = words[index].noun!;
                    String leftPart = '';
                    String rightPart = '';

                    if (currentWord.isNotEmpty) {
                      leftPart = currentWord.substring(0, 1);
                      rightPart = currentWord.substring(1, currentWord.length);
                    }

                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(3, 6),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.centerRight,
                              child: Image.asset(AppAssets.heart),
                            ),
                            RichText(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                text: leftPart.toUpperCase(),
                                style: TextStyle(
                                  fontFamily: FontFamily.sen,
                                  fontSize: 89,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  shadows: const [
                                    BoxShadow(
                                      color: Colors.black38,
                                      offset: Offset(3, 6),
                                      blurRadius: 6,
                                    ),
                                  ],
                                ),
                                children: [
                                  TextSpan(
                                    text: rightPart,
                                    style: TextStyle(
                                      fontFamily: FontFamily.sen,
                                      fontSize: 56,
                                      fontWeight: FontWeight.bold,
                                      shadows: const [
                                        BoxShadow(
                                          color: Colors.black38,
                                          offset: Offset(3, 6),
                                          blurRadius: 6,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 24),
                              child: AutoSizeText(
                                '"Think of all the beauty still left around you and be happy"',
                                maxFontSize: 26,
                                style: AppStyles.h4.copyWith(
                                  letterSpacing: 1,
                                  color: AppColors.textColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            _currentIndex >= 5
                ? buildShowMore()
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SizedBox(
                      height: size.height * 1 / 11,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        alignment: Alignment.center,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return buildIndicator(index == _currentIndex, size);
                          },
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: AppColors.lighBlue,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 16),
                child: Text(
                  'Your mind',
                  style: AppStyles.h3.copyWith(color: AppColors.textColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: AppButton(
                  label: 'Favorites',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ControlPage(),
                      ),
                    );
                  },
                ),
              ),
              AppButton(
                label: 'Your control',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ControlPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIndicator(bool isActive, var size) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutQuad,
      height: 8,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      width: isActive ? size.width * 1 / 5 : 24,
      decoration: BoxDecoration(
        color: isActive ? AppColors.lighBlue : AppColors.lightGrey,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        boxShadow: const [
          BoxShadow(color: Colors.black38, offset: Offset(2, 3), blurRadius: 3),
        ],
      ),
    );
  }

  Widget buildShowMore() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      alignment: Alignment.centerLeft,
      child: Material(
        borderRadius: BorderRadius.circular(18),
        color: AppColors.primaryColor,
        elevation: 5,
        child: InkWell(
          splashColor: Colors.black38,
          borderRadius: BorderRadius.circular(18),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => AllWordsPage(words: words)));
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Text('Show more', style: AppStyles.h5),
          ),
        ),
      ),
    );
  }
}
