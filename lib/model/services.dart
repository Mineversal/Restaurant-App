import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:restaurant/model/restaurant.dart';

class RestaurantSearch {
  static Future<List<Restaurant>> getRestaurant(String? query) async {
    if (query == null) {
      return [];
    }
    final json = await rootBundle.loadString('assets/local_restaurant.json');

    final parsed = jsonDecode(json);
    final data = parsed['restaurants'] as List<dynamic>;
    return data.map((json) => Restaurant.fromJson(json)).where((restaurant) {
      final titleLower = restaurant.name.toLowerCase();
      final cityLower = restaurant.city.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower) ||
          cityLower.contains(searchLower);
    }).toList();
  }
}
