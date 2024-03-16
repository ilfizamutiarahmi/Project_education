import 'package:flutter/material.dart';
import 'package:project_education/model/api_service.dart';
import 'package:project_education/view/listKaryawan.dart';
import 'package:project_education/view/login.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final ApiService apiService = ApiService(baseUrl: 'http://127.0.0.1:8000/api');
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController no_bpController = TextEditingController();
  final TextEditingController no_hpController = TextEditingController();
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  void _create() async {

    if (keyForm.currentState!.validate()) {
      final name = nameController.text;
      final email = emailController.text;
      final no_bp = no_bpController.text;
      final no_hp = no_hpController.text;

      try {
        final response = await apiService.addKaryawan(name, email, no_bp, no_hp);
        final karyawan = response['karyawan'];
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => CreatePage()));

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Create successful for $name with email $email'),
            backgroundColor: Colors.green,
          ),
        );
      } catch (e) {
        print('Registration failed: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Registration failed: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Pegawai'),
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
              SizedBox(height: 16),
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
              SizedBox(height: 16),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'No BP tidak boleh kosong';
                  }
                  return null;
                },
                controller: no_bpController,
                decoration: InputDecoration(labelText: 'No BP', border: OutlineInputBorder()),
              ),
              SizedBox(height: 16),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'No HP tidak boleh kosong';
                  }
                  return null;
                },
                controller: no_hpController,
                decoration: InputDecoration(labelText: 'No HP', border: OutlineInputBorder()),
              ),
              SizedBox(height: 16),
              MaterialButton(
                onPressed: _create,
                child: Text('Simpan'),
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
