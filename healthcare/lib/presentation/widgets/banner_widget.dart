import 'package:flutter/material.dart';
import 'package:healthcare/domain/entities/banner.dart';

class BannerWidget extends StatelessWidget {
  final List<MainBanner> banners;

  BannerWidget(this.banners);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: banners.map((banner) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            image: DecorationImage(
              image: AssetImage(banner.image),
              fit: BoxFit.cover,
            ),
          ),
        );
      }).toList(),
    );
  }
}
