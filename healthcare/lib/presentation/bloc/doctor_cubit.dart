// presentation/bloc/doctor_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthcare/domain/usecases/load_doctor_data.dart';
import 'package:healthcare/presentation/bloc/doctor_state.dart';

class DoctorCubit extends Cubit<DoctorState> {
  final LoadDoctorData loadDoctorData;

  DoctorCubit(this.loadDoctorData) : super(DoctorState.initial());

  void loadData() async {
    final banners = await loadDoctorData.execute();
    final categories = await loadDoctorData.executeCategories();
    final centers = await loadDoctorData.executeNearbyCenters();
    final doctors = await loadDoctorData.executeDoctors();

    emit(DoctorState.loaded(
      banners: banners,
      categories: categories,
      nearbyCenters: centers,
      doctors: doctors,
    ));
  }
}
