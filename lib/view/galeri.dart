import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_education/view/detailgaleri.dart';

import '../model/model_galeri.dart';


class GaleriPage extends StatefulWidget {
  const GaleriPage({super.key});

  @override
  State<GaleriPage> createState() => _GaleriPageState();
}

class _GaleriPageState extends State<GaleriPage> {
  List<Result> listGaleri = [];

  @override
  void initState(){
    super.initState();
    fetchGaleri();
  }

  Future<void> fetchGaleri() async {
    try{
      final response = await http.get(Uri.parse("http://127.0.0.1:8000/api/galeri"));
      final data = listGaleriFromJson(response.body);
      setState(() {
        listGaleri = data.result;
      });
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mini Galeri'),
        backgroundColor: Colors.blue,
      ),
      body: GridView.builder(
          itemCount: listGaleri.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index){
            final galeri = listGaleri[index];
            return GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailGaleriPage(data: galeri),
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.all(3.0),
                child: GridTile(
                   child: Image.network('http://127.0.0.1:8000/storage/${galeri.image}'),
                ),
              ),
            );
          }),
    );
  }
}
