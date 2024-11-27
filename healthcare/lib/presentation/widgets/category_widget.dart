import 'package:flutter/material.dart';
import 'package:healthcare/domain/entities/category.dart';

class CategoryWidget extends StatelessWidget {
  final List<Category> categories;

  CategoryWidget(this.categories);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: categories.map((category) {
        return ListTile(
          leading: Image.asset(category.icon),
          title: Text(category.title),
        );
      }).toList(),
    );
  }
}
