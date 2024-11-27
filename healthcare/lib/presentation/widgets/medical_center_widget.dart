// presentation/widgets/medical_center_widget.dart

import 'package:flutter/material.dart';
import 'package:healthcare/domain/entities/medical_center.dart';

class MedicalCenterWidget extends StatelessWidget {
  final MedicalCenter center;

  MedicalCenterWidget({required this.center});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
            child: Image.asset(
              center.image,
              width: double.infinity,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(center.title,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text(center.locationName, style: TextStyle(fontSize: 12)),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 16),
                    SizedBox(width: 4),
                    Text(
                        "${center.reviewRate} (${center.countReviews} Reviews)"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
