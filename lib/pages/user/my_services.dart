import 'package:flutter/material.dart';
import 'package:profinder/models/post/service_update_request.dart';
import 'package:profinder/models/post/user_service.dart';
import 'package:profinder/pages/home/widgets/heading_title.dart';
import 'package:profinder/pages/home/widgets/price_card.dart';
import 'package:profinder/services/post/professional.dart';
import 'package:profinder/services/user/user_service.dart';
import 'package:profinder/utils/theme_data.dart';
import 'package:profinder/widgets/appbar/overlay_top_bar.dart';
import 'package:profinder/widgets/buttons/filled_button.dart';
import 'package:profinder/widgets/cards/snapshot_error.dart';
import 'package:profinder/widgets/inputs/rounded_text_field.dart';
import 'package:profinder/widgets/inputs/text_area.dart';
import 'package:profinder/widgets/navigation/burger_menu.dart';
import 'package:profinder/widgets/progress/loader.dart';

class MyServices extends StatefulWidget {
  const MyServices({Key? key}) : super(key: key);

  @override
  State<MyServices> createState() => _MyServicesState();
}

class _MyServicesState extends State<MyServices> {
  late Future<List<ServiceDataEntity>> _services;

  final UserPostService service = UserPostService();

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

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
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      drawer: BurgerMenu(),
      appBar: OverlayTopBar(
        title: "My services",
        dismissIcon: Icons.arrow_back,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder<List<ServiceDataEntity>>(
                future: _services,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return AppLoading();
                  } else if (snapshot.hasError) {
                    return Center(
                      child: SnapshotErrorWidget(
                        error: snapshot.error,
                      ),
                    );
                  } else {
                    final services = snapshot.data!;

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
      ),
    );
  }

  Widget _buildServiceCard(ServiceDataEntity service) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      elevation: 0.8,
      surfaceTintColor: Colors.white,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  service.title!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppTheme.primaryColor,
                  ),
                ),
                SizedBox(width: 8),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      color: AppTheme.primaryColor,
                      onPressed: () {
                        titleController.text = service.title!;
                        contentController.text = service.description!;
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              surfaceTintColor: Colors.white,
                              title: Text('Edit'),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RoundedTextField(
                                      controller: titleController,
                                      hintText: 'Title',
                                    ),
                                    RoundedTextArea(
                                      controller: contentController,
                                      hintText: 'Description',
                                    ),
                                    HeadingTitle(text: 'Price'),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: service.prices.map((price) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: PriceCard(
                                              description: price.description!,
                                              value: price.value.toString(),
                                              rate: price.rate ?? '',
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                    Text('Photos: '),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Wrap(
                                        spacing: 15,
                                        runSpacing: 10,
                                        children: service.pictures.map(
                                          (picture) {
                                            return ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.network(
                                                picture.link!,
                                                width: 100,
                                                height: 100,
                                                fit: BoxFit.cover,
                                              ),
                                            );
                                          },
                                        ).toList(),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        Flexible(
                                          child: FilledAppButton(
                                            icon: Icons.close,
                                            text: 'Cancel',
                                            onPressed: () => {
                                              Navigator.of(context).pop(),
                                            },
                                          ),
                                        ),
                                        Flexible(
                                          child: FilledAppButton(
                                            icon: Icons.save,
                                            text: 'Update',
                                            onPressed: () async {
                                              try {
                                                ServiceUpdateRequest req =
                                                    ServiceUpdateRequest(
                                                  title: titleController.text,
                                                  description:
                                                      contentController.text,
                                                );

                                                final ProfessionalService
                                                    _service =
                                                    ProfessionalService();

                                                await _service.updateService(
                                                  req,
                                                  service.serviceId,
                                                );
                                                setState(() {
                                                  _loadServices();
                                                });
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content:
                                                        Text('Service updated'),
                                                    duration:
                                                        Duration(seconds: 2),
                                                  ),
                                                );
                                              } catch (e) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      'An error has occured, try again',
                                                    ),
                                                    duration:
                                                        Duration(seconds: 2),
                                                  ),
                                                );
                                              }
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      color: Colors.red,
                      onPressed: () async {
                        final ProfessionalService _service =
                            ProfessionalService();
                        try {
                          await _service.delete(service.serviceId);
                          setState(() {
                            _loadServices();
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Service deleted'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'An error has occured, try again',
                              ),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
