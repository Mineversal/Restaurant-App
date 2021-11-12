import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/common/styles.dart';
import 'package:restaurant/data/api/api_service.dart';
import 'package:restaurant/data/model/restaurants.dart';
import 'package:restaurant/provider/restaurant_detail_provider.dart';
import 'package:restaurant/widget/restaurant_detail.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  final Restaurant restaurant;

  const RestaurantDetailPage({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RestaurantDetailProvider provider;

    return ChangeNotifierProvider<RestaurantDetailProvider>(
      create: (_) =>
          RestaurantDetailProvider(apiService: ApiService(), id: restaurant.id),
      child: CupertinoPageScaffold(
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
                  child: Image.network(
                    ApiService.imgUrl + restaurant.pictureId,
                  ),
                ),
                Consumer<RestaurantDetailProvider>(
                  builder: (context, state, _) {
                    provider = state;
                    if (state.state == ResultState.loading) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 4,
                            ),
                            const CupertinoActivityIndicator(),
                          ],
                        ),
                      );
                    } else if (state.state == ResultState.hasData) {
                      final restaurant = state.result;
                      return RestaurantDetail(
                        restaurant: restaurant,
                        provider: provider,
                      );
                    } else if (state.state == ResultState.noData) {
                      return Center(child: Text(state.message));
                    } else if (state.state == ResultState.error) {
                      return Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/lost-connection.png",
                              width: 100),
                          const SizedBox(height: 10),
                          const Text(
                            "Lost Connection!",
                            style: Styles.restaurantItemDescription,
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            child: const Text("Refresh"),
                            onPressed: () {
                              provider.restaurantDetail(restaurant.id);
                            },
                          ),
                        ],
                      ));
                    } else {
                      return const Center(child: Text('Error'));
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
