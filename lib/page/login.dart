import 'package:flutter/material.dart';
import 'home.dart';
import 'package:cafa_management/api/auth_service.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading  = false;

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    final authService = AuthService();
    bool success = await authService.login(
        _usernameController.text,
        _passwordController.text
    );
    print(success);
    setState(() {
      _isLoading = false;
    });
    if (success) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => Home()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Login failed. Please try again'),
        duration: Duration(seconds: 3),
      ));
    }
  }


      @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green, Colors.red]//[Color(0xFFA1887F), Color(0xFF8D6E63)],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // โลโก้ชิดบนสุด
            Padding(
              padding: const EdgeInsets.only(top: 50), // ระยะห่างจากขอบบน
              child: Image.asset(
                "images/logo3.png",
                height: 280,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 20),
            // ข้อความ Login
            Text(
              "Login",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                children: [
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: "Username",
                      labelStyle: TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.2),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.2),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            // ปุ่ม Login
            ElevatedButton(
              onPressed: _login,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),

              ),
              child: Text(
                "Login",
                style: TextStyle(fontSize: 18, color: Color(0xFFA1887F)),
              ),
            ),
            Spacer(), //
          ],
        ),
      ),
    );
  }
}
