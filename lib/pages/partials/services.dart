import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:profinder/utils/theme_data.dart';
import 'package:profinder/widgets/category.dart';
import 'package:profinder/widgets/post/post_service.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
              padding: EdgeInsets.only(left: 20, right: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Catégories",
                    style: AppTheme.elementTitle,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Voir tout",
                      style: TextStyle(
                        color: AppTheme.textColor,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  )
                ],
              )),
          Row(
            children: [
              Category(
                title: "Construction",
                icon: FluentIcons.building_16_filled,
              ),
            ],
          ),
          PostService(
            title: "Installation spots et vérification électrique",
            description:
                "J'ai besoin d'un électricien quelques vérification et réparation et installation spots (sanitaires et balcon)",
            username: "John Doe",
            job: "Plombier",
            pictureUrl: "https://via.placeholder.com/150",
          )
        ],
      ),
    );
  }
}
