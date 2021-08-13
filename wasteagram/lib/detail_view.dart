import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:wasteagram/model/post_model.dart';

class DetailView extends StatelessWidget {
  final PostModel model;
  const DetailView({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child: Image.network(model.imageURL!));
  }
}
