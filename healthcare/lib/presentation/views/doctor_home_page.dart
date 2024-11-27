import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthcare/presentation/bloc/doctor_cubit.dart';
import 'package:healthcare/presentation/widgets/banner_widget.dart';
import 'package:healthcare/presentation/widgets/category_widget.dart';
import 'package:healthcare/presentation/widgets/doctor_widget.dart';
//import 'package:healthcare/presentation/widgets/medical_center_widget.dart';
import 'package:healthcare/presentation/bloc/doctor_state.dart';
import 'package:healthcare/domain/entities/banner.dart';
import 'package:healthcare/domain/entities/category.dart';
import 'package:healthcare/domain/entities/doctor.dart';
//import 'package:healthcare/domain/entities/medical_center.dart';

class DoctorHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Doctor Finder")),
      body: BlocBuilder<DoctorCubit, DoctorState>(
        builder: (context, state) {
          if (state.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView(
            padding: EdgeInsets.all(16.0),
            children: [
              _buildBannerSection(state.banners),
              SizedBox(height: 20),
              _buildCategoriesSection(state.categories),
              SizedBox(height: 20),
              //_buildNearbyCentersSection(state.nearbyCenters),
              SizedBox(height: 20),
              _buildDoctorsSection(state.doctors),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBannerSection(List<MainBanner> banners) {
    return BannerWidget(banners);
  }

  Widget _buildCategoriesSection(List<Category> categories) {
    return CategoryWidget(categories);
  }

  // Widget _buildNearbyCentersSection(List<MedicalCenter> centers) {
  // return MedicalCenterWidget(centers);
  // }

  Widget _buildDoctorsSection(List<Doctor> doctors) {
    return DoctorWidget(doctors);
  }
}
