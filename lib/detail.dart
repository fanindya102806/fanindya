import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:biodataa/models/api.dart';
import 'package:biodataa/models/msiswa.dart';

import 'edit.dart';

class Detail extends StatefulWidget{
  final SiswaModel sw;
  Detail({required this.sw});
  @override
  State<StatefulWidget> createState() => DetailState();
}

class DetailState extends State<Detail>{
  void deleteSiswa(context) async {
    http.Response response = await http.post(
      Uri.parse(BaseUrl.hapus),
      body: {
        'id' : widget.sw.id.toString(),
      }
    );
    final data = json.decode(response.body);
    if (data['success']) {
      pesan();
      Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    }
  }

  pesan() {
    Fluttertoast.showToast(
      msg: "Penghapusan Data Berhasil",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0
    );
  }

  void confirmDelete(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('Anda yakin menghapus data ini?'),
          actions: [
            ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Icon(Icons.cancel)
            ),
            ElevatedButton(
                onPressed: () => deleteSiswa(context),
                child: Icon(Icons.check_circle)
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detail Siswa",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 4.0,
        actions: [
          IconButton(onPressed: () => confirmDelete(context), icon: Icon(Icons.delete))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.perm_identity, size: 28, color: Colors.blue),
                SizedBox(width: 10),
                Text(
                  'Id: ${widget.sw.id}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(),
            Row(
              children: [
                Icon(Icons.person, size: 28, color: Colors.blue),
                SizedBox(width: 10),
                Text(
                  'Name: ${widget.sw.name}',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            Divider(),
            Row(
              children: [
                Icon(Icons.wc, size: 28, color: Colors.blue),
                SizedBox(width: 10),
                Text(
                  'Gender: ${widget.sw.gender}',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            Divider(),
            Row(
              children: [
                Icon(Icons.cake, size: 28, color: Colors.blue),
                SizedBox(width: 10),
                Text(
                  'Birth: ${widget.sw.birth}',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            Divider(),
            Row(
              children: [
                Icon(Icons.book, size: 28, color: Colors.blue),
                SizedBox(width: 10),
                Text(
                  'Religion: ${widget.sw.religion}',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            Divider(),
            Row(
              children: [
                Icon(Icons.location_on, size: 28, color: Colors.blue),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Address: ${widget.sw.address}',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        hoverColor: Colors.green,
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => Edit(sw: widget.sw))
        ),
        child: Icon(Icons.edit, color: Colors.white,),
      ),
    );
  }
  
}