import 'package:flutter/material.dart';
import 'package:project_education/model/model_berita.dart'; // Pastikan untuk mengganti dengan nama file yang sesuai dengan model Anda
import 'package:http/http.dart' as http;
import 'package:project_education/view/login.dart';
import 'package:project_education/view/user_profile.dart';

import '../model/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<void> _loadUserInfo() async {
    userName = await getUserName();
    userEmail = await getUserEmail();
    setState(() {});
  }

  void _goToUserProfile() {
    Navigator.push(
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
    // Filter list based on query
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
                      onTap: () {
                        // Handle onTap event here
                      },
                      child: Card(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  'http://127.0.0.1:8000/api/berita/${result.image}',
                                  fit: BoxFit.fill,
                                  width: double.infinity,
                                  height: 200,
                                ),
                              ),
                            ),
                            ListTile(
                              title: Text(result.title),
                              subtitle: Text(result.content),
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
            if(_currentIndex == 2){
             _goToUserProfile();
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
