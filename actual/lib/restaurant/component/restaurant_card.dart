import 'package:actual/common/const/colors.dart';
import 'package:actual/restaurant/model/restaurant_model.dart';
import 'package:flutter/material.dart';

class RestaurantCard extends StatelessWidget {
  //이미지 url
  final String imageUrl;

  // 레스토랑이름
  final String name;

  // 레스토랑 태그
  final List<String> tags;

  // 평점 갯수
  final int ratingsCount;

  // 배달시간
  final int deliveryTime;

  // 배달비
  final int deliveryFee;

  // 평점
  final double ratings;

  factory RestaurantCard.fromModel({
    required RestaurantModel model,
  }) {
    return RestaurantCard(
        imageUrl: model.thumbUrl,
        name: model.name,
        tags: model.tags,
        ratingsCount: model.ratingsCount,
        deliveryTime: model.deliveryTime,
        deliveryFee: model.deliveryFee,
        ratings: model.ratings);
  }

  const RestaurantCard({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.tags,
    required this.ratingsCount,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.ratings,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ClipRRect(
          // 이미지를 둥글게 만들기
          borderRadius: BorderRadius.circular(10.0),
          child: Image.network(imageUrl, fit: BoxFit.cover),
        ),
        const SizedBox(height: 16.0),
        Text(
          name,
          style: const TextStyle(
            fontSize: 20.0,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          tags.join(" • "),
          style: const TextStyle(
            fontSize: 14.0,
            color: BODY_TEXT_COLOR,
          ),
        ),
        const SizedBox(height: 8.0),
        Row(
          children: [
            _IconText(icon: Icons.star, label: ratings.toString()),
            renderDot(),
            _IconText(icon: Icons.receipt, label: ratingsCount.toString()),
            renderDot(),
            _IconText(icon: Icons.timelapse_outlined, label: '$deliveryTime 분'),
            renderDot(),
            _IconText(
                icon: Icons.monetization_on,
                label: deliveryFee == 0 ? '무료' : '$deliveryFee 원'),
          ],
        )
      ],
    );
  }

  Widget renderDot() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Text(" • ",
          style: TextStyle(
              fontSize: 12.0,
              color: BODY_TEXT_COLOR,
              fontWeight: FontWeight.w500)),
    );
  }
}

class _IconText extends StatelessWidget {
  final IconData icon;
  final String label;

  const _IconText({required this.icon, required this.label, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14.0, color: PRIMARY_COLOR),
        const SizedBox(width: 8.0),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w500,
            color: BODY_TEXT_COLOR,
          ),
        ),
      ],
    );
  }
}
