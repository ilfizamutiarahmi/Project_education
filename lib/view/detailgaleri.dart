import 'package:flutter/material.dart';
import 'package:project_education/model/model_galeri.dart';

class DetailGaleriPage extends StatefulWidget {
  final Result? data;

  const DetailGaleriPage({Key? key, this.data}) : super(key: key);

  @override
  State<DetailGaleriPage> createState() => _DetailGaleriPageState();
}

class _DetailGaleriPageState extends State<DetailGaleriPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Galeri'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: widget.data != null && widget.data!.image.isNotEmpty
            ? Image.network(
          'http://127.0.0.1:8000/storage/${widget.data!.image}',
          fit: BoxFit.contain,
        )
            : Container(), // Widget kosong jika data tidak tersedia atau gambar tidak ada
      ),
    );
  }
}
