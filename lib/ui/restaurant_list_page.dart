import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant/model/restaurant.dart';
import 'package:restaurant/ui/restaurant_row_item.dart';

class RestaurantListTab extends StatelessWidget {
  const RestaurantListTab({Key? key}) : super(key: key);

  Widget _buildList(BuildContext context) {
    return FutureBuilder<String>(
      future: DefaultAssetBundle.of(context)
          .loadString('assets/local_restaurant.json'),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
                "Data Tidak berhasil ditampilkan karena terjadi error: ${snapshot.error}"),
          );
        } else if (snapshot.hasData) {
          final List<Restaurant> restaurant =
              Restaurant.parseRestaurants(snapshot.data);
          return _buildRestaurantItem(context, restaurant);
        } else {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        }
      },
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
