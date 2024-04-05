import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:profinder/models/post/service_detail.dart';
import 'package:profinder/pages/home/widgets/price_card.dart';
import 'package:profinder/services/professional.dart';
import 'package:profinder/utils/theme_data.dart';
import 'package:profinder/widgets/appbar/overlay_top_bar.dart';

class ServiceDetail extends StatefulWidget {
  final int? serviceId;
  const ServiceDetail({
    super.key,
    required this.serviceId,
  });

  @override
  State<ServiceDetail> createState() => _ServiceDetailState();
}

class _ServiceDetailState extends State<ServiceDetail> {
  late Future<ServiceDetailEntity> _serviceFuture;
  ProfessionalService service = ProfessionalService();

  @override
  void initState() {
    super.initState();
    _loadService(widget.serviceId);
  }

  Future<void> _loadService(int? id) async {
    _serviceFuture =
        service.fetchService((json) => ServiceDetailEntity.fromJson(json), id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: OverlayTopBar(
        title: "",
        dismissIcon: FluentIcons.chevron_left_12_filled,
        action: IconButton(
          icon: Icon(FluentIcons.bookmark_16_regular),
          onPressed: () {},
        ),
      ),
      body: FutureBuilder<ServiceDetailEntity>(
        future: _serviceFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final service = snapshot.data!;
            return SingleChildScrollView(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: NetworkImage(
                      service.user.profilePicture,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    service.user.firstname,
                    style: AppTheme.headingTextStyle,
                  ),
                  Text(
                    service.title,
                    style: AppTheme.elementTitle,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    child: Text(
                      service.description,
                      style: AppTheme.bodyTextStyle,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Prix',
                          style: AppTheme.elementTitle,
                        ),
                      ],
                    ),
                  ),
                  // Display prices
                  ...service.prices.map((price) {
                    return PriceCard(
                      description: price.description,
                      value: price.value.toString(),
                      rate: price.rate,
                    );
                  }).toList(),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
