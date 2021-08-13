import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wasteagram/helpers/datetime_helper.dart';

import '../strings.dart';

class PostModel {
  DateTime? date;
  String? imageURL;
  double? latitude;
  double? longitude;
  int? quantity;

  PostModel.fromFirestore(QueryDocumentSnapshot<Object?> snap) {
    date = DatetimeHelper.timeStampToDateTime(snap['date']);
    imageURL = snap['imageURL'];
    latitude = snap['latitude'];
    longitude = snap['longitude'];
    quantity = snap['quantity'];
  }

  PostModel();

  Map<String, Object> toMap() {
    return {
      Strings.date: date!,
      Strings.imageURL: imageURL!,
      Strings.latitude: latitude!,
      Strings.longitude: longitude!,
      Strings.quantity: quantity!
    };
  }

  bool isComplete() {
    bool dateNull = date == null;
    bool imageURLNull = imageURL == null;
    bool latitudeNull = latitude == null;
    bool longitudeNull = longitude == null;
    bool quantityNull = quantity == null;

    if (dateNull ||
        imageURLNull ||
        latitudeNull ||
        longitudeNull ||
        quantityNull) {
      return false;
    } else {
      return true;
    }
  }
}
