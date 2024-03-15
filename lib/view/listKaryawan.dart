import 'package:flutter/material.dart';
import 'package:project_education/model/api_service.dart';

import '../model/karyawan_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'detailKaryawan.dart';

class ListKaryawan extends StatefulWidget {
  const ListKaryawan({super.key, required int userId, required String userName, required String userEmail, required ApiService apiService});

  @override
  _ListKaryawan createState() => _ListKaryawan();
}

class _ListKaryawan extends State<ListKaryawan> {
  TextEditingController _searchController = TextEditingController();
  List<dynamic> _karyawanList = [];
  List<dynamic> _filteredKaryawanList = [];

  Datum? get result => null;

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
                          builder: (context) => PageDetailKaryawan(karyawan),
                        ),
                      );
                    },
                    title: Text(karyawan['name']),
                    subtitle: Text(karyawan['no_bp']),
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

