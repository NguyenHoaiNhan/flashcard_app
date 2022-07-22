import '../../models/english_today.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class OxfordAPI {
  static const appkey = 'dd2f95553d7735dd2f978e2957ce29d0';
  static const appid = 'b42d43ef';

  static Future<EnglishToday> getWordFromOxford(var word) async {
    late EnglishToday result;

    String url =
        'https://od-api.oxforddictionaries.com:443/api/v2/entries/en-us/';

    url += word.toString().toLowerCase();
    url += '?strictMatch=false&fields=definitions,pronunciations,examples';

    try {
      var response = await http
          .get(Uri.parse(url), headers: {'app_id': appid, 'app_key': appkey});

      if (response.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;

        var resultList = parseResponseForEnglishToday(jsonResponse);

        result = EnglishToday(
            noun: word,
            ipa: resultList[0],
            definition: resultList[1],
            quote: resultList[2],
            category: resultList[3]);
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (err) {
      print(err.toString());
    }

    return result;
  }

  static List<String> parseResponseForEnglishToday(var jsonResponse) {
    List<String> contents = [];

    try {
      String phoneticSpelling = jsonResponse['results'][0]['lexicalEntries'][0]
          ['entries'][0]['pronunciations'][1]['phoneticSpelling'];
      contents.add(phoneticSpelling);

      String definition = jsonResponse['results'][0]['lexicalEntries'][0]
          ['entries'][0]['senses'][0]['definitions'][0];
      contents.add(definition);

      String example = jsonResponse['results'][0]['lexicalEntries'][0]
          ['entries'][0]['senses'][0]['examples'][0]['text'];
      contents.add(example);

      String lexicalCategory = jsonResponse['results'][0]['lexicalEntries'][0]
          ['lexicalCategory']['text'];
      contents.add(lexicalCategory);
    } catch (err) {
      print(err.toString());
      return ['err', 'err', 'err', 'err'];
    }
    return contents;
  }
}
