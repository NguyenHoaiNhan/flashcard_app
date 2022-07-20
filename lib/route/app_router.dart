import 'package:flashcard_app/models/english_today.dart';
import 'package:flashcard_app/pages/all_words_page.dart';
import 'package:flashcard_app/pages/control_page.dart';
import 'package:flashcard_app/pages/home_page.dart';
import 'package:flashcard_app/pages/landing_page.dart';
import 'package:flashcard_app/pages/signin_page.dart';
import 'package:flashcard_app/route/route_names.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case RouteNames.landingPage:
        return MaterialPageRoute(builder: (_) => const LandingPage());

      case RouteNames.homePage:
        return MaterialPageRoute(builder: (_) => const HomePage());

      case RouteNames.favoritePage:
        break;

      case RouteNames.controlPage:
        return MaterialPageRoute(builder: (_) => const ControlPage());

      case RouteNames.allWordsPage:
        if (args is List<EnglishToday>) {
          return MaterialPageRoute(builder: (_) => AllWordsPage(words: args));
        }
        return MaterialPageRoute(builder: (_) => const HomePage());

      case RouteNames.signInPage:
        return MaterialPageRoute(builder: (_) => const SignInPage());

      default:
        return MaterialPageRoute(builder: (_) => const HomePage());
    }

    return MaterialPageRoute(builder: (_) => const HomePage());
  }
}
