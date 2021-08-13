import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simpleprogressdialog/simpleprogressdialog.dart';
import 'package:wasteagram/helpers/firestore_helper.dart';
import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:wasteagram/main_page.dart';
import 'package:wasteagram/model/post_model.dart';

class NewPostForm extends StatefulWidget {
  const NewPostForm({Key? key}) : super(key: key);

  @override
  _NewPostFormState createState() => _NewPostFormState();
}

class _NewPostFormState extends State<NewPostForm> {
  PostModel model = PostModel();
  final formKey = GlobalKey<FormState>();
  XFile? image;
  @override
  Widget build(BuildContext context) {
    if (image == null) {
      getImage();
      return Center(child: CircularProgressIndicator());
    } else {
      return Scaffold(
          appBar: AppBar(title: Text("sample")),
          body: Column(children: [
            Image.file(File(image!.path), fit: BoxFit.cover),
            SizedBox(height: 5),
            Form(
                key: formKey,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  autofocus: true,
                  decoration: InputDecoration(
                      labelText: 'Quantity',
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(fontSize: 20)),
                  onSaved: (value) {
                    model.quantity = int.parse(value!);
                  },
                  validator: (value) {
                    if (value!.length == 0) {
                      return 'please enter a number';
                    } else {
                      return null;
                    }
                  },
                )),
            ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    ProgressDialog progressDialog = ProgressDialog(
                        context: context, barrierDismissible: false);
                    progressDialog.showMaterial();
                    fillInModel().then((value) {
                      progressDialog.dismiss();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MainPage()));
                    });
                  }
                },
                child: Icon(Icons.cloud_upload))
          ]));
    }
  }

  Future getImage() async {
    image = await ImagePicker().pickImage(source: ImageSource.gallery);
    Reference storageReference =
        FirebaseStorage.instance.ref(Timestamp.now().toString() + '.jpg');
    await storageReference.putFile(File(image!.path));
    model.imageURL = await storageReference.getDownloadURL();
    setState(() {});
  }

  Future fillInModel() async {
    model.date = DateTime.now();
    model.imageURL = image!.path;
    Position position = await Geolocator.getCurrentPosition();
    model.longitude = position.longitude;
    model.latitude = position.latitude;
    FirestoreHelper.sendPostToFirestore(model);
  }
}
