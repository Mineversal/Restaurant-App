import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant/data/model/restaurants.dart';

void main() {
  test('parse json restaurant into model', () {
    const id = "rqdv5juczeskfw1e867";
    const name = "Melting Pot";
    const description =
        "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor";
    const pictureId = "14";
    const city = "Medan";
    const double rating = 4.2;

    final json = {
      "id": "rqdv5juczeskfw1e867",
      "name": "Melting Pot",
      "description":
          "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor",
      "pictureId": "14",
      "city": "Medan",
      "rating": 4.2
    };

    Restaurant result = Restaurant.fromJson(json);
    expect(result.id, id);
    expect(result.name, name);
    expect(result.description, description);
    expect(result.pictureId, pictureId);
    expect(result.city, city);
    expect(result.rating, rating);
  });

  test('convert model to json', () {
    Restaurant test = Restaurant(
        id: 'id',
        name: 'name',
        description: 'description',
        pictureId: 'pictureid',
        city: 'city',
        rating: 5);
    var expected = {
      'id': 'id',
      'name': 'name',
      'description': 'description',
      'pictureId': 'pictureid',
      'city': 'city',
      'rating': 5
    };
    var result = test.toJson();
    expect(result, expected);
  });
}
