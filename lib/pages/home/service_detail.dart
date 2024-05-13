import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:profinder/models/post/service_detail.dart';
import 'package:profinder/models/review/review.dart';
import 'package:profinder/pages/home/widgets/contact_detail.dart';
import 'package:profinder/pages/home/widgets/heading_title.dart';
import 'package:profinder/pages/home/widgets/picture_list.dart';
import 'package:profinder/pages/home/widgets/post/book_appointment.dart';
import 'package:profinder/pages/home/widgets/price_card.dart';
import 'package:profinder/pages/home/widgets/review_list.dart';
import 'package:profinder/services/favorite/favorite.dart';
import 'package:profinder/services/post/professional.dart';
import 'package:profinder/services/review/review.dart';
import 'package:profinder/utils/theme_data.dart';
import 'package:profinder/widgets/appbar/overlay_top_bar.dart';
import 'package:profinder/widgets/buttons/filled_button.dart';
import 'package:profinder/widgets/cards/snapshot_error.dart';
import 'package:profinder/widgets/progress/loader.dart';

class ServiceDetail extends StatefulWidget {
  final bool? isFavorite;
  final int? serviceId;
  final bool? loggedIn;

  const ServiceDetail({
    Key? key,
    required this.serviceId,
    this.isFavorite,
    this.loggedIn,
  }) : super(key: key);

  @override
  State<ServiceDetail> createState() => _ServiceDetailState();
}

class _ServiceDetailState extends State<ServiceDetail> {
  late Future<ServiceDetailEntity> _services;
  late Future<List<Review>> _reviews;

  ProfessionalService service = ProfessionalService();
  FavoriteService favorite = FavoriteService();
  ReviewService review = ReviewService();

  late int service_id;
  late String professional_id;

  @override
  void initState() {
    super.initState();
    _loadService(widget.serviceId);
    _loadreviews(widget.serviceId!);
  }

  Future<void> _loadService(int? id) async {
    _services =
        service.fetchService((json) => ServiceDetailEntity.fromJson(json), id);
  }

  Future<void> _loadreviews(int id) async {
    _reviews = review.fetch(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: OverlayTopBar(
        title: "Service details",
        dismissIcon: FluentIcons.chevron_left_12_filled,
      ),

      // Inside the build method of ServiceDetail widget
      body: FutureBuilder<ServiceDetailEntity>(
        future: _services,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return SnapshotErrorWidget(error: snapshot.hasError);
          } else {
            final service = snapshot.data!;
            service_id = service.serviceId;
            professional_id = service.userId!;
            return SingleChildScrollView(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: NetworkImage(
                      service.user.profilePicture!,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    '${service.user.firstname!} ${service.user.lastname!}',
                    style: AppTheme.headingTextStyle,
                  ),
                  Text(
                    service.title!,
                    style: AppTheme.elementTitle,
                  ),
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        alignment:
                            Alignment.centerLeft, // Align text to the left
                        child: Text(
                          service.description!,
                          style: AppTheme.bodyTextStyle,
                          softWrap: true,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FutureBuilder<List<Review>>(
                    future: _reviews,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return AppLoading();
                      } else if (snapshot.hasError) {
                        return Text('An Error has occured');
                      } else if (snapshot.data!.isEmpty) {
                        return Container();
                      } else {
                        return ReviewList(reviews: snapshot.data!);
                      }
                    },
                  ),

                  HeadingTitle(text: 'Contact details'),
                  ContactDetail(
                    text: service.user.phoneNumber ?? '',
                    icon: FluentIcons.phone_12_filled,
                  ),
                  ContactDetail(
                    text: service.user.facebookLink ?? '',
                    icon: Icons.facebook,
                  ),
                  ContactDetail(
                    text: service.user.instagramLink ?? '',
                    icon: Icons.camera,
                  ),
                  ContactDetail(
                    text: service.user.tiktokLink ?? '',
                    icon: Icons.tiktok,
                  ),
                  HeadingTitle(text: 'Price'),
                  ...service.prices.map((price) {
                    return PriceCard(
                      description: price.description!,
                      value: price.value.toString(),
                      rate: price.rate!,
                    );
                  }).toList(),
                  HeadingTitle(text: 'Previous projects'),
                  // Wrap PictureList with Center if there's only one picture
                  service.pictures.length < 3
                      ? Row(children: [PictureList(pictures: service.pictures)])
                      : PictureList(pictures: service.pictures),
                ],
              ),
            );
          }
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        padding: EdgeInsets.all(0),
        elevation: 4,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: kBottomNavigationBarHeight +
              16, // Adjust height to accommodate button
          child: Row(
            children: [
              Expanded(
                child: FilledAppButton(
                  icon: FluentIcons.calendar_12_filled,
                  text: "Take an appointement",
                  onPressed: () {
                    if (widget.loggedIn == true) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateAppointmentPage(
                            serviceId: service_id,
                            professionalId: professional_id,
                          ),
                        ),
                      );
                    } else {}
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
