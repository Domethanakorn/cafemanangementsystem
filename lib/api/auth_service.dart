import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {

  Future<bool> login(String username, String password) async{
    //ฟังกฺฺ์ชันไว้เชื่อมต่อ API
    final response = await http.post(
      Uri.parse('https://admin-panel-nine-beige.vercel.app/api/login'),  // ใช้ 10.0.2.2 แทน localhost
      headers: < String,String >{
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'username': username,
        'password': password,
      }),
    );
    if (response.statusCode == 200){
      print('Login successful');

      return true;
    }else {
      print('Login failed');
      return false;
    }
  }

}
