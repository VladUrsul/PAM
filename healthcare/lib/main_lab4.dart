// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthcare/data/datasources/remote_data_source.dart';
import 'package:healthcare/data/repos/doctor_repository_impl.dart';
import 'package:healthcare/domain/usecases/load_doctor_data.dart';
import 'package:healthcare/presentation/bloc/doctor_cubit.dart';
import 'package:healthcare/presentation/views/doctor_home_page.dart';

void main() {
  final remoteDataSource = RemoteDataSource();
  final repository = DoctorRepositoryImpl(remoteDataSource);
  final usecase = LoadDoctorData(repository);

  runApp(DoctorFinderApp(usecase));
}

class DoctorFinderApp extends StatelessWidget {
  final LoadDoctorData loadDoctorData;

  DoctorFinderApp(this.loadDoctorData);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.blue),
      home: BlocProvider(
        create: (_) => DoctorCubit(loadDoctorData)..loadData(),
        child: DoctorHomePage(),
      ),
    );
  }
}
