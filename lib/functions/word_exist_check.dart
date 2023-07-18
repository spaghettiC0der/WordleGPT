import 'package:http/http.dart' as http;

Future<bool> isExist(String word) async {
  String apiUrl = 'https://api.dictionaryapi.dev/api/v2/entries/en/$word';
  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}
