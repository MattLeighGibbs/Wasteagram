// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:flutter_test/flutter_test.dart';
import 'package:wasteagram/model/post_model.dart';
import 'package:wasteagram/strings.dart';

void main() {
  test('To map of a non-complete PostModel should return an empty map', () {
    PostModel model = PostModel();
    expect(model.toMap(), {});
  });
  test('To map of a complete PostModel should return the expected map', () {
    PostModel model = PostModel();
    DateTime mockTime = DateTime.now();
    String mockURL = "adgadg";
    int mockQuantity = 1;
    double mockLongitude = 1.1;
    double mockLatitude = 1.1;

    model.date = mockTime;
    model.imageURL = mockURL;
    model.quantity = mockQuantity;
    model.longitude = mockLongitude;
    model.latitude = mockLatitude;

    expect(model.toMap(), {
      Strings.date: mockTime,
      Strings.imageURL: mockURL,
      Strings.latitude: mockLatitude,
      Strings.longitude: mockLongitude,
      Strings.quantity: mockQuantity
    });
  });
}
