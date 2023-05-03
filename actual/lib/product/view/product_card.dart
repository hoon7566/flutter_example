import 'package:actual/common/const/colors.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              "asset/img/food/ddeok_bok_gi.jpg",
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
                "떡볶이",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
              ),
              Text(
                "떡볶이",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: BODY_TEXT_COLOR, fontSize: 14),
              ),
              Text(
                "떡볶이",
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
