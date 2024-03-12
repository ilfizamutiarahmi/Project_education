import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_education/main.dart';
import 'package:project_education/view/Register.dart';
import 'package:project_education/view/listBerita.dart';

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      body: {'email': email, 'password': password},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to login');
    }
  }
}



class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final ApiService apiService = ApiService(baseUrl: 'http://127.0.0.1:8000/api');
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _login() async {
    final email = emailController.text;
    final password = passwordController.text;

    try {
      final response = await apiService.login(email, password);

     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ListBerita()));
      print('Login successful: $response');
    } catch (e) {

      print('Login failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Welcome to Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
            ),
            SizedBox(height: 16),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password', border: OutlineInputBorder()),
            ),
            SizedBox(height: 16),
            MaterialButton(
              onPressed: _login,
              color: Colors.green,
              child: Text('Login', style: TextStyle(color: Colors.white),)),
            SizedBox(height: 17),
            TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterPage()));
                },
                child: Text('Register Page')),

          ],
        ),
      ),
    );
  }
}
