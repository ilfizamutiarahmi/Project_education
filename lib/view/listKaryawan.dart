import 'package:flutter/material.dart';
import 'package:project_education/model/karyawan_model.dart';
import 'package:http/http.dart' as http;
import 'package:project_education/view/addKaryawan.dart';
import 'package:project_education/view/editKaryawan.dart';

import 'detailKaryawan.dart';

class KaryawanPage extends StatefulWidget {
  const KaryawanPage({super.key});

  @override
  State<KaryawanPage> createState() => _KaryawanPageState();
}

class _KaryawanPageState extends State<KaryawanPage> {
  List<Result> karyawanList = [];
  List<Result> searchResults = [];
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchKaryawan();
  }

  Future<void> fetchKaryawan() async {
    try {
      final response = await http.get(
        Uri.parse("http://127.0.0.1:8000/api/karyawan"),
      );
      final data = listKaryawanFromJson(response.body);
      setState(() {
        karyawanList = data.result;
        searchResults = List.from(karyawanList);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  Future<void> deleteKaryawan(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('http://127.0.0.1:8000/api/karyawan/$id'),
      );
      if (response.statusCode == 200) {
        print('Karyawan deleted successfully');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Data Berhasil di hapus'),
          backgroundColor: Colors.green,));
        setState(() {
          searchResults.removeWhere((karyawan) => karyawan.id == id);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Data gagal di hapus'),
          backgroundColor: Colors.red,));
        print('Failed to delete karyawan: ${response.body}');
      }
    } catch (e) {
      print('Error deleting karyawan: $e');
    }
  }

  void searchKaryawan(String query) {
    setState(() {
      if (query.isNotEmpty) {
        searchResults = karyawanList
            .where((result) =>
        result.name.toLowerCase().contains(query.toLowerCase()) ||
            result.noBp.toLowerCase().contains(query.toLowerCase()))
            .toList();
      } else {
        searchResults = List.from(karyawanList);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Karyawan"),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddKaryawan()),
              );
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              onChanged: searchKaryawan,
              controller: controller,
              decoration: InputDecoration(
                labelText: "Search",
                prefix: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                Result data = searchResults[index];
                return Padding(
                  padding: EdgeInsets.all(2),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailKaryawan(data: data),
                        ),
                      );
                    },
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Text(
                              "${data.name}",
                              style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              "${data.noBp}",
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.black54,
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => UpdateKaryawan(karyawan: data),
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () {
                                    deleteKaryawan(data.id);
                                  },
                                  icon: Icon(Icons.delete),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
