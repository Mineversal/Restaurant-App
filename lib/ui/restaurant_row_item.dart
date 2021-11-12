import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant/model/restaurant.dart';
import 'package:restaurant/common/styles.dart';
import 'package:restaurant/ui/restaurant_detail_page.dart';

class RestaurantRowItem extends StatelessWidget {
  const RestaurantRowItem({
    required this.restaurant,
    required this.lastItem,
    Key? key,
  }) : super(key: key);

  final Restaurant restaurant;
  final bool lastItem;

  @override
  Widget build(BuildContext context) {
    final row = SafeArea(
      top: false,
      bottom: false,
      minimum: const EdgeInsets.only(
        left: 16,
        top: 8,
        bottom: 8,
        right: 8,
      ),
      child: Material(
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, RestaurantDetailPage.routeName,
                arguments: restaurant);
          },
          child: Row(
            children: <Widget>[
              Flexible(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Hero(
                    tag: restaurant.pictureId,
                    child: Image.network(
                      restaurant.pictureId,
                      fit: BoxFit.cover,
                      width: 76,
                      height: 76,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        restaurant.name,
                        style: Styles.restaurantRowItemName,
                      ),
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
                          style: Styles.restaurantRowItemPreview,
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
                            style: Styles.restaurantRowItemPreview,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    if (lastItem) {
      return row;
    }

    return Column(
      children: <Widget>[
        row,
        Padding(
          padding: const EdgeInsets.only(
            left: 100,
            right: 16,
          ),
          child: Container(
            height: 1,
            color: Styles.restaurantRowDivider,
          ),
        ),
      ],
    );
  }
}
