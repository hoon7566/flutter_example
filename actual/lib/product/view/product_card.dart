import 'package:actual/common/const/colors.dart';
import 'package:actual/restaurant/model/restaurant_detail_model.dart';
import 'package:flutter/material.dart';

import '../../common/const/data.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String detail;
  final int price;

  const ProductCard({
      required this.imageUrl,
      required this.name,
      required this.detail,
      required this.price,
      super.key
  });

  factory ProductCard.fromModel({
    required RestaurantProductModel model,
  }) {
    return ProductCard(
      imageUrl: model.imgUrl,
      name: model.name,
      detail: model.detail,
      price: model.price,
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              imageUrl,
              width: 110,
              height: 110,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 16.0),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
              ),
              Text(
                detail,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: BODY_TEXT_COLOR, fontSize: 14),
              ),
              Text(
                "$price원",
                textAlign: TextAlign.end,
                style: TextStyle(
                    color: PRIMARY_COLOR,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
