import 'package:flutter/material.dart';
import 'package:healthcare/domain/entities/doctor.dart';

class DoctorWidget extends StatelessWidget {
  final List<Doctor> doctors;

  DoctorWidget(this.doctors);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: doctors.map((doctor) {
        return ListTile(
          leading: Image.asset(doctor.image),
          title: Text(doctor.fullName),
          subtitle: Text(doctor.typeOfDoctor),
        );
      }).toList(),
    );
  }
}
