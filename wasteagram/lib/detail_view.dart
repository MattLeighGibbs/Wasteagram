import 'package:flutter/material.dart';
import 'package:wasteagram/helpers/datetime_helper.dart';
import 'package:wasteagram/model/post_model.dart';

class DetailView extends StatelessWidget {
  final PostModel model;
  const DetailView({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Wasteagram'),
          centerTitle: true,
        ),
        body: buildBody());
  }

  TextStyle getTextStyle() {
    return TextStyle(fontSize: 40);
  }

  Widget buildBody() {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Text(
        DatetimeHelper.formatDateTime(model.date!),
        style: getTextStyle(),
      ),
      Image.network(model.imageURL!),
      Text(
        model.quantity.toString() + ' Items',
        style: getTextStyle(),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Location:'),
          SizedBox(width: 15),
          Text(model.latitude.toString() + ',  '),
          Text(model.longitude.toString())
        ],
      )
    ]);
  }
}
