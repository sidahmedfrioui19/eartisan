import 'package:flutter/material.dart';
import 'package:profinder/models/post/user_service.dart';
import 'package:profinder/pages/home/widgets/heading_title.dart';
import 'package:profinder/pages/home/widgets/price_card.dart';
import 'package:profinder/services/post/professional.dart';
import 'package:profinder/services/user/user_service.dart';
import 'package:profinder/utils/theme_data.dart';
import 'package:profinder/widgets/buttons/filled_button.dart';
import 'package:profinder/widgets/inputs/rounded_text_field.dart';
import 'package:profinder/widgets/inputs/text_area.dart';
import 'package:profinder/widgets/progress/loader.dart';

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<List<ServiceDataEntity>>(
              future: _services,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return AppLoading();
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
                        // Show dialog with service details
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              surfaceTintColor: Colors.white,
                              title: Text('Modifier'),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RoundedTextField(
                                      controller: TextEditingController(
                                        text: service.title,
                                      ),
                                      hintText: 'Titre',
                                    ),
                                    RoundedTextArea(
                                      controller: TextEditingController(
                                        text: service.description,
                                      ),
                                      hintText: 'Description',
                                    ),
                                    HeadingTitle(text: 'Prix'),
                                    ...service.prices.map((price) {
                                      return PriceCard(
                                        description: price.description!,
                                        value: price.value.toString(),
                                        rate: price.rate ?? '',
                                      );
                                    }).toList(),
                                    Text('Photos: '),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Wrap(
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
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                FilledAppButton(
                                  icon: Icons.close,
                                  text: 'Annuler',
                                  onPressed: () => {
                                    Navigator.of(context).pop(),
                                  },
                                ),
                                FilledAppButton(
                                  icon: Icons.save,
                                  text: 'Mettre a jour',
                                  onPressed: () => {
                                    Navigator.of(context).pop(),
                                  },
                                ),
                              ],
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
                              content: Text('Service supprimé'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Une erreur est survenue.'),
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
