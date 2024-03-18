import 'package:flutter/material.dart';
import 'package:project_education/model/model_karyawan.dart';

class DetailKaryawan extends StatefulWidget {
  final Result? data;
  const DetailKaryawan({super.key, this.data});

  @override
  State<DetailKaryawan> createState() => _DetailKaryawanState();
}

class _DetailKaryawanState extends State<DetailKaryawan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Karyawan'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Nama  :  ${widget.data?.name ?? ""}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            SizedBox(width: 10,),
            Text('No Bp  :  ${widget.data?.noBp ?? ""}',
              style: TextStyle(fontSize: 15,),),
            SizedBox(width: 1,),
            Text('No Hp  :  ${widget.data?.noHp ?? ""}',
              style: TextStyle(fontSize: 15,),),
            SizedBox(width: 10,),
            Text('Email  :  ${widget.data?.email ?? ""}',
              style: TextStyle(fontSize: 15,),),
            SizedBox(width: 10,),
            Text('Input Date  :  ${widget.data?.inputDate ?? ""}',
              style: TextStyle(fontSize: 15,),),
            SizedBox(width: 10,),
          ],
        ),
      ),
    );
  }
}
