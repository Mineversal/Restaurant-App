// To parse this JSON data, do
//
//     final restaurantReview = restaurantReviewFromJson(jsonString);

import 'dart:convert';

RestaurantReview restaurantReviewFromJson(String str) =>
    RestaurantReview.fromJson(json.decode(str));

String restaurantReviewToJson(RestaurantReview data) =>
    json.encode(data.toJson());

class RestaurantReview {
  RestaurantReview({
    required this.error,
    required this.message,
    required this.customerReviews,
  });

  bool error;
  String message;
  List<CustomerReview> customerReviews;

  factory RestaurantReview.fromJson(Map<String, dynamic> json) =>
      RestaurantReview(
        error: json["error"],
        message: json["message"],
        customerReviews: List<CustomerReview>.from(
            json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "customerReviews":
            List<dynamic>.from(customerReviews.map((x) => x.toJson())),
      };
}

class CustomerReview {
  CustomerReview({
    required this.id,
    required this.name,
    required this.review,
    required this.date,
  });

  String? id;
  String name;
  String review;
  String date;

  factory CustomerReview.fromJson(Map<String, dynamic> json) => CustomerReview(
        id: json['id'],
        name: json["name"],
        review: json["review"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "review": review,
        "date": date,
      };
}
