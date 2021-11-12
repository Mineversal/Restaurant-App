import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/common/styles.dart';
import 'package:restaurant/data/api/api_service.dart';
import 'package:restaurant/data/model/restaurants.dart';
import 'package:restaurant/provider/restaurant_list_provider.dart';
import 'package:restaurant/widget/restaurant_row_item.dart';

class RestaurantListTab extends StatelessWidget {
  const RestaurantListTab({Key? key}) : super(key: key);

  Widget _buildList(BuildContext context) {
    late RestaurantProvider provider;
    return ChangeNotifierProvider<RestaurantProvider>(
      create: (_) => RestaurantProvider(apiService: ApiService(), id: ''),
      child: Consumer<RestaurantProvider>(builder: (context, state, _) {
        provider = state;
        if (state.state == ResultState.loading) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        } else if (state.state == ResultState.hasData) {
          final List<Restaurant> restaurant = state.result;
          return _buildRestaurantItem(context, restaurant);
        } else if (state.state == ResultState.noData) {
          return Center(child: Text(state.message));
        } else if (state.state == ResultState.error) {
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/lost-connection.png", width: 100),
              const SizedBox(
                height: 10,
              ),
              const Center(
                  child: Text(
                "Lost Connection!",
                style: Styles.restaurantItemDescription,
              )),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                child: const Text("Refresh"),
                onPressed: () {
                  provider.listRestaurant();
                },
              ),
            ],
          ));
        } else {
          return const Center(
            child: Text("Error"),
          );
        }
      }),
    );
  }

  Widget _buildRestaurantItem(
      BuildContext context, List<Restaurant> restaurant) {
    return CustomScrollView(
      semanticChildCount: restaurant.length,
      slivers: <Widget>[
        const CupertinoSliverNavigationBar(
          largeTitle: Text('Restaurant'),
        ),
        SliverSafeArea(
          top: false,
          minimum: const EdgeInsets.only(top: 8),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index < restaurant.length) {
                  return RestaurantRowItem(
                    restaurant: restaurant[index],
                    lastItem: index == restaurant.length - 1,
                  );
                }
                return null;
              },
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildList(context);
  }
}
