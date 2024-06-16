import 'package:flutter/material.dart';
import 'package:profinder/models/category/category.dart';
import 'package:profinder/models/favorite/favorite.dart';
import 'package:profinder/pages/home/service_detail.dart';
import 'package:profinder/pages/home/widgets/category/category_list.dart';
import 'package:profinder/pages/search/search.dart';
import 'package:profinder/services/category/category.dart';
import 'package:profinder/services/favorite/favorite.dart';
import 'package:profinder/services/favorite/favorite_list.dart';
import 'package:profinder/services/post/professional.dart';
import 'package:profinder/utils/helpers.dart';
import 'package:profinder/utils/theme_data.dart';
import 'package:profinder/pages/home/widgets/category.dart';
import 'package:profinder/widgets/cards/snapshot_error.dart';
import 'package:profinder/pages/home/widgets/post/service.dart';
import 'package:profinder/widgets/progress/loader.dart';

import '../../models/post/service.dart';

class ServicesPage extends StatefulWidget {
  final String? userId;
  final String? jwtToken;

  const ServicesPage({
    Key? key,
    required this.userId,
    this.jwtToken,
  }) : super(key: key);

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  late Future<List<CategoryEntity>> _categoriesFuture;
  late Future<List<ServiceEntity>> _servicesFuture;
  late Future<List<Favorite>> _favoritesFuture;

  final CategoryService category = CategoryService();
  final ProfessionalService service = ProfessionalService();
  final FavoriteListService favoriteList = FavoriteListService();
  final FavoriteService favoriteService = FavoriteService();

  @override
  void initState() {
    super.initState();
    _loadCategories();
    _loadServices();
    _loadFavorites();
  }

  Future<void> _loadCategories() async {
    _categoriesFuture = category.fetch();
  }

  Future<void> _loadServices() async {
    _servicesFuture = service.fetch();
  }

  Future<void> _loadFavorites() async {
    _favoritesFuture = favoriteList.fetch();
  }

  Future<bool> _isServiceInFavorites(int serviceId) async {
    final List<Favorite> favorites = await _favoritesFuture;

    if (favorites.isNotEmpty) {
      final List<int> favoriteServiceIds =
          favorites.map((favorite) => favorite.service.serviceId).toList();
      return favoriteServiceIds.contains(serviceId);
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
              child: TextField(
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'Search professionals and services',
                  prefixIcon: Icon(Icons.search),
                  fillColor: Color(0xFFf5f6fa),
                  filled: true,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:
                        BorderSide.none, // This removes the default border
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:
                        BorderSide.none, // This removes the enabled border
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:
                        BorderSide.none, // This removes the focused border
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchPage(),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Categories',
                    style: AppTheme.elementTitle,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CategoryList(jwtToken: widget.jwtToken),
                        ),
                      );
                    },
                    child: Text(
                      'View all',
                      style: TextStyle(
                        color: AppTheme.textColor,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder<List<CategoryEntity>>(
              future: _categoriesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Category(
                          iconUrl: null,
                          title: null,
                          subcategories: [],
                          jwtToken: widget.jwtToken,
                        );
                      },
                    ),
                  );
                } else if (snapshot.hasError) {
                  return SnapshotErrorWidget(error: snapshot.error);
                } else {
                  List<CategoryEntity>? categories = snapshot.data;
                  if (categories != null && categories.isNotEmpty) {
                    return SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          CategoryEntity category = categories[index];
                          return Category(
                            iconUrl: category.icon!,
                            title: category.name,
                            subcategories: category.subcategories,
                            jwtToken: widget.jwtToken,
                          );
                        },
                      ),
                    );
                  } else {
                    return Text('No categories found');
                  }
                }
              },
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Services',
                style: AppTheme.elementTitle,
              ),
            ),
            FutureBuilder<List<ServiceEntity>>(
              future: _servicesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    margin: EdgeInsets.all(12),
                    height: 400,
                    width: 400,
                    decoration: BoxDecoration(
                      color: AppTheme.inputColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return SnapshotErrorWidget(error: snapshot.error);
                } else {
                  List<ServiceEntity>? services = snapshot.data;
                  if (services != null && services.isNotEmpty) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: services.length,
                      itemBuilder: (context, index) {
                        ServiceEntity service = services[index];
                        return FutureBuilder<bool>(
                          future: _isServiceInFavorites(service.serviceId!),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return AppLoading();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              bool isFavorite = snapshot.data ?? false;
                              return PostService(
                                title: service.title ?? '',
                                description: service.description ?? '',
                                username:
                                    '${service.user.firstname} ${service.user.lastname}',
                                job: '@${service.user.username}',
                                pictureUrl: service.user.profilePic,
                                available:
                                    Helpers.boolVal(service.user.available),
                                pictures: service.pictures,
                                firstname: service.user.firstname,
                                lastname: service.user.lastname,
                                userId: service.user.userId,
                                serviceId: service.serviceId!,
                                currentUserId: widget.userId,
                                isFavorite: isFavorite,
                                onPress: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ServiceDetail(
                                        serviceId: service.serviceId,
                                        loggedIn: true,
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          },
                        );
                      },
                    );
                  } else {
                    return Text('No services found');
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
