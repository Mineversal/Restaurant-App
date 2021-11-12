import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant/common/styles.dart';
import 'package:restaurant/model/restaurant.dart';
import 'package:carousel_slider/carousel_slider.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  final Restaurant restaurant;
  const RestaurantDetailPage({
    Key? key,
    required this.restaurant,
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

    final List<Widget> drinksSliders = restaurant.menus.drinks
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

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(restaurant.name),
      ),
      child: Material(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              Hero(
                  tag: restaurant.pictureId,
                  child: Image.network(restaurant.pictureId)),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(restaurant.name, style: Styles.restaurantItemName),
                    const Padding(padding: EdgeInsets.only(top: 2)),
                    Row(children: [
                      const Icon(
                        CupertinoIcons.location_solid,
                        size: 13,
                        color: Color(0xFF8E8E93),
                      ),
                      const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2)),
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
                          '${restaurant.rating}',
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
