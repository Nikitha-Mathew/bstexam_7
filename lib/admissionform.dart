import 'dart:io';
import 'package:bstexam_7/preview.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AdmissionFormScreen extends StatefulWidget {
  @override
  _AdmissionFormScreenState createState() => _AdmissionFormScreenState();
}

class _AdmissionFormScreenState extends State<AdmissionFormScreen> {
  final _formKey = GlobalKey<FormState>();
  Map<String, String> _formData = {};
  File? _studentPhoto;
  File? _birthCertificate;

  String? _validateFileSize(File file, int maxSizeKB) {
    final fileSizeKB = file.lengthSync() / 1024;
    if (fileSizeKB > maxSizeKB) {
      return "File size exceeds $maxSizeKB KB";
    }
    return null;
  }

  Future<void> _pickImage({required bool isStudentPhoto}) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final errorMessage = isStudentPhoto
          ? _validateFileSize(file, 100)
          : _validateFileSize(file, 300);

      if (errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
        return;
      }

      setState(() {
        if (isStudentPhoto) {
          _studentPhoto = file;
        } else {
          _birthCertificate = file;
        }
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() &&
        _studentPhoto != null &&
        _birthCertificate != null) {
      _formKey.currentState!.save();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ReviewScreen(
            studentDetails: _formData,
            studentPhoto: _studentPhoto!,
            birthCertificate: _birthCertificate!,
            onEdit: (updatedDetails, updatedPhoto, updatedCertificate) {
              setState(() {
                _formData = updatedDetails;
                _studentPhoto = updatedPhoto;
                _birthCertificate = updatedCertificate;
              });
              Navigator.pop(context);
            },
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please fill all fields and upload a photo.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Admission Form',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 153, 37, 216),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Student Name'),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter student name' : null,
                  onSaved: (value) => _formData['Student Name'] = value!,
                ),
                DropdownButtonFormField(
                  decoration: InputDecoration(labelText: 'Gender'),
                  items: ['Male', 'Female', 'Other']
                      .map((gender) => DropdownMenuItem(
                            value: gender,
                            child: Text(gender),
                          ))
                      .toList(),
                  validator: (value) =>
                      value == null ? 'Please select gender' : null,
                  onSaved: (value) => _formData['Gender'] = value!,
                  onChanged: (String? value) {},
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Date of Birth'),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter date of birth' : null,
                  onSaved: (value) => _formData['Date of Birth'] = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Mother Tongue'),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter mother tongue' : null,
                  onSaved: (value) => _formData['Mother Tongue'] = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Other Languages'),
                  onSaved: (value) => _formData['Other Languages'] = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Class for Admission'),
                  validator: (value) => value!.isEmpty
                      ? 'Please enter class for admission'
                      : null,
                  onSaved: (value) => _formData['Class for Admission'] = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Blood Group'),
                  onSaved: (value) => _formData['Blood Group'] = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Father Name'),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter father name' : null,
                  onSaved: (value) => _formData['Father Name'] = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Mother Name'),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter mother name' : null,
                  onSaved: (value) => _formData['Mother Name'] = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Address'),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter address' : null,
                  onSaved: (value) => _formData['Address'] = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email ID'),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter email ID' : null,
                  onSaved: (value) => _formData['Email ID'] = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Father Mobile'),
                  validator: (value) => value!.isEmpty
                      ? 'Please enter father mobile number'
                      : null,
                  onSaved: (value) => _formData['Father Mobile'] = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Mother Mobile'),
                  onSaved: (value) => _formData['Mother Mobile'] = value!,
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(150, 50),
                          backgroundColor:
                              const Color.fromARGB(255, 156, 150, 150),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 15),
                        ),
                        onPressed: () => _pickImage(isStudentPhoto: true),
                        child: Text(
                          'Upload Photo (Max 100 KB)',
                          style: TextStyle(
                              fontSize: 16,
                              color: const Color.fromARGB(255, 41, 38, 38)),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    if (_studentPhoto != null)
                      Image.file(_studentPhoto!, height: 50, width: 50),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(150, 50),
                          backgroundColor:
                              const Color.fromARGB(255, 156, 150, 150),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 15),
                        ),
                        onPressed: () => _pickImage(isStudentPhoto: false),
                        child: Text(
                          'Upload Birth Certificate (Max 300 KB)',
                          style: TextStyle(
                              fontSize: 16,
                              color: const Color.fromARGB(255, 41, 38, 38)),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    if (_birthCertificate != null)
                      Image.file(_birthCertificate!, height: 50, width: 50),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 180, 68, 236),
                    shape: StadiumBorder(),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                  ),
                  onPressed: _submitForm,
                  child: Text(
                    'Submit',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
