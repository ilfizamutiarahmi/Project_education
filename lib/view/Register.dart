import 'package:flutter/material.dart';
import 'package:project_education/model/api_service.dart';
import 'package:project_education/view/login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

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
      final user = response['user'];
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registration successful for $name with email $email'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      // Handle registration failure
      print('Registration failed: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registration failed: $e'),
          backgroundColor: Colors.red,
        ),
      );
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
            MaterialButton(
              onPressed: _register,
              child: Text('Register'),
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
