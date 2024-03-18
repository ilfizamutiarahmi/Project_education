import 'package:flutter/material.dart';
import 'package:project_education/model/api_service.dart';
import 'package:project_education/view/karyawan.dart';
import 'package:intl/intl.dart';

class AddKaryawan extends StatefulWidget {
  const AddKaryawan({super.key});

  @override
  State<AddKaryawan> createState() => _AddKaryawanState();
}

class _AddKaryawanState extends State<AddKaryawan> {
  final ApiService apiService = ApiService(baseUrl: 'http://127.0.0.1:8000/api');
  final TextEditingController nameController = TextEditingController();
  final TextEditingController noBpController = TextEditingController();
  final TextEditingController noHpController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController inputDateController = TextEditingController();

  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  bool isDateSelected = false;

  void _karyawan() async {
    if(keyForm.currentState!.validate()){
      final name = nameController.text;
      final noBp = noBpController.text;
      final noHp = noHpController.text;
      final email = emailController.text;
      final inputDate = inputDateController.text;

      try{
        final response = await apiService.addKaryawan(name, noBp, noHp, email, inputDate);
        final karyawan = response['karyawan'];
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>KaryawanPage()));
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Data Karyawan berhasil di tambah. reload untuk melihat data baru'),
          backgroundColor: Colors.green,));
      }catch(e){
        print('Penambahan data gagal : $e');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Penambahan data gagal : $e'),
          backgroundColor: Colors.red,));
      }

    }
  }

  Future selectDate() async{
    DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(1950),
      initialDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
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
        title: Text('Tambah data Karyawan'),
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
              SizedBox(height: 10,),
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
              SizedBox(height: 10,),
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
              SizedBox(height: 10,),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'email tidak boleh kosong';
                  }
                  return null;
                },
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
              ),
              SizedBox(height: 10,),
              TextFormField(
                onTap: (){
                  if(!isDateSelected) {
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
              SizedBox(height: 10,),
              MaterialButton(
                onPressed: _karyawan,
                child: Text('Tambah data'),
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
