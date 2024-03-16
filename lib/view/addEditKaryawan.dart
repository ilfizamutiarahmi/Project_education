import 'package:flutter/material.dart';
import 'package:project_education/model/api_service.dart';

import '../model/karyawan_model.dart';

class AddEditKaryawanPage extends StatefulWidget {
  final Karyawan? karyawan;

  AddEditKaryawanPage({this.karyawan, required ApiService apiService});

  @override
  _AddEditKaryawanPageState createState() => _AddEditKaryawanPageState();
}

class _AddEditKaryawanPageState extends State<AddEditKaryawanPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _noBpController = TextEditingController();
  TextEditingController _noHpController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.karyawan != null) {
      _nameController.text = widget.karyawan!.name;
      _noBpController.text = widget.karyawan!.no_bp;
      _noHpController.text = widget.karyawan!.no_hp;
      _emailController.text = widget.karyawan!.email;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.karyawan != null ? 'Edit Karyawan' : 'Tambah Karyawan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nama'),
            ),
            TextFormField(
              controller: _noBpController,
              decoration: InputDecoration(labelText: 'Nomor BP'),
            ),
            TextFormField(
              controller: _noHpController,
              decoration: InputDecoration(labelText: 'Nomor HP'),
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Fungsi simpan data ke API
              },
              child: Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}