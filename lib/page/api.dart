import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<dynamic>> apiGetBeverages() async {
  var response = await http.get(Uri.parse('https://admin-panel-nine-beige.vercel.app/api/beverages'));
  if (response.statusCode == 200) {
    return jsonDecode(response.body) as List<dynamic>;
  } else {
    throw Exception('Error fetching beverages');
  }
}

Future<List<dynamic>> apiGetDesserts() async {
  var response = await http.get(Uri.parse('https://admin-panel-nine-beige.vercel.app/api/desserts'));
  if (response.statusCode == 200) {
    return jsonDecode(response.body) as List<dynamic>;
  } else {
    throw Exception('Error fetching desserts');
  }
}
