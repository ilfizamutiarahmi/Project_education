import 'package:flutter/material.dart';
import 'package:project_education/model/api_service.dart';

import '../model/sharedpreferences.dart';

class UserProfile extends StatefulWidget {
  final int userId;
  final String userName;
  final String userEmail;
  final ApiService apiService;

  const UserProfile({Key? key, required this.userId, required this.userName, required this.userEmail, required this.apiService,}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

  late TextEditingController _searchController;
  late TextEditingController _nameController;
  late TextEditingController _emailController;


  @override
  void initState() {
    _nameController = TextEditingController(text: widget.userName);
    _emailController = TextEditingController(text: widget.userEmail);
    super.initState();
  }


  void _loadUserProfile() async {
    try {
      // Panggil API atau ambil data dari penyimpanan lokal
      final userProfileData = await widget.apiService.getUserProfile(widget.userId);

      // Pastikan data yang diperoleh memiliki struktur yang tepat
      if (userProfileData.containsKey('name') && userProfileData.containsKey('email')) {
        // Ambil nilai nama dan email dari data pengguna
        final String name = userProfileData['name'];
        final String email = userProfileData['email'];

        // Set nilai Controller dengan data yang diperoleh
        _nameController.text = name;
        _emailController.text = email;
      } else {
        // Tampilkan pesan kesalahan jika struktur data tidak sesuai
        print('Invalid user profile data');
      }
    } catch (error) {
      print('Failed to load user profile: $error');
    }
  }


  void _updateUserProfile() async {
    final updatedName = _nameController.text;
    final updatedEmail = _emailController.text;
    try {
      final response = await widget.apiService.updateUser(widget.userId, updatedName, updatedEmail);
      final user = response['user'] as Map<String, dynamic>;
      SharedPreferencesHelper.saveUserProfile(user);
      Navigator.pop(context, {'success': true, 'updatedName': updatedName, 'updatedEmail': updatedEmail});
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Update Data Profile Berhasil",),
        backgroundColor: Colors.green,));
    } catch (error) {
      // Tampilkan pesan gagal
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
        actions: [
          IconButton(onPressed: (){
            _searchController.clear();
          }, icon: Icon(Icons.refresh))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _updateUserProfile,
              child: Text('Edit'),
            )
          ],
        ),
      ),


    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
