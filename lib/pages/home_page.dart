import 'package:auto_size_text/auto_size_text.dart';
import 'package:flashcard_app/Widgets/app_button.dart';
import 'package:flashcard_app/providers/english_today_provider.dart';
import 'package:flashcard_app/route/route_names.dart';
import 'package:flashcard_app/config/app_assets.dart';
import 'package:flashcard_app/config/app_colors.dart';
import 'package:flashcard_app/config/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  late PageController _pageController;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _pageController = PageController(viewportFraction: .9);
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
          context.read<EnglishTodayProvider>().getEnglishTodayFromNouns();
        },
        backgroundColor: AppColors.primaryColor,
        child: Image.asset(AppAssets.exchange),
      ),
      body: Container(
        width: double.infinity,
        color: AppColors.secondColor,
        child: Consumer<EnglishTodayProvider>(
          builder: (context, value, child) {
            var words = value.wordList;
            return Column(
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
                      itemCount: words.length > 5 ? 6 : words.length,
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
                          rightPart =
                              currentWord.substring(1, currentWord.length);
                        }

                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Material(
                            color: AppColors.primaryColor,
                            elevation: 4,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(24)),
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              child: index >= 5
                                  ? InkWell(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                            RouteNames.allWordsPage,
                                            arguments: words);
                                      },
                                      child: Center(
                                        child: Text(
                                          'Show more...',
                                          style: AppStyles.h4.copyWith(
                                            shadows: const [
                                              Shadow(
                                                color: Colors.black26,
                                                offset: Offset(3, 6),
                                                blurRadius: 6,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        LikeButton(
                                          isLiked: words[index].isFavorite,
                                          onTap: (bool isLike) async {
                                            context
                                                .read<EnglishTodayProvider>()
                                                .reactItem(index, isLike);
                                            return words[index].isFavorite;
                                          },
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          size: 42,
                                          circleColor: const CircleColor(
                                            start: Color(0xff00ddff),
                                            end: Color(0xff0099cc),
                                          ),
                                          bubblesColor: const BubblesColor(
                                            dotPrimaryColor: Color(0xff33b5e5),
                                            dotSecondaryColor:
                                                Color(0xff0099cc),
                                          ),
                                          likeBuilder: (bool isLiked) {
                                            return ImageIcon(
                                              AssetImage(AppAssets.heart),
                                              color: isLiked
                                                  ? Colors.red
                                                  : Colors.white,
                                            );
                                          },
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
                                          padding:
                                              const EdgeInsets.only(top: 24),
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
                          ),
                        );
                      }),
                ),
                Padding(
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
            );
          },
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
                  onTap: () {},
                ),
              ),
              AppButton(
                label: 'Your control',
                onTap: () {
                  Navigator.of(context).pushNamed(RouteNames.controlPage);
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
      curve: Curves.easeIn,
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
}
