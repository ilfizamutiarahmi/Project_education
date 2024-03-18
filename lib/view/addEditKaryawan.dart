// import 'package:flutter/material.dart';
// import 'package:project_education/model/api_service.dart';
// import 'package:intl/intl.dart';
// import '../model/karyawan_model.dart';
//
// class AddEditKaryawanPage extends StatefulWidget {
//   final Karyawan? karyawan;
//   final ApiService apiService; // Tambahkan required untuk parameter apiService
//
//   AddEditKaryawanPage({this.karyawan, required this.apiService});
//   // AddEditKaryawanPage({this.karyawan, required ApiService apiService});
//
//   @override
//   _AddEditKaryawanPageState createState() => _AddEditKaryawanPageState();
// }
//
// class _AddEditKaryawanPageState extends State<AddEditKaryawanPage> {
//   TextEditingController _nameController = TextEditingController();
//   TextEditingController _noBpController = TextEditingController();
//   TextEditingController _noHpController = TextEditingController();
//   TextEditingController _emailController = TextEditingController();
//   DateTime? _selectedDate;
//
//
//   @override
//   void initState() {
//     super.initState();
//     if (widget.karyawan != null) {
//       _nameController.text = widget.karyawan!.name;
//       _noBpController.text = widget.karyawan!.no_bp;
//       _noHpController.text = widget.karyawan!.no_hp;
//       _emailController.text = widget.karyawan!.email;
//       _selectedDate = widget.karyawan!.input_date;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.karyawan != null ? 'Edit Karyawan' : 'Tambah Karyawan'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextFormField(
//               controller: _nameController,
//               decoration: InputDecoration(labelText: 'Nama'),
//             ),
//             TextFormField(
//               controller: _noBpController,
//               decoration: InputDecoration(labelText: 'Nomor BP'),
//             ),
//             TextFormField(
//               controller: _noHpController,
//               decoration: InputDecoration(labelText: 'Nomor HP'),
//             ),
//             TextFormField(
//               controller: _emailController,
//               decoration: InputDecoration(labelText: 'Email'),
//             ),
//             SizedBox(height: 16),
//             // Input field untuk tanggal
//             ListTile(
//               title: Text('Tanggal Input'),
//               subtitle: Text(_selectedDate != null ? DateFormat('dd MMMM yyyy').format(_selectedDate!) : 'Pilih Tanggal'),
//               onTap: () {
//                 // Tampilkan date picker ketika dipilih
//                 showDatePicker(
//                   context: context,
//                   initialDate: _selectedDate ?? DateTime.now(),
//                   firstDate: DateTime(2000),
//                   lastDate: DateTime.now(),
//                 ).then((pickedDate) {
//                   if (pickedDate != null) {
//                     setState(() {
//                       _selectedDate = pickedDate;
//                     });
//                   }
//                 });
//               },
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 saveKaryawan();
//               },
//               child: Text('Simpan'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//   void saveKaryawan() {
//     String name = _nameController.text;
//     String no_bp = _noBpController.text;
//     String no_hp = _noHpController.text;
//     String email = _emailController.text;
//     DateTime? input_date = _selectedDate;
//     // Memastikan nilai input_date tidak null
//     if (input_date == null) {
//       input_date = DateTime.now();
//     }
//
//     Karyawan newKaryawan = Karyawan(
//       name: name,
//       no_bp: no_bp,
//       no_hp: no_hp,
//       email: email,
//       input_date: input_date,
//
//     );
//
//     // if (widget.karyawan != null) {
//     //   // Mengedit karyawan yang ada
//     //   widget.apiService.updateKaryawan(widget.karyawan!.id, newKaryawan).then((_) {
//     //     Navigator.pop(context, true); // Kembali ke halaman sebelumnya dengan status berhasil
//     //   }).catchError((error) {
//     //     // Tangkap kesalahan jika ada
//     //     showDialog(
//     //       context: context,
//     //       builder: (context) {
//     //         return AlertDialog(
//     //           title: Text('Error'),
//     //           content: Text('Gagal menyimpan perubahan: $error'),
//     //           actions: <Widget>[
//     //             TextButton(
//     //               onPressed: () {
//     //                 Navigator.of(context).pop();
//     //               },
//     //               child: Text('OK'),
//     //             ),
//     //           ],
//     //         );
//     //       },
//     //     );
//     //   });
//     // }else {
//     //   // Menambahkan karyawan baru
//     //   widget.apiService.addKaryawan(newKaryawan).then((_) {
//     //     Navigator.pop(context, true); // Kembali ke halaman sebelumnya dengan status berhasil
//     //   }).catchError((error) {
//     //     // Tangkap kesalahan jika ada
//     //     showDialog(
//     //       context: context,
//     //       builder: (context) {
//     //         return AlertDialog(
//     //           title: Text('Error'),
//     //           content: Text('Gagal menambahkan karyawan: $error'),
//     //           actions: <Widget>[
//     //             TextButton(
//     //               onPressed: () {
//     //                 Navigator.of(context).pop();
//     //               },
//     //               child: Text('OK'),
//     //             ),
//     //           ],
//     //         );
//     //       },
//     //     );
//     //   });
//     // }
//   }
//
// }