import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wasteagram/helpers/firestore_helper.dart';
import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:wasteagram/model/post_model.dart';

class NewPostForm extends StatefulWidget {
  const NewPostForm({Key? key}) : super(key: key);

  @override
  _NewPostFormState createState() => _NewPostFormState();
}

class _NewPostFormState extends State<NewPostForm> {
  Position? position;
  PostModel model = PostModel();
  final formKey = GlobalKey<FormState>();
  XFile? image;
  @override
  Widget build(BuildContext context) {
    if (image == null) {
      getImage();
      getPosition(); // sneaky, sneaky!
      return Center(child: CircularProgressIndicator());
    } else {
      return Scaffold(
          appBar: AppBar(
            title: Text("Wasteagram"),
            centerTitle: true,
          ),
          body: buildBody());
    }
  }

  Future getImage() async {
    image = await ImagePicker().pickImage(source: ImageSource.gallery);
    Reference ref = FirebaseStorage.instance
        .ref()
        .child(Timestamp.now().toString() + '.jpg');
    UploadTask upTask = ref.putFile(File(image!.path));
    upTask.whenComplete(() async {
      model.imageURL = await ref.getDownloadURL();
      setState(() {});
    });
  }

  void fillInModel() {
    model.date = DateTime.now();
    model.longitude = position!.longitude;
    model.latitude = position!.latitude;
    FirestoreHelper.sendPostToFirestore(model);
    Navigator.pop(context);
  }

  void getPosition() async {
    position = await GeolocatorPlatform.instance.getCurrentPosition();
  }

  Widget buildBody() {
    return Column(children: [
      Image.file(File(image!.path), fit: BoxFit.cover),
      SizedBox(height: 5),
      Form(
          key: formKey,
          child: TextFormField(
            keyboardType: TextInputType.number,
            autofocus: true,
            decoration: InputDecoration(
                labelText: 'Number of Wasted Items',
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
              fillInModel();
            }
          },
          child: Icon(Icons.cloud_upload))
    ]);
  }
}
