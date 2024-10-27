import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
      home: DoctorHomePage(),
    );
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
          padding: EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 32.0,
          ),
          child: Column(
            children: [
              Row(
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
            ],
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 16.0, right: 16.0),
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
          Container(
            width: double.infinity,
            height: 180,
            child: Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    children: [
                      _buildBanner('assets/photos/1.png'),
                      _buildBanner('assets/photos/2.png'),
                      _buildBanner('assets/photos/3.png'),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                SmoothPageIndicator(
                  controller: _pageController,
                  count: 3,
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
          ),
          SizedBox(height: 20),
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
            children: [
              _buildCategoryItem(Icons.health_and_safety, "Dentistry"),
              _buildCategoryItem(Icons.favorite, "Cardiology"),
              _buildCategoryItem(Icons.heat_pump, "Pulmonology"),
              _buildCategoryItem(Icons.medical_services, "General"),
              _buildCategoryItem(Icons.emoji_people, "Neurology"),
              _buildCategoryItem(Icons.icecream, "Gastros"),
              _buildCategoryItem(Icons.science, "Laboratory"),
              _buildCategoryItem(Icons.vaccines, "Vaccination"),
            ],
          ),
          SizedBox(height: 20),
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
              children: [
                _buildMedicalCenterCard(
                  'Sunrise Health Clinic',
                  '123 Oak Street, CA 98765',
                  '5.0',
                  '58 Reviews',
                  'assets/photos/11.png',
                ),
                _buildMedicalCenterCard(
                  'Golden Cardiology Center',
                  '555 Bridge Street, NY 12345',
                  '4.9',
                  '103 Reviews',
                  'assets/photos/22.png',
                ),
                _buildMedicalCenterCard(
                  'Maple Health Associates',
                  '789 Pine Avenue, WA 56789',
                  '4.8',
                  '89 Reviews',
                  'assets/photos/33.png',
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text("Doctors Found",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          _buildDoctorItem(
            'Dr. Monica Patel',
            'Cardiologist',
            'Cardiology Center, USA',
            '5.0',
            '1,872 Reviews',
            'assets/photos/111.png',
          ),
          _buildDoctorItem(
            'Dr. Jessica Turner',
            'Gynecologist',
            'Women\'s Clinic, Seattle, USA',
            '4.9',
            '127 Reviews',
            'assets/photos/222.png',
          ),
          _buildDoctorItem(
            'Dr. Erica Johnson',
            'Orthopedic Surgery',
            'Maple Associates, NY, USA',
            '4.7',
            '5,223 Reviews',
            'assets/photos/333.png',
          ),
          _buildDoctorItem(
            'Dr. Emily Walker',
            'Pediatrics',
            'Serenity Pediatrics Clinic',
            '5.0',
            '405 Reviews',
            'assets/photos/444.png',
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

  Widget _buildCategoryItem(IconData icon, String title) {
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

  Widget _buildMedicalCenterCard(String name, String address, String rating,
      String reviews, String imagePath) {
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
                imagePath,
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
                  Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(address, style: TextStyle(fontSize: 12)),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      SizedBox(width: 4),
                      Text("$rating ($reviews)"),
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

  Widget _buildDoctorItem(String name, String specialty, String clinic,
      String rating, String reviews, String imagePath) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage(imagePath),
        ),
        title: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(specialty),
            Text(clinic),
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 16),
                SizedBox(width: 4),
                Text("$rating ($reviews)"),
              ],
            ),
          ],
        ),
        trailing: Icon(Icons.favorite_border),
      ),
    );
  }
}
