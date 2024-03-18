import 'package:flutter/material.dart';
import 'package:project_education/model/model_berita.dart';

class DetailBerita extends StatelessWidget {
  final Datum? data;

  const DetailBerita({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Berita'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data?.title ?? 'No Title',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: data != null && data!.image.isNotEmpty
                    ? Image.network(
                  'http://127.0.0.1:8000/storage/${data!.image}',
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: 200,
                )
                    : Container(),
              ),
              SizedBox(height: 16),
              Text(
                data?.content ?? 'No Content',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
