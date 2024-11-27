// data/datasources/remote_data_source.dart
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:healthcare/data/models/banner_model.dart';
import 'package:healthcare/data/models/category_model.dart';
import 'package:healthcare/data/models/doctor_model.dart';
import 'package:healthcare/data/models/medical_center_model.dart';

class RemoteDataSource {
  Future<List<MainBannerModel>> getBanners() async {
    final jsonString = await rootBundle.loadString('assets/json/banners.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => MainBannerModel.fromJson(json)).toList();
  }

  Future<List<CategoryModel>> getCategories() async {
    final jsonString =
        await rootBundle.loadString('assets/json/categories.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => CategoryModel.fromJson(json)).toList();
  }

  Future<List<MedicalCenterModel>> getNearbyCenters() async {
    final jsonString = await rootBundle.loadString('assets/json/centers.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => MedicalCenterModel.fromJson(json)).toList();
  }

  Future<List<DoctorModel>> getDoctors() async {
    final jsonString = await rootBundle.loadString('assets/json/doctors.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => DoctorModel.fromJson(json)).toList();
  }
}
