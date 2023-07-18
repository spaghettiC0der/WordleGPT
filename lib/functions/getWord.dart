import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proj3/main.dart';

import '../env/env.dart';

Future<String> sendChatRequest(String message) async {
  final apiKey = Env.KEYY;
  final endpoint = 'https://api.openai.com/v1/chat/completions';
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $apiKey',
  };
  final data = {
    'model': 'gpt-3.5-turbo',
    'messages': [
      {'role': 'user', 'content': message},
    ],
  };
  final jsonPayload = jsonEncode(data);

  var response;
  bool ok = false;

  while (!ok) {
    response = await http.post(
      Uri.parse(endpoint),
      headers: headers,
      body: jsonPayload,
    );

    if (response.statusCode != 200) {
      continue;
    }
    final responseData = await jsonDecode(response.body);
    print(responseData["choices"]);

    return responseData["choices"][0]["message"]["content"];
  }
}

Future<Map> getWord(String category, String frequency) async {
  // print('get word !!!!!!!!!!!!!!!!!!!!!!!!!');
  final userInput =
      'Give a real $frequency frequency word belongs to $category, with the length exactly between 4 and 7, and  with 3 detailed hints describing it. Give it in a json format. JSON should contain 2 fields: word - which is a string, and hints - which is an array of hints. Do not use the word in the hints. Word should not be an abbreviation. ${MyApp.myData.get(category) != null ? 'do not give the following words : ${MyApp.myData.get(category).toString()}' : ''}';

  final response = await sendChatRequest(userInput);

  final reply = json.decode(response);
  print(reply);
  if (MyApp.myData.get(category) == null) {
    MyApp.myData.put(category, []);
  }
  MyApp.myData
      .put(category, [...MyApp.myData.get(category), reply['word'].toString()]);

  return reply;
}
