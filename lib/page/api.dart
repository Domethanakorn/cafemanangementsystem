import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<dynamic>> apiGetPhotos() async {
  var response =
      await http.get(Uri.parse('http://dummyapi.online/api/pokemon'));
  if (response.statusCode == 200) {
    var list = jsonDecode(response.body) as List<dynamic>;
    var listRang = list.getRange(0,49).toList();
    return listRang;
  } else {
    throw Exception('Error');
  }
}

Future<Map<String, dynamic>> apiGetphoto(int id) async {
  var response =
      await http.get(Uri.parse('http://dummyapi.online/api/pokemon/$id'));
  if (response.statusCode == 200) {
    var map = jsonDecode(response.body) as Map<String, dynamic>;
    return map;
  } else {
    throw Exception('Error');
  }
}