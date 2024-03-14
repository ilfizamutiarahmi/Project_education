import 'package:flutter/material.dart';
import 'package:project_education/view/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String?> getUserName() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('user_name');
}

Future<String?> getUserEmail() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('user_email');
}

class ListBerita extends StatefulWidget {
  const ListBerita({super.key});

  @override
  State<ListBerita> createState() => _ListBeritaState();
}

class _ListBeritaState extends State<ListBerita> {
  String? userName;
  String? userEmail;

  @override
  void initState() {
    _loadUserInfo();
    super.initState();
  }

  Future<void> _loadUserInfo() async {
    userName = await getUserName();
    userEmail = await getUserEmail();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to List News Page'),
        backgroundColor: Colors.blue,
        actions: [
          if (userName != null && userEmail != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text(userName!), Text(userEmail!)],
              ),
            ),
          InkWell(
            onTap: () {
              
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset("image/logout.png", height: 50),
            ),
          ),
        ],
      ),
    );
  }
}
