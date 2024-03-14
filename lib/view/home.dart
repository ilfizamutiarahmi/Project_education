import 'package:flutter/material.dart';
import 'package:project_education/models/model_berita.dart'; // Pastikan untuk mengganti dengan nama file yang sesuai dengan model Anda
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  List<Datum> _beritaList = [];
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _fetchBerita();
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
            // Handle navigation here
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Library',
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
