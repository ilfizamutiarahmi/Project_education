import 'package:flutter/material.dart';
import 'package:project_education/model/api_service.dart';
import 'package:project_education/view/karyawan.dart';
import 'package:intl/intl.dart';
import 'package:project_education/model/model_karyawan.dart';

class UpdateKaryawan extends StatefulWidget {
  final Result karyawan;

  const UpdateKaryawan({Key? key, required this.karyawan}) : super(key: key);

  @override
  State<UpdateKaryawan> createState() => _UpdateKaryawanState();
}

class _UpdateKaryawanState extends State<UpdateKaryawan> {
  final ApiService apiService = ApiService(baseUrl: 'http://127.0.0.1:8000/api');
  late TextEditingController nameController;
  late TextEditingController noBpController;
  late TextEditingController noHpController;
  late TextEditingController emailController;
  late TextEditingController inputDateController;

  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  bool isDateSelected = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.karyawan.name);
    noBpController = TextEditingController(text: widget.karyawan.noBp);
    noHpController = TextEditingController(text: widget.karyawan.noHp);
    emailController = TextEditingController(text: widget.karyawan.email);
    inputDateController = TextEditingController(text: widget.karyawan.inputDate.toString());
  }

  void _updateKaryawan() async {
    if (keyForm.currentState!.validate()) {
      final name = nameController.text;
      final noBp = noBpController.text;
      final noHp = noHpController.text;
      final email = emailController.text;
      final inputDate = inputDateController.text;

      try {
        final response = await apiService.updateKaryawan(widget.karyawan.id, name, noBp, noHp, email, inputDate);
        final karyawan = response['karyawan'];
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => KaryawanPage()));
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Data Karyawan berhasil diupdate. Silakan muat ulang untuk melihat data baru'),
          backgroundColor: Colors.green,
        ));
      } catch (e) {
        print('Update data gagal: $e');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Update data gagal: $e'),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  Future selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(1950),
      initialDate: DateFormat("yyyy-MM-dd HH:mm:ss").parse(widget.karyawan.inputDate as String),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(DateFormat("yyyy-MM-dd HH:mm:ss").parse(widget.karyawan.inputDate as String)),
      );
      if (pickedTime != null) {
        setState(() {
          isDateSelected = true;
          DateTime selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          inputDateController.text = DateFormat("yyyy-MM-dd HH:mm:ss").format(selectedDateTime);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Data Karyawan'),
        backgroundColor: Colors.blue,
      ),
      body: Form(
        key: keyForm,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  return null;
                },
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name', border: OutlineInputBorder()),
              ),
              SizedBox(height: 10),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'NoBp tidak boleh kosong';
                  }
                  return null;
                },
                controller: noBpController,
                decoration: InputDecoration(labelText: 'NoBp', border: OutlineInputBorder()),
              ),
              SizedBox(height: 10),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'NoHp tidak boleh kosong';
                  }
                  return null;
                },
                controller: noHpController,
                decoration: InputDecoration(labelText: 'NoHp', border: OutlineInputBorder()),
              ),
              SizedBox(height: 10),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Email tidak boleh kosong';
                  }
                  return null;
                },
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
              ),
              SizedBox(height: 10),
              TextFormField(
                onTap: () {
                  if (!isDateSelected) {
                    selectDate();
                  }
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Tanggal Data Input tidak boleh kosong';
                  }
                  return null;
                },
                controller: inputDateController,
                decoration: InputDecoration(labelText: 'Input Date', border: OutlineInputBorder()),
              ),
              SizedBox(height: 10),
              MaterialButton(
                onPressed: _updateKaryawan,
                child: Text('Update data'),
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
