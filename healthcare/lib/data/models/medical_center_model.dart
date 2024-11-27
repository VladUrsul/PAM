import 'package:healthcare/domain/entities/medical_center.dart';

class MedicalCenterModel extends MedicalCenter {
  MedicalCenterModel({
    required String title,
    required String locationName,
    required double reviewRate,
    required int countReviews,
    required String image,
  }) : super(
          title: title,
          locationName: locationName,
          reviewRate: reviewRate,
          countReviews: countReviews,
          image: image,
        );

  factory MedicalCenterModel.fromJson(Map<String, dynamic> json) {
    return MedicalCenterModel(
      title: json['title'],
      locationName: json['location_name'],
      reviewRate: json['review_rate'].toDouble(),
      countReviews: json['count_reviews'],
      image: json['image'],
    );
  }
}
