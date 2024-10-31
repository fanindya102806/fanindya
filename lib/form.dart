import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class AppForm extends StatefulWidget {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController nameController,
      genderController,
      birthController,
      religionController,
      addressController;

  AppForm(
      {required this.formkey,
      required this.nameController,
      required this.genderController,
      required this.birthController,
      required this.religionController,
      required this.addressController});

  @override
  AppFormState createState() => AppFormState();
}

class AppFormState extends State<AppForm> {
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formkey,
      autovalidateMode: AutovalidateMode.always,
      child: SingleChildScrollView(
        child: Column(
          children: [
            txtName(),
            txtBirth(),
            txtGender(),
            txtAddress(),
            txtReligion()
          ],
        ),
      ),
    );
  }

  txtName(){
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
      child: TextFormField(
        controller: widget.nameController,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          labelText: "Student Name",
          prefixIcon: Icon(Icons.person), // Menambahkan ikon di dalam input form
          border: InputBorder.none, // Menghilangkan border default
          contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0), // Mengatur padding
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Masukan Nama Anda.';
          }
          return null;
        },
      ),

    );
  }
  txtBirth(){
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
      child: TextFormField(
          controller: widget.birthController,
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
            labelText: "Student Birthday",
            prefixIcon: Icon(Icons.cake),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          ),
          readOnly: true,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Masukan Tanggal Lahir Anda.';
            }
            return null;
          },
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(DateTime
                  .now()
                  .year - 150),
              lastDate: DateTime(DateTime
                  .now()
                  .year, DateTime
                  .now()
                  .month, DateTime
                  .now()
                  .day),
            );
            if (pickedDate != null) {
              setState(() {
                widget.birthController.text =
                "${pickedDate.toLocal()}".split(' ')[0];
              });
            }
          },
      ),
    );
  }
  txtGender(){
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
            groupValue: widget.genderController.text,
            onChanged: (value) => setState(() {
              _genderWarga = value ?? '';
              widget.genderController.text = _genderWarga;
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
  txtAddress(){
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
      child: TextFormField(
        controller: widget.addressController,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          labelText: "Student Address",
          prefixIcon: Icon(Icons.add_home),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        ),
      ),
    );
  }
  txtReligion(){
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
          prefixIcon: Icon(Icons.mosque),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        ),
        isExpanded: true,
        hint: const Text('Pilih Agama', style: TextStyle(fontSize: 14),),
        items: items
            .map((String item) => DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style: const TextStyle(fontSize: 14),
          ),
        ))
            .toList(),
        value: widget.religionController.text,
        onChanged: (String? value) {
          setState(() {
            selectedValue = value;
            widget.religionController.text = selectedValue!;
          });
        },
        validator: (value) {
          if (value!.isEmpty) {
            return 'Masukan Agama Anda.';
          }
          return null;
        },
      ),
    );
  }
}
