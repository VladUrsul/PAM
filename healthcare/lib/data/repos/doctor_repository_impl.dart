// data/repos/doctor_repository_impl.dart
import 'package:healthcare/data/datasources/remote_data_source.dart';
import 'package:healthcare/domain/entities/banner.dart';
import 'package:healthcare/domain/entities/category.dart';
import 'package:healthcare/domain/entities/doctor.dart';
import 'package:healthcare/domain/entities/medical_center.dart';
import 'package:healthcare/domain/repos/doctor_repository.dart';

class DoctorRepositoryImpl implements DoctorRepository {
  final RemoteDataSource remoteDataSource;

  DoctorRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<MainBanner>> getBanners() async {
    final bannerModels = await remoteDataSource.getBanners();
    return bannerModels
        .map((banner) => MainBanner(image: banner.image))
        .toList();
  }

  @override
  Future<List<Category>> getCategories() async {
    final categoryModels = await remoteDataSource.getCategories();
    return categoryModels
        .map((category) => Category(icon: category.icon, title: category.title))
        .toList();
  }

  @override
  Future<List<MedicalCenter>> getNearbyCenters() async {
    final centerModels = await remoteDataSource.getNearbyCenters();
    return centerModels
        .map((center) => MedicalCenter(
              title: center.title,
              locationName: center.locationName,
              reviewRate: center.reviewRate,
              countReviews: center.countReviews,
              image: center.image,
            ))
        .toList();
  }

  @override
  Future<List<Doctor>> getDoctors() async {
    final doctorModels = await remoteDataSource.getDoctors();
    return doctorModels
        .map((doctor) => Doctor(
              fullName: doctor.fullName,
              typeOfDoctor: doctor.typeOfDoctor,
              locationOfCenter: doctor.locationOfCenter,
              reviewRate: doctor.reviewRate,
              reviewsCount: doctor.reviewsCount,
              image: doctor.image,
            ))
        .toList();
  }
}
