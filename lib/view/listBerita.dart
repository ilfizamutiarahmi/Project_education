import 'package:flutter/material.dart';
import 'package:project_education/view/login.dart';

class ListBerita extends StatefulWidget {
  const ListBerita({super.key});

  @override
  State<ListBerita> createState() => _ListBeritaState();
}

class _ListBeritaState extends State<ListBerita> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to List News Page'),
        backgroundColor: Colors.blue,
        actions: [
          InkWell(
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
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
