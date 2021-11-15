import 'dart:async';

import 'package:flutter/material.dart';
import 'package:restaurant/data/api/api_service.dart';
import 'package:restaurant/data/model/restaurant_review.dart';
import 'package:restaurant/utils/enum.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  RestaurantDetailProvider({required this.apiService, required this.id}) {
    restaurantDetail(id);
  }

  late dynamic _restaurantResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;
  dynamic get result => _restaurantResult;
  ResultState get state => _state;

  Future<dynamic> restaurantDetail(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurantDetails = await apiService.restaurantDetails(id);
      _state = ResultState.hasData;
      notifyListeners();
      return _restaurantResult = restaurantDetails.restaurant;
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Terdapat Error: $e';
    }
  }

  Future<dynamic> postReview(CustomerReview review) async {
    try {
      final response = await apiService.postReview(review);

      if (!response.error) restaurantDetail(review.id!);
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Terdapat Error ini: $e';
    }
  }
}
