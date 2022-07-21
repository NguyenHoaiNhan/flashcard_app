import 'dart:collection';
import 'dart:math';

import 'package:english_words/english_words.dart';
import 'package:flashcard_app/models/english_today.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/shared_keys.dart';

class EnglishTodayProvider extends ChangeNotifier {
  final List<EnglishToday> wordList = [];

  EnglishTodayProvider() {
    getEnglishTodayFromNouns();
    notifyListeners();
  }

  List<EnglishToday> get items => wordList;

  void reactItem(int index, bool react) {
    wordList[index].isFavorite = !react;
    notifyListeners();
  }

  void getEnglishTodayFromNouns() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    int wordNum = pref.getInt(SharedKeys.counter) ?? 5;

    // rans chứa danh sách các vị trí các word trong nouns
    List<int> rans = fixedListRandom(len: wordNum, max: nouns.length);

    wordList.clear();

    for (var index in rans) {
      wordList.add(EnglishToday(noun: nouns[index]));
    }

    notifyListeners();

    print("DANH SACH CO: " + wordList.length.toString());
  }

  static List<int> fixedListRandom({int len = 1, int max = 120, int min = 1}) {
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
}
