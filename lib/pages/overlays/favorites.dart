import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:profinder/models/favorite/favorite.dart';
import 'package:profinder/pages/home/widgets/favorite.dart';
import 'package:profinder/services/favorite/favorite.dart';
import 'package:profinder/services/favorite/favorite_list.dart';
import 'package:profinder/utils/theme_data.dart';
import 'package:profinder/widgets/appbar/overlay_top_bar.dart';
import 'package:profinder/widgets/lists/generic_vertical_list.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  final FavoriteListService favoriteList = FavoriteListService();
  final FavoriteService favoriteService = FavoriteService();

  late Future<List<Favorite>> _favoritesFuture;

  Future<void> _loadFavorites() async {
    _favoritesFuture = favoriteList.fetch();
  }

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: OverlayTopBar(
        title: 'Mes Favoris',
        dismissIcon: FluentIcons.chevron_left_12_filled,
      ),
      body: Container(
        child: FutureBuilder<List<Favorite>>(
          future: _favoritesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final List<Favorite>? favorites = snapshot.data;
              if (favorites != null && favorites.isNotEmpty) {
                return Column(
                  children: [
                    SizedBox(height: 10),
                    VerticalList<Favorite>(
                      future: _favoritesFuture,
                      errorMessage: "Liste des favoris vide",
                      emptyText: "Liste des favoris vide",
                      itemBuilder: (favorite) {
                        return Expanded(
                          child: FavoriteWidget(
                            favorite: favorite,
                            onPress: () async {
                              try {
                                await favoriteService
                                    .deleteById(favorite.favoriteId);
                                setState(() {
                                  _loadFavorites();
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'Supprimé des favoris'), // Confirmation message
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Erreur $e'), // Error message
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              }
                            },
                          ),
                        );
                      },
                    ),
                  ],
                );
              } else {
                return SizedBox(); // Return an empty widget if there are no favorites
              }
            }
          },
        ),
      ),
    );
  }
}
