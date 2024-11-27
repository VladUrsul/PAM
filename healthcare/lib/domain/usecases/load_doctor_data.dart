import 'package:healthcare/domain/entities/banner.dart';
import 'package:healthcare/domain/entities/category.dart';
import 'package:healthcare/domain/entities/doctor.dart';
import 'package:healthcare/domain/entities/medical_center.dart';
import 'package:healthcare/domain/repos/doctor_repository.dart';

class LoadDoctorData {
  final DoctorRepository repository;

  LoadDoctorData(this.repository);

  Future<List<MainBanner>> execute() => repository.getBanners();
  Future<List<Category>> executeCategories() => repository.getCategories();
  Future<List<MedicalCenter>> executeNearbyCenters() =>
      repository.getNearbyCenters();
  Future<List<Doctor>> executeDoctors() => repository.getDoctors();
}
