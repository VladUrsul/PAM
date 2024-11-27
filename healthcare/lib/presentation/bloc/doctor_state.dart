// presentation/bloc/doctor_state.dart

import 'package:healthcare/domain/entities/category.dart';
import 'package:healthcare/domain/entities/banner.dart';
import 'package:healthcare/domain/entities/doctor.dart';
import 'package:healthcare/domain/entities/medical_center.dart';

class DoctorState {
  final List<MainBanner> banners;
  final List<Category> categories;
  final List<MedicalCenter> nearbyCenters;
  final List<Doctor> doctors;
  final bool isLoading;

  DoctorState({
    required this.banners,
    required this.categories,
    required this.nearbyCenters,
    required this.doctors,
    required this.isLoading,
  });

  // Initial state with loading status
  DoctorState.initial()
      : banners = [],
        categories = [],
        nearbyCenters = [],
        doctors = [],
        isLoading = true;

  // Loaded state when data is fetched successfully
  DoctorState.loaded({
    required List<MainBanner> banners,
    required List<Category> categories,
    required List<MedicalCenter> nearbyCenters,
    required List<Doctor> doctors,
  })  : banners = banners,
        categories = categories,
        nearbyCenters = nearbyCenters,
        doctors = doctors,
        isLoading = false;
}
