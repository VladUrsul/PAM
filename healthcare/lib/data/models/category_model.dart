import 'package:healthcare/domain/entities/category.dart';

class CategoryModel extends Category {
  CategoryModel({required String icon, required String title})
      : super(icon: icon, title: title);

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(icon: json['icon'], title: json['title']);
  }
}
