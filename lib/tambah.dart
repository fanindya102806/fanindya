import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:biodataa/models/api.dart';
import 'package:http/http.dart' as http;


class FormTambah extends StatefulWidget{
  const FormTambah({super.key});
  @override
  State<StatefulWidget> createState() => FormTambahState();

}
class FormTambahState extends State<FormTambah>{
  final formkey = GlobalKey<FormState>();
  TextEditingController nameController = new TextEditingController();
  TextEditingController birthController = new TextEditingController();
  TextEditingController religionController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();

  String _genderWarga = "";
  final _status = ["pria", "wanita"];

  final List<String> items = [
    'Islam',
    'Kristen',
    'Katolik',
    'Hindu',
    'Budha',
    'Konghucu',
  ];
  String? selectedValue;

  Future createSw() async {
    return await http.post(
      Uri.parse(BaseUrl.tambah),
      body: {
        'name': nameController.text,
        'gender': _genderWarga,
        'birth': birthController.text,
        'religion': selectedValue ?? 'Tidak Dipilih',
        'address': addressController.text,
      }
    );
  }

  void _onConfirm(context) async {
    http.Response response = await createSw();
    final data = json.decode(response.body);
    if(data['success']) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tambah Data Siswa",
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
      body: Container(
        child: Column(
          children: [
            _textboxName(),
            _textboxGender(),
            _textboxBirth(),
            _textboxReligion(),
            _textboxAddress(),
            const SizedBox(height: 20.0), // Memberikan jarak antara input form dan tombol
            _tombolSimpan(),
          ],
        ),
      ),
    );
  }
  _textboxName() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white, // Warna latar belakang
        borderRadius: BorderRadius.circular(10.0), // Membuat sudut melengkung
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Warna shadow
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // Posisi shadow
          ),
        ],
      ),
      child: TextField(
        decoration: const InputDecoration(
          labelText: "Student Name",
          prefixIcon: Icon(Icons.person), // Menambahkan ikon di dalam input form
          border: InputBorder.none, // Menghilangkan border default
          contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0), // Mengatur padding
        ),
        controller: nameController,
      ),
    );
  }

  _textboxGender() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.wc),
              SizedBox(width: 10.0),
              Text(
                "Student Gender",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          RadioGroup<String>.builder(
            groupValue: _genderWarga,
            onChanged: (value) => setState(() {
              _genderWarga = value ?? '';
            }),
            items: _status,
            itemBuilder: (item) => RadioButtonBuilder(
              item,
              textPosition: RadioButtonTextPosition.right,
            ),
            activeColor: Colors.purple,
            fillColor: Colors.purple,
          ),
        ],
      ),
    );
  }

  _textboxReligion() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // Posisi shadow
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          labelText: 'Student Religion',
          prefixIcon: Icon(Icons.mosque), // Ikon di dalam input form
          border: InputBorder.none, // Menghilangkan border default
          contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0), // Mengatur padding
        ),
        isExpanded: true, // Membuat dropdown sesuai lebar container
        items: items
            .map((String item) => DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style: const TextStyle(fontSize: 14),
          ),
        ))
            .toList(),
        value: selectedValue,
        onChanged: (String? value) {
          setState(() {
            selectedValue = value;
          });
        },
      ),
    );
  }

  _textboxBirth() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white, // Warna latar belakang
        borderRadius: BorderRadius.circular(10.0), // Membuat sudut melengkung
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Warna shadow
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // Posisi shadow
          ),
        ],
      ),
      child: TextField(
        controller: birthController, // Controller untuk tanggal lahir
        decoration: const InputDecoration(
          labelText: "Student Birthday",
          prefixIcon: Icon(Icons.cake), // Ikon kalender di dalam input form
          border: InputBorder.none, // Menghilangkan border default
          contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0), // Mengatur padding
        ),
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2100),
          );

          if (pickedDate != null) {
            setState(() {
              birthController.text = "${pickedDate.toLocal()}".split(' ')[0];
            });
          }
        },
      ),
    );
  }

  _textboxAddress() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white, // Warna latar belakang
        borderRadius: BorderRadius.circular(10.0), // Membuat sudut melengkung
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Warna shadow
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // Posisi shadow
          ),
        ],
      ),
      child: TextField(
        decoration: const InputDecoration(
          labelText: "Student Address",
          prefixIcon: Icon(Icons.add_home), // Menambahkan ikon di dalam input form
          border: InputBorder.none, // Menghilangkan border default
          contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0), // Mengatur padding
        ),
        controller: addressController,
      ),
    );
  }

  _tombolSimpan() {
    return ElevatedButton(
      onPressed: () {
        _onConfirm(context);
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, backgroundColor: Colors.purple, // Warna teks
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), // Membuat sudut tombol melengkung
        ),
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0), // Padding di dalam tombol
        elevation: 5.0, // Efek shadow di bawah tombol
        shadowColor: Colors.grey.withOpacity(0.5), // Warna shadow
      ),
      child: const Text(
        'Submit',
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}