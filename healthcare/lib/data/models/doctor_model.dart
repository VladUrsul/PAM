import 'package:healthcare/domain/entities/doctor.dart';

class DoctorModel extends Doctor {
  DoctorModel({
    required String fullName,
    required String typeOfDoctor,
    required String locationOfCenter,
    required double reviewRate,
    required int reviewsCount,
    required String image,
  }) : super(
          fullName: fullName,
          typeOfDoctor: typeOfDoctor,
          locationOfCenter: locationOfCenter,
          reviewRate: reviewRate,
          reviewsCount: reviewsCount,
          image: image,
        );

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      fullName: json['full_name'],
      typeOfDoctor: json['type_of_doctor'],
      locationOfCenter: json['location_of_center'],
      reviewRate: json['review_rate'].toDouble(),
      reviewsCount: json['reviews_count'],
      image: json['image'],
    );
  }
}
