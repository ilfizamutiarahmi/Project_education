import 'package:flutter/material.dart';
import 'package:project_education/model/model_berita.dart'; // Pastikan untuk mengganti dengan nama file yang sesuai dengan model Anda
import 'package:http/http.dart' as http;
import 'package:project_education/view/listKaryawan.dart';
import 'package:project_education/view/login.dart';
import 'package:project_education/view/user_profile.dart';
import '../model/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/sharedpreferences.dart';

Future<String?> getUserName() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('user_name');
}

Future<String?> getUserEmail() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('user_email');
}

class Home extends StatefulWidget {
  final int userId;
  final ApiService apiService;

  const Home({Key? key, required this.userId, required this.apiService}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? userName;
  String? userEmail;
  int _currentIndex = 0;
  List<Datum> _beritaList = [];
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
    _searchController = TextEditingController();
    _fetchBerita();
  }

  void _goToUserProfile() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserProfile(
          userId: widget.userId,
          userName: userName!,
          userEmail: userEmail!,
          apiService: ApiService(baseUrl: 'http://127.0.0.1:8000/api'),
        ),
      ),
    );

    // Setelah kembali dari UserProfile, perbarui data pengguna jika ada perubahan
    if (result != null && result['success'] == true) {
      _loadUserInfo();
    }
  }



  Future<void> _loadUserInfo() async {
    try {
      final String? name = await SharedPreferencesHelper.getUserName();
      final String? email = await SharedPreferencesHelper.getUserEmail();
      if (name != null && email != null) {
        setState(() {
          userName = name;
          userEmail = email;
        });
      } else {
        print('Failed to load user info');
      }
    } catch (error) {
      print('Error loading user info: $error');
    }
  }





  Future<void> _fetchBerita() async {
    try {
      http.Response res = await http.get(
        Uri.parse('http://127.0.0.1:8000/api/berita'),
      );
      if (res.statusCode == 200) {
        setState(() {
          _beritaList = modelBeritaFromJson(res.body).result;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  void _filterBeritaList(String query) {
    List<Datum> filteredBeritaList = _beritaList
        .where((berita) =>
    berita.title.toLowerCase().contains(query.toLowerCase()) ||
        berita.content.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {
      _beritaList = filteredBeritaList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Education'),
        backgroundColor: Color.fromARGB(255, 97, 143, 192),
        actions: [
          IconButton(
            onPressed: () {
              _searchController.clear();
              _fetchBerita();
            },
            icon: Icon(Icons.refresh),
          ),
          // IconButton(onPressed: (){
          //   Navigator.push(context,
          //       MaterialPageRoute(builder: (context) => GaleriPage()));
          // }, icon: Icon(Icons.image)
          // ),
          IconButton(onPressed: (){
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          }, icon: Icon(Icons.logout)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onChanged: _filterBeritaList,
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
              ),
            ),
            Expanded(
              child: Scrollbar(
                child: ListView.builder(
                  itemCount: _beritaList.length,
                  itemBuilder: (context, index) {
                    Datum result = _beritaList[index];
                    return GestureDetector(
                      // onTap: () {
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => DetailBerita(data: result),
                      //     ),
                      //   );
                      // },
                      child: Card(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  'http://127.0.0.1:8000/storage/${result.image}',
                                  fit: BoxFit.fill,
                                  width: double.infinity,
                                  height: 200,
                                ),
                              ),
                            ),
                            ListTile(
                              title: Text(result.title),
                              subtitle: Text(result.content,
                                maxLines: 2,),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
            if(_currentIndex == 0){
              // Handler untuk indeks 0 (Home)
            }
            else if(_currentIndex == 1){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>KaryawanPage()));
            }
            else if(_currentIndex == 2){
              _goToUserProfile(); // Handler untuk indeks 2 (Profile)
            }
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Pegawai',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}