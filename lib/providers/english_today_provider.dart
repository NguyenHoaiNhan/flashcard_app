import 'dart:math';
import 'package:english_words/english_words.dart';
import 'package:flashcard_app/models/english_today.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/shared_keys.dart';
import '../modules/oxford_api/oxford_api.dart';

class EnglishTodayProvider extends ChangeNotifier {
  final List<EnglishToday> wordList = [];

  EnglishTodayProvider() {
    getEnglishTodayFromNouns();
    notifyListeners();
  }

  // EnglishTodayProvider._create() {
  //   print('Call private constructor!');
  // }

  // static Future<EnglishTodayProvider> create() async {
  //   print('Call public constructor!');

  //   var asyncItem = EnglishTodayProvider._create();

  //   asyncItem.wordList = await contructList();

  //   return asyncItem;
  // }

  List<EnglishToday> get items => wordList;

  void reactItem(int index, bool react) {
    wordList[index].isFavorite = !react;
    notifyListeners();
  }

  // static Future<List<EnglishToday>> contructList() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   int wordNum = pref.getInt(SharedKeys.counter) ?? 5;

  //   List<EnglishToday> wordList = [];

  //   // rans chứa danh sách các vị trí các word trong nouns
  //   List<int> rans = fixedListRandom(len: wordNum, max: nouns.length);

  //   for (var index in rans) {
  //     var word = await OxfordAPI.getWordFromOxford(nouns[index]);
  //     wordList.add(word);
  //   }

  //   return wordList;
  // }

  void getEnglishTodayFromNouns() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    int wordNum = pref.getInt(SharedKeys.counter) ?? 5;

    // rans chứa danh sách các vị trí các word trong nouns
    List<int> rans = fixedListRandom(len: wordNum, max: nouns.length);

    wordList.clear();

    for (var index in rans) {
      var word = await OxfordAPI.getWordFromOxford(nouns[index]);
      wordList.add(word);
      print('Calling word: ' + word.noun.toString());
    }

    notifyListeners();
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
