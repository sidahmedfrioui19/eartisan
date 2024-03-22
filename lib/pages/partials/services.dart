import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:profinder/models/category.dart';
import 'package:profinder/services/category.dart';
import 'package:profinder/utils/theme_data.dart';
import 'package:profinder/widgets/category.dart';
import 'package:profinder/widgets/post/post_service.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({Key? key}) : super(key: key);

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  late Future<List<CategoryEntity>> _categoriesFuture;

  final CategoryService category = CategoryService();

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    _categoriesFuture = category.fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Catégories',
                  style: AppTheme.elementTitle,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Voir tout',
                    style: TextStyle(
                      color: AppTheme.textColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          FutureBuilder<List<CategoryEntity>>(
            future: _categoriesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                return SizedBox(
                  height: 100, // Adjust the height as needed
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Category(
                          icon: FluentIcons.access_time_20_filled,
                          title: snapshot.data![index].name,
                        ),
                      );
                    },
                  ),
                );
              } else {
                return Center(child: Text('No data available'));
              }
            },
          ),
          PostService(
            title: 'Installation spots et vérification électrique',
            description:
                'J\'ai besoin d\'un électricien quelques vérification et réparation et installation spots (sanitaires et balcon)',
            username: 'John Doe',
            job: 'Plombier',
            pictureUrl: 'https://via.placeholder.com/150',
          ),
        ],
      ),
    );
  }
}
