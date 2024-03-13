import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


import 'package:project_education/view/login.dart';

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<Map<String, dynamic>> register(String name,String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      body: {'name': name, 'email': email, 'password': password},
    );

    final decodedResponse = json.decode(response.body);
    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to Register');
    }
  }
}


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final ApiService apiService = ApiService(baseUrl: 'http://127.0.0.1:8000/api');
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _register() async {
    final name = nameController.text;
    final email = emailController.text;
    final password = passwordController.text;

    try {
      final response = await apiService.register(name, email, password);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
      final user = response['user'];
      final userName = user['name'];
      final userEmail = user['email'];
      print('Registration successful for $userName with email $userEmail');

    } catch (e) {
      // Handle registration failure
      print('Registration failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to Register Page'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name', border: OutlineInputBorder()),
            ),
            SizedBox(height: 16),
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
            MaterialButton(onPressed: _register,
            child: Text('Register'),
            color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
