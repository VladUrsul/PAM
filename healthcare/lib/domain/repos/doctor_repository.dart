import 'package:healthcare/domain/entities/banner.dart';
import 'package:healthcare/domain/entities/category.dart' as doctorCategory;
import 'package:healthcare/domain/entities/doctor.dart';
import 'package:healthcare/domain/entities/medical_center.dart';

abstract class DoctorRepository {
  Future<List<MainBanner>> getBanners();
  Future<List<doctorCategory.Category>> getCategories();
  Future<List<MedicalCenter>> getNearbyCenters();
  Future<List<Doctor>> getDoctors();
}
