import 'package:flutter/material.dart';
import '../model/karyawan_model.dart';


// class PageDetailKaryawan extends StatelessWidget {
//   final Map<String, dynamic> karyawan;
//
//   const PageDetailKaryawan(this.karyawan, {super.key});
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(karyawan['name']),
//         backgroundColor: Colors.cyan,
//       ),
//
//       body: ListView(
//         children: [
//
//           ListTile(
//             title: Text('Name: ${karyawan['name']}',
//               style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 16
//               ),
//             ),
//             // subtitle: Text(DateFormat().format(result?.input_date ?? DateTime.now())),
//             trailing: Icon(Icons.star, color: Colors.orange,),
//           ),
//           Container(
//             margin: EdgeInsets.all(10),
//             child: Text(
//               'No BP: ${karyawan['no_bp']}',
//               style: TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.bold
//               ),
//             ),
//
//           )
//         ],
//       ),
//     );
//   }
// }

class DetailKaryawanPage extends StatelessWidget {
  final dynamic karyawan; // Deklarasi parameter karyawan

  DetailKaryawanPage({required this.karyawan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Karyawan'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            title: Text('Nama: ${karyawan.name}'),
          ),
          ListTile(
            title: Text('Nomor BP: ${karyawan.no_bp}'),
          ),
          ListTile(
            title: Text('Nomor HP: ${karyawan.no_hp}'),
          ),
          ListTile(
            title: Text('Email: ${karyawan.email}'),
          ),
          ListTile(
            title: Text('Input Date: ${karyawan.input_date}'),
          ),
        ],
      ),
    );
  }
}


