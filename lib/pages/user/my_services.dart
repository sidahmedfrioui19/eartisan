import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:profinder/models/picture/picture_creation_request.dart';
import 'package:profinder/models/post/price_creation_request.dart';
import 'package:profinder/models/post/service_update_request.dart';
import 'package:profinder/models/post/user_service.dart';
import 'package:profinder/services/picture/picture.dart';
import 'package:profinder/services/post/professional.dart';
import 'package:profinder/services/price/price.dart';
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

  final UserPostService _serviceS = UserPostService();

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  final TextEditingController _priceDescriptionController =
      TextEditingController();
  final TextEditingController _valueController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();

  List<PriceCreationRequest> prices = [];

  @override
  void initState() {
    super.initState();
    _loadServices();
  }

  void addPrice() {
    PriceCreationRequest price = PriceCreationRequest(
      value: int.parse(_valueController.text),
      description: _priceDescriptionController.text,
      rate: _rateController.text,
    );

    setState(() {
      prices.add(price);
    });
  }

  Future<void> _loadServices() async {
    _services = _serviceS.fetchUserServices();
  }

  editService(ServiceDataEntity service) async {
    try {
      ServiceUpdateRequest req = ServiceUpdateRequest(
        title: titleController.text,
        description: contentController.text,
      );

      final ProfessionalService _service = ProfessionalService();

      await _service.updateService(
        req,
        service.serviceId,
      );
      setState(() {
        _loadServices();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Service updated'),
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
    Navigator.of(context).pop();
  }

  _deleteService(ServiceDataEntity service) async {
    final ProfessionalService _service = ProfessionalService();
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
                    if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                      final services = snapshot.data!;

                      return Column(
                        children: services.map((service) {
                          return _buildServiceCard(service);
                        }).toList(),
                      );
                    } else {
                      return Center(
                        child: Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 250,
                              ),
                              Icon(
                                FluentIcons.backpack_12_filled,
                                size: 64,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text("Services list empty")
                            ],
                          ),
                        ),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPicturesDialog(ServiceDataEntity service) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: Text('Pictures'),
          content: Container(
            width: double.maxFinite,
            height: 400, // Set a height to allow scrolling
            child: SingleChildScrollView(
              child: service.pictures.isNotEmpty
                  ? GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            2, // Adjust to fit more pictures per row if needed
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 4.0,
                      ),
                      itemCount: service.pictures.length,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            Image.network(
                              service.pictures[index].link!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                            Positioned(
                              top: 2,
                              right: 2,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors
                                      .black54, // Semi-transparent background
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  icon: Icon(Icons.delete, color: Colors.white),
                                  onPressed: () async {
                                    PictureService picture = PictureService();
                                    try {
                                      await picture.deleteById(
                                          service.pictures[index].pictureId!);
                                      setState(() {
                                        _loadServices();
                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text('Picture deleted'),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                      Navigator.of(context).pop();
                                    } catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
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
                              ),
                            ),
                          ],
                        );
                      },
                    )
                  : Center(
                      child: Text('No pictures available'),
                    ),
            ),
          ),
          actions: <Widget>[
            FilledAppButton(
              icon: Icons.close,
              text: "Close",
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _addPriceDialog(int service_id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: Text('Add Price'),
          content: Column(
            children: [
              RoundedTextField(
                controller: _priceDescriptionController,
                hintText: "Task",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please type a task";
                  }
                  return null;
                },
              ),
              RoundedTextField(
                controller: _valueController,
                hintText: "Price",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please type a price";
                  }
                  return null;
                },
              ),
              RoundedTextField(
                controller: _rateController,
                hintText: "Rate",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please type the rate";
                  }
                  return null;
                },
              ),
            ],
          ),
          actions: <Widget>[
            FilledAppButton(
              icon: Icons.close,
              text: "Close",
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FilledAppButton(
              icon: Icons.add,
              text: "Add",
              onPressed: () async {
                PriceService price = PriceService();
                PriceCreationRequest req = PriceCreationRequest(
                  value: int.parse(_valueController.text),
                  description: _priceDescriptionController.text,
                  rate: _rateController.text,
                  serviceId: service_id,
                );

                try {
                  await price.post(req);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('An error has occured')),
                  );
                }

                setState(() {
                  _loadServices();
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showPricesDialog(ServiceDataEntity service) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: Text('Prices'),
          content: Container(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: service.prices.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: service.prices.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey.shade200,
                          ),
                          padding: EdgeInsets.all(2),
                          margin: EdgeInsets.all(2),
                          child: Column(
                            children: [
                              ListTile(
                                leading: Text(
                                  service.prices[index].description!,
                                ),
                                trailing: Text(
                                  '${service.prices[index].value!}/${service.prices[index].rate!}',
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () async {
                                    PriceService price = PriceService();
                                    try {
                                      await price.deleteById(
                                          service.prices[index].priceId!);
                                      setState(() {
                                        _loadServices();
                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text('Price deleted'),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                      Navigator.of(context).pop();
                                    } catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
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
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Text('No prices available'),
                    ),
            ),
          ),
          actions: <Widget>[
            FilledAppButton(
              icon: Icons.close,
              text: "Close",
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _uploadPicture(int service_id) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      File imageFile = File(image.path);

      Reference storageReference = FirebaseStorage.instance.ref().child(
          'profile_pictures/${DateTime.now().millisecondsSinceEpoch}.jpg');

      UploadTask uploadTask = storageReference.putFile(imageFile);

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            title:
                Text("Chargement d'image...", style: TextStyle(fontSize: 15)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 10),
                StreamBuilder<TaskSnapshot>(
                  stream: uploadTask.snapshotEvents,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      double progress = snapshot.data!.bytesTransferred /
                          snapshot.data!.totalBytes;
                      return LinearProgressIndicator(
                        value: progress,
                        color: AppTheme.primaryColor,
                      );
                    } else {
                      return SizedBox(); // Placeholder
                    }
                  },
                ),
              ],
            ),
          );
        },
      );

      try {
        TaskSnapshot snapshot = await uploadTask;
        String downloadURL = await snapshot.ref.getDownloadURL();
        addPicture(downloadURL, service_id);
        Navigator.of(context).pop();
      } catch (error) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error uploading image: $error')),
        );
      }
    }
  }

  void addPicture(String link, int service_id) async {
    PictureService picture = PictureService();
    PictureCreationRequest req = PictureCreationRequest(
      link: link,
      service_id: service_id,
    );

    try {
      await picture.post(req);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading image')),
      );
    }

    setState(() {
      _loadServices();
    });
  }

  Widget _buildServiceCard(ServiceDataEntity service) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300, width: 0.6),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Card(
        surfaceTintColor: Colors.white,
        color: Colors.white,
        elevation: 0,
        margin: EdgeInsets.symmetric(vertical: 5),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service.title!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${service.description!.substring(0, 30)}...',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 8),
                  Row(
                    children: [
                      PopupMenuButton<int>(
                        color: Colors.white,
                        surfaceTintColor: Colors.white,
                        onSelected: (value) {
                          switch (value) {
                            case 0:
                              _uploadPicture(service.serviceId);
                              break;
                            case 1:
                              _addPriceDialog(service.serviceId);
                              break;
                            case 2:
                              _showPicturesDialog(service);
                              break;
                            case 3:
                              _showPricesDialog(service);
                              break;
                            case 4:
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          RoundedTextField(
                                            controller: titleController,
                                            hintText: 'Title',
                                          ),
                                          RoundedTextArea(
                                            controller: contentController,
                                            hintText: 'Description',
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
                                                    editService(service);
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
                              break;
                            case 5:
                              _deleteService(service);
                              break;
                          }
                        },
                        itemBuilder: (context) => [
                          PopupMenuItem<int>(
                            value: 0,
                            child: Row(
                              children: [
                                Icon(Icons.add),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('Add picture')
                              ],
                            ),
                          ),
                          PopupMenuItem<int>(
                            value: 1,
                            child: Row(
                              children: [
                                Icon(Icons.add),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('Add price')
                              ],
                            ),
                          ),
                          PopupMenuItem<int>(
                            value: 2,
                            child: Row(
                              children: [
                                Icon(Icons.photo_album),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('Pictures')
                              ],
                            ),
                          ),
                          PopupMenuItem<int>(
                            value: 3,
                            child: Row(
                              children: [
                                Icon(
                                    FluentIcons.currency_dollar_euro_16_filled),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('Prices')
                              ],
                            ),
                          ),
                          PopupMenuItem<int>(
                            value: 4,
                            child: Row(
                              children: [
                                Icon(Icons.edit),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('Edit'),
                              ],
                            ),
                          ),
                          PopupMenuItem<int>(
                            value: 5,
                            child: Row(
                              children: [
                                Icon(Icons.cancel),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('Delete'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
