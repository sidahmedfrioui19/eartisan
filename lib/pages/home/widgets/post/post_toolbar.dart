import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:profinder/pages/home/widgets/post/book_appointment.dart';
import 'package:profinder/pages/messages/chat_room.dart';

import '../../../../utils/theme_data.dart';

class PostToolBar extends StatefulWidget {
  final IconData icon1;
  final IconData? icon2;
  final IconData? icon3;
  final String? user_id;
  final String? firstname;
  final String? lastname;
  final String? pictureUrl;
  final bool? available;
  final int? serviceId;

  const PostToolBar({
    Key? key,
    required this.icon1,
    this.icon2,
    this.serviceId,
    this.icon3,
    this.user_id,
    this.firstname,
    this.lastname,
    this.pictureUrl,
    this.available,
  }) : super(key: key);

  @override
  _PostToolBarState createState() => _PostToolBarState();
}

class _PostToolBarState extends State<PostToolBar> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(
            widget.icon1,
            color: AppTheme.primaryColor,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatRoom(
                  available: widget.available!,
                  firstname: widget.firstname!,
                  lastname: widget.lastname!,
                  pictureUrl: widget.pictureUrl!,
                  user_id: widget.user_id!,
                ),
              ),
            );
          },
        ),
        if (widget.icon3 != null)
          IconButton(
            icon: Icon(
              widget.icon3,
              color: AppTheme.primaryColor,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateAppointmentPage(
                    serviceId: widget.serviceId!,
                    professionalId: widget.user_id!,
                  ),
                ),
              );
            },
          ),
        if (widget.icon2 != null)
          IconButton(
            icon: Icon(
              isFavorite
                  ? FluentIcons.bookmark_16_filled
                  : FluentIcons.bookmark_16_regular,
              color: AppTheme.primaryColor,
            ),
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
              });
              if (isFavorite) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Service ajouté au favoris'),
                    duration: Duration(
                      seconds: 2,
                    ),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Service supprimé des favoris'),
                    duration: Duration(
                      seconds: 2,
                    ),
                  ),
                );
              }
            },
          ),
      ],
    );
  }
}
