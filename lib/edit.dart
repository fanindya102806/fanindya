import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:biodataa/models/api.dart';
import 'package:biodataa/models/msiswa.dart';
import 'package:http/http.dart' as http;

import 'form.dart';


class Edit extends StatefulWidget{
  final SiswaModel sw;

  Edit({required this.sw});

  @override
  State<StatefulWidget> createState() => EditState();
}
class EditState extends State<Edit>{
  final formkey = GlobalKey<FormState>();

  late TextEditingController nameController, birthController, religionController, genderController, addressController;

  Future editSw() async {
    return await http.post(
      Uri.parse(BaseUrl.edit),
      body: {
        "id": widget.sw.id.toString(),
        "name": nameController.text,
        "birth": birthController.text,
        "religion": religionController.text,
        "gender": genderController.text,
        "address": addressController.text
      }
    );
  }

  pesan() {
    Fluttertoast.showToast(
        msg: "Perubahan data berhasil",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  void _onConfirm(context) async {
    http.Response response = await editSw();
    final data = json.decode(response.body);
    if(data['success']) {
      pesan();
      Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    }
  }

  @override

  void initState() {
    nameController = TextEditingController(text: widget.sw.name);
    birthController = TextEditingController(text: widget.sw.birth);
    religionController = TextEditingController(text: widget.sw.religion);
    genderController = TextEditingController(text: widget.sw.gender);
    addressController = TextEditingController(text: widget.sw.address);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Siswa",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 4.0,
      ),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          child: Text("Update"),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.orange,
            textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)
          ),
          onPressed: () {
            _onConfirm(context);
          },
        )
      ),  
      body: Container(
        height: double.infinity,
        padding: EdgeInsets.all(20),
        child: Center(
          child: AppForm(
            formkey: formkey,
            nameController: nameController,
            birthController: birthController,
            religionController: religionController,
            addressController: addressController,
            genderController: genderController,
          ),
        ),
      ),
    );
  }
  
}