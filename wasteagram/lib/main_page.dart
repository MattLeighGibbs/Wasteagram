import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wasteagram/model/post_model.dart';
import 'package:wasteagram/new_post.dart';

import 'helpers/datetime_helper.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wasteagram'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('post').snapshots(),
          builder: (content, snapshot) {
            if (snapshot.data!.docs.isNotEmpty) {
              return Column(children: [
                Expanded(
                    child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    PostModel post =
                        PostModel.fromFirestore(snapshot.data!.docs[index]);
                    return ListTile(
                      title: Text(DatetimeHelper.formatDateTime(post.date!)),
                      trailing: Text(post.quantity.toString()),
                      onTap: () {},
                    );
                  },
                )),
                getButton()
              ]);
            } else {
              return Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [CircularProgressIndicator(), getButton()]));
            }
          }),
    );
  }

  void onButtonPress() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => NewPostForm()));
  }

  ElevatedButton getButton() {
    return ElevatedButton(onPressed: onButtonPress, child: Icon(Icons.camera));
  }
}
