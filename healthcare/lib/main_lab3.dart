import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(DoctorFinderApp());
}

class DoctorFinderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: BlocProvider(
        create: (_) => DoctorCubit()..loadData(),
        child: DoctorHomePage(),
      ),
    );
  }
}

// Models for JSON Data
class BannerModel {
  final String image;

  BannerModel({required this.image});

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(image: json['image']);
  }
}

class CategoryModel {
  final String icon;
  final String title;

  CategoryModel({required this.icon, required this.title});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      icon: json['icon'],
      title: json['title'],
    );
  }
}

class MedicalCenterModel {
  final String title;
  final String locationName;
  final double reviewRate;
  final int countReviews;
  final String image;

  MedicalCenterModel({
    required this.title,
    required this.locationName,
    required this.reviewRate,
    required this.countReviews,
    required this.image,
  });

  factory MedicalCenterModel.fromJson(Map<String, dynamic> json) {
    return MedicalCenterModel(
      title: json['title'],
      locationName: json['location_name'],
      reviewRate: json['review_rate'],
      countReviews: json['count_reviews'],
      image: json['image'],
    );
  }
}

class DoctorModel {
  final String fullName;
  final String typeOfDoctor;
  final String locationOfCenter;
  final double reviewRate;
  final int reviewsCount;
  final String image;

  DoctorModel({
    required this.fullName,
    required this.typeOfDoctor,
    required this.locationOfCenter,
    required this.reviewRate,
    required this.reviewsCount,
    required this.image,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      fullName: json['full_name'],
      typeOfDoctor: json['type_of_doctor'],
      locationOfCenter: json['location_of_center'],
      reviewRate: json['review_rate'],
      reviewsCount: json['reviews_count'],
      image: json['image'],
    );
  }
}

// Define the states for the DoctorCubit
class DoctorState {
  final List<BannerModel> banners;
  final List<CategoryModel> categories;
  final List<MedicalCenterModel> nearbyCenters;
  final List<DoctorModel> doctors;
  final bool isLoading;

  DoctorState({
    required this.banners,
    required this.categories,
    required this.nearbyCenters,
    required this.doctors,
    required this.isLoading,
  });

  factory DoctorState.initial() {
    return DoctorState(
      banners: [],
      categories: [],
      nearbyCenters: [],
      doctors: [],
      isLoading: true,
    );
  }

  factory DoctorState.loaded({
    required List<BannerModel> banners,
    required List<CategoryModel> categories,
    required List<MedicalCenterModel> nearbyCenters,
    required List<DoctorModel> doctors,
  }) {
    return DoctorState(
      banners: banners,
      categories: categories,
      nearbyCenters: nearbyCenters,
      doctors: doctors,
      isLoading: false,
    );
  }
}

// Cubit to load and manage doctor data
class DoctorCubit extends Cubit<DoctorState> {
  DoctorCubit() : super(DoctorState.initial());

  void loadData() async {
    final data = await _loadJsonData();

    emit(DoctorState.loaded(
      banners: (data['banners'] as List)
          .map((item) => BannerModel.fromJson(item))
          .toList(),
      categories: (data['categories'] as List)
          .map((item) => CategoryModel.fromJson(item))
          .toList(),
      nearbyCenters: (data['nearby_centers'] as List)
          .map((item) => MedicalCenterModel.fromJson(item))
          .toList(),
      doctors: (data['doctors'] as List)
          .map((item) => DoctorModel.fromJson(item))
          .toList(),
    ));
  }

  Future<Map<String, dynamic>> _loadJsonData() async {
    final jsonString = await rootBundle.loadString('assets/json/json.json');
    return json.decode(jsonString);
  }
}

class DoctorHomePage extends StatelessWidget {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.location_on, color: Colors.black),
                  SizedBox(width: 8),
                  Text('Seattle, USA', style: TextStyle(fontSize: 18)),
                  Icon(Icons.keyboard_arrow_down),
                ],
              ),
              Icon(Icons.notifications, color: Colors.black),
            ],
          ),
        ),
      ),
      body: BlocBuilder<DoctorCubit, DoctorState>(
        builder: (context, state) {
          if (state.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            children: [
              TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search doctor...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              SizedBox(height: 20),
              _buildBannerSection(state.banners),
              SizedBox(height: 20),
              _buildCategoriesSection(state.categories),
              SizedBox(height: 20),
              _buildNearbyCentersSection(state.nearbyCenters),
              SizedBox(height: 20),
              _buildDoctorsSection(state.doctors),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBannerSection(List<BannerModel> banners) {
    return Container(
      width: double.infinity,
      height: 180,
      child: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              children:
                  banners.map((banner) => _buildBanner(banner.image)).toList(),
            ),
          ),
          SizedBox(height: 8),
          SmoothPageIndicator(
            controller: _pageController,
            count: banners.length,
            effect: WormEffect(
              dotHeight: 8.0,
              dotWidth: 8.0,
              spacing: 8.0,
              dotColor: Colors.grey[300]!,
              activeDotColor: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBanner(String imagePath) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildCategoriesSection(List<CategoryModel> categories) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Categories",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text("See All", style: TextStyle(color: Colors.blue)),
          ],
        ),
        SizedBox(height: 10),
        GridView.count(
          shrinkWrap: true,
          crossAxisCount: 4,
          childAspectRatio: 0.8,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          physics: NeverScrollableScrollPhysics(),
          children: categories
              .map((category) =>
                  _buildCategoryItem(category.icon, category.title))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildCategoryItem(String iconName, String title) {
    IconData icon = _getIconData(iconName);
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 185, 217, 243),
            shape: BoxShape.circle,
          ),
          padding: EdgeInsets.all(16),
          child: Icon(icon,
              color: const Color.fromARGB(255, 9, 107, 235), size: 28),
        ),
        SizedBox(height: 8),
        Text(title,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
      ],
    );
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'Icons.favorite':
        return Icons.favorite;
      case 'Icons.health_and_safety':
        return Icons.health_and_safety;
      case 'Icons.heat_pump':
        return Icons.heat_pump;
      case 'Icons.medical_services':
        return Icons.medical_services;
      case 'Icons.emoji_people':
        return Icons.emoji_people;
      case 'Icons.icecream':
        return Icons.icecream;
      case 'Icons.science':
        return Icons.science;
      case 'Icons.vaccines':
        return Icons.vaccines;
      default:
        return Icons.help_outline;
    }
  }

  Widget _buildNearbyCentersSection(List<MedicalCenterModel> nearbyCenters) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Nearby Medical Centers",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text("See All", style: TextStyle(color: Colors.blue)),
          ],
        ),
        SizedBox(height: 10),
        SizedBox(
          height: 250,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: nearbyCenters
                .map((center) => _buildMedicalCenterCard(center))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildMedicalCenterCard(MedicalCenterModel center) {
    return Container(
      width: 250,
      margin: EdgeInsets.only(right: 10),
      child: Card(
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
                  const SizedBox(height: 4),
                  Text(center.locationName, style: TextStyle(fontSize: 12)),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
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
      ),
    );
  }

  Widget _buildDoctorsSection(List<DoctorModel> doctors) {
    return Column(
      children: [
        const Text("Doctors Found",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Column(
          children: doctors.map((doctor) => _buildDoctorItem(doctor)).toList(),
        ),
      ],
    );
  }

  Widget _buildDoctorItem(DoctorModel doctor) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage(doctor.image),
        ),
        title: Text(doctor.fullName,
            style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(doctor.typeOfDoctor),
            Text(doctor.locationOfCenter),
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 16),
                SizedBox(width: 4),
                Text("${doctor.reviewRate} (${doctor.reviewsCount} Reviews)"),
              ],
            ),
          ],
        ),
        trailing: Icon(Icons.favorite_border),
      ),
    );
  }
}
