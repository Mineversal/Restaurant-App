import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/common/styles.dart';
import 'package:restaurant/data/model/restaurant_details.dart';
import 'package:restaurant/data/model/restaurants.dart' as resto;
import 'package:restaurant/provider/database_provider.dart';
import 'package:restaurant/provider/restaurant_detail_provider.dart';
import 'package:restaurant/widget/review_dialog.dart';

class RestaurantDetail extends StatelessWidget {
  final Restaurant restaurant;
  final RestaurantDetailProvider providers;
  final resto.Restaurant restaurants;

  const RestaurantDetail({
    Key? key,
    required this.providers,
    required this.restaurant,
    required this.restaurants,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> foodsSliders = restaurant.menus.foods
        .map((item) => Container(
              margin: const EdgeInsets.all(1.0),
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.asset("assets/images/makanan.png",
                          fit: BoxFit.cover, width: 1000.0),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: Text(
                            item.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.transparent,
                            ),
                          ),
                          onPressed: () {}),
                    ],
                  )),
            ))
        .toList();

    final List<Widget> drinksSliders = restaurant.menus.foods
        .map((item) => Container(
              margin: const EdgeInsets.all(1.0),
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.asset("assets/images/minuman.png",
                          fit: BoxFit.cover, width: 1000.0),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: Text(
                            item.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.transparent,
                            ),
                          ),
                          onPressed: () {}),
                    ],
                  )),
            ))
        .toList();

    return Consumer<DatabaseProvider>(builder: (context, provider, child) {
      return FutureBuilder<bool>(
        future: provider.isFavorited(restaurant.id),
        builder: (context, snapshot) {
          var isFavorited = snapshot.data ?? false;
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Column(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(restaurant.name, style: Styles.restaurantItemName),
                      isFavorited
                          ? IconButton(
                              icon: const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                              onPressed: () =>
                                  provider.removeFavorites(restaurant.id),
                            )
                          : IconButton(
                              icon: const Icon(
                                Icons.favorite_border,
                                color: Colors.red,
                              ),
                              onPressed: () =>
                                  provider.addFavorite(restaurants),
                            ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(top: 2)),
                  Row(children: [
                    const Icon(
                      CupertinoIcons.location_solid,
                      size: 13,
                      color: Color(0xFF8E8E93),
                    ),
                    const Padding(padding: EdgeInsets.symmetric(horizontal: 2)),
                    Text(
                      restaurant.city,
                      style: Styles.restaurantItemPreview,
                    ),
                  ]),
                  const Padding(padding: EdgeInsets.only(top: 2)),
                  Row(
                    children: [
                      const Icon(
                        CupertinoIcons.star_fill,
                        size: 13,
                        color: Color(0xFF8E8E93),
                      ),
                      const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2)),
                      Text(
                        restaurant.rating.toString(),
                        style: Styles.restaurantItemPreview,
                      )
                    ],
                  ),
                  const SizedBox(height: 5),
                  const Divider(color: Colors.grey),
                  const Text(
                    "Deskripsi",
                    style: Styles.restaurantItemTitleDescription,
                  ),
                  const Padding(padding: EdgeInsets.only(top: 2)),
                  Text(
                    restaurant.description,
                    textAlign: TextAlign.justify,
                    style: Styles.restaurantItemDescription,
                  ),
                  const SizedBox(height: 5),
                  const Divider(color: Colors.grey),
                  const Text(
                    "Menu",
                    style: Styles.restaurantItemTitleDescription,
                  ),
                  const Padding(padding: EdgeInsets.only(top: 5)),
                  const Text(
                    "Makanan",
                    style: Styles.restaurantItemDescription,
                  ),
                  const Padding(padding: EdgeInsets.only(top: 5)),
                  CarouselSlider(
                    options: CarouselOptions(
                      aspectRatio: 2.0,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: false,
                      initialPage: 2,
                      autoPlay: true,
                    ),
                    items: foodsSliders,
                  ),
                  const Padding(padding: EdgeInsets.only(top: 5)),
                  const Text(
                    "Minuman",
                    style: Styles.restaurantItemDescription,
                  ),
                  const Padding(padding: EdgeInsets.only(top: 5)),
                  CarouselSlider(
                    options: CarouselOptions(
                      aspectRatio: 2.0,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: false,
                      initialPage: 2,
                      autoPlay: true,
                    ),
                    items: drinksSliders,
                  ),
                  const Divider(color: Colors.grey),
                  const Text(
                    "Review",
                    style: Styles.restaurantItemTitleDescription,
                  ),
                  const Padding(padding: EdgeInsets.only(top: 5)),
                  SizedBox(
                    height: 130,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: restaurant.customerReviews.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(2),
                          child: SizedBox(
                            width: 200,
                            child: Card(
                              elevation: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Column(
                                    children: [
                                      Text(
                                        restaurant.customerReviews[index].name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                      ),
                                      Text(
                                        restaurant.customerReviews[index].date,
                                        style: Theme.of(context)
                                            .textTheme
                                            .overline,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '"' +
                                            restaurant
                                                .customerReviews[index].review +
                                            '"',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                        textAlign: TextAlign.center,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 5)),
                  TextButton(
                    child: Text(
                      "Tambahkan review",
                      style: Theme.of(context).textTheme.button,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => ReviewDialog(
                            provider: providers, id: restaurant.id),
                      );
                    },
                  ),
                ],
              )
            ]),
          );
        },
      );
    });
  }
}
