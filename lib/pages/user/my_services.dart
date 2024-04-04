import 'package:flutter/material.dart';
import 'package:profinder/models/post/user_service.dart';
import 'package:profinder/services/user_service.dart';
import 'package:profinder/utils/theme_data.dart';

class MyServices extends StatefulWidget {
  const MyServices({Key? key}) : super(key: key);

  @override
  State<MyServices> createState() => _MyServicesState();
}

class _MyServicesState extends State<MyServices> {
  late Future<List<ServiceDataEntity>> _services;

  final UserPostService service = UserPostService();

  @override
  void initState() {
    super.initState();
    _loadServices();
  }

  Future<void> _loadServices() async {
    _services = service.fetchUserServices();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            FutureBuilder<List<ServiceDataEntity>>(
              future: _services,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final services = snapshot.data!;
                  print('services $services');
                  return Column(
                    children: services.map((service) {
                      return _buildServiceCard(service);
                    }).toList(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(ServiceDataEntity service) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      elevation: 2,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              service.title!,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: AppTheme.primaryColor,
              ),
            ),
            SizedBox(height: 8),
            Text(
              service.description!,
              style: TextStyle(
                fontSize: 16,
                color: AppTheme.primaryColor,
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text(
                  '',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.edit),
                  color: Colors.blue,
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
