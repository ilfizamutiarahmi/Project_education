import 'package:flutter/material.dart';
import 'package:project_education/model/api_service.dart';
import 'package:project_education/view/addKaryawan.dart';

import '../model/karyawan_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// import 'addEditKaryawan.dart';
import 'detailKaryawan.dart';

class ListKaryawan extends StatefulWidget {
  // const ListKaryawan({super.key, required int userId, required String userName, required String userEmail, required ApiService apiService});
  const ListKaryawan({
    Key? key,
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.apiService,
  }) : super(key: key);

  final int userId;
  final String userName;
  final String userEmail;
  final ApiService apiService;

  @override
  _ListKaryawan createState() => _ListKaryawan();
}

class _ListKaryawan extends State<ListKaryawan> {
  TextEditingController _searchController = TextEditingController();
  List<dynamic> _karyawanList = [];
  List<dynamic> _filteredKaryawanList = [];

  // Datum? get result => null;

  @override
  void initState() {
    super.initState();
    fetchKaryawan();
  }

  Future<void> fetchKaryawan() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/karyawan'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      setState(() {
        _karyawanList = responseData['result'];
        _filteredKaryawanList = _karyawanList;
      });
    } else {
      throw Exception('Failed to load karyawan');
    }
  }

  void _filterKaryawan(String query) {
    setState(() {
      _filteredKaryawanList = _karyawanList
          .where((karyawan) => karyawan['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Pegawai'),
        backgroundColor: Colors.cyan,
        actions: [
          IconButton(
            icon: Icon(Icons.add), // Icon untuk create (tambah karyawan)
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreatePage(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                _filterKaryawan(value);
              },

              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredKaryawanList.length,
              itemBuilder: (context, index) {
                final karyawan = _filteredKaryawanList[index];
                return Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailKaryawanPage(karyawan: karyawan),
                        ),
                      );
                    },
                    title: Text(karyawan['name']),
                    subtitle: Text(karyawan['no_bp']),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // IconButton(
                        //   icon: Icon(Icons.edit), // Icon untuk update (edit karyawan)
                        //   onPressed: () {
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //         builder: (context) => AddEditKaryawanPage(apiService: widget.apiService, karyawan: karyawan),
                        //       ),
                        //     );
                        //   },
                        // ),
                        IconButton(
                          icon: Icon(Icons.delete), // Icon untuk delete (hapus karyawan)
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Konfirmasi'),
                                  content: Text('Anda yakin ingin menghapus ${karyawan.name}?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text('Batal'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        try {
                                          // await ApiService.deleteKaryawan(karyawan.id);
                                          Navigator.pop(context); // Tutup dialog
                                          // Refresh halaman setelah penghapusan berhasil
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ListKaryawan(
                                                userId: widget.userId,
                                                userName: widget.userName,
                                                userEmail: widget.userEmail,
                                                apiService: widget.apiService,
                                              ),
                                            ),
                                          );
                                        } catch (error) {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Text('Error'),
                                                content: Text('Gagal menghapus karyawan: $error'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: Text('OK'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        }
                                      },
                                      child: Text('Hapus'),
                                    ),
                                  ],
                                );
                              },
                            );
                            // Tambahkan logika untuk menghapus karyawan
                          },
                        ),
                      ],
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

