import 'package:flutter/material.dart';
import 'package:profinder/models/post/service_detail.dart';

class PictureList extends StatelessWidget {
  final List<Picture> pictures;

  const PictureList({
    Key? key,
    required this.pictures,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return pictures.isNotEmpty
        ? ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: pictures.length,
            itemBuilder: (context, index) {
              final picture = pictures[index];
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                width: 150,
                height: 200,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    picture.link,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          )
        : Container();
  }
}
