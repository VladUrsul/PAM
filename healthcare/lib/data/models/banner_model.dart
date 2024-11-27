import 'package:healthcare/domain/entities/banner.dart';

class MainBannerModel extends MainBanner {
  MainBannerModel({required String image}) : super(image: image);

  factory MainBannerModel.fromJson(Map<String, dynamic> json) {
    return MainBannerModel(image: json['image']);
  }
}
