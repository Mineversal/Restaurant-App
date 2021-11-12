import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant/data/model/restaurant_details.dart' as details;
import 'package:restaurant/data/model/restaurant_review.dart';
import 'package:restaurant/data/model/restaurant_search.dart';
import 'package:restaurant/data/model/restaurants.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  static const String _list = 'list';
  static const String _detail = 'detail/';
  static const String _search = 'search?q=';
  static const String _postReview = 'review';
  static const String imgUrl = '${_baseUrl}images/medium/';

  Future<Restaurants> listRestaurants() async {
    final response = await http.get(Uri.parse(_baseUrl + _list));
    if (response.statusCode == 200) {
      return Restaurants.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load list');
    }
  }

  Future<details.RestaurantDetails> restaurantDetails(String id) async {
    final response = await http.get(Uri.parse(_baseUrl + _detail + id));
    if (response.statusCode == 200) {
      return details.RestaurantDetails.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load details');
    }
  }

  Future<RestaurantSearch> restaurantSearch(String query) async {
    final response = await http.get(Uri.parse(_baseUrl + _search + query));
    if (response.statusCode == 200) {
      return RestaurantSearch.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load search');
    }
  }

  Future<RestaurantReview> postReview(CustomerReview review) async {
    var _review = jsonEncode(review.toJson());
    final response = await http.post(
      Uri.parse(_baseUrl + _postReview),
      body: _review,
      headers: <String, String>{
        "Content-Type": "application/json",
      },
    );
    return RestaurantReview.fromJson(json.decode(response.body));
  }
}
