import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wasteagram/model/post_model.dart';
import '../strings.dart';

class FirestoreHelper {
  static Future sendPostToFirestore(PostModel post) async {
    if (post.isComplete()) {
      await FirebaseFirestore.instance
          .collection(Strings.post)
          .add(post.toMap());
    } else {
      print("error @ send post to firestore. post wasn't complete.");
    }
  }
}
