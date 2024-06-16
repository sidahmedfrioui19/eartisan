import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:profinder/models/appointement/appointment_update_request.dart';
import 'package:profinder/models/appointement/customer_appointment.dart';
import 'package:profinder/models/report/report.dart';
import 'package:profinder/models/review/review_creation_request.dart';
import 'package:profinder/pages/messages/chat_room.dart';
import 'package:profinder/services/appointement/appointement.dart';
import 'package:profinder/services/appointement/customer_appointement.dart';
import 'package:profinder/services/report/report.dart';
import 'package:profinder/services/review/review.dart';
import 'package:profinder/utils/constants.dart';
import 'package:profinder/utils/helpers.dart';
import 'package:profinder/utils/theme_data.dart';
import 'package:profinder/widgets/buttons/filled_button.dart';
import 'package:profinder/widgets/cards/stated_avatar.dart';
import 'package:profinder/widgets/inputs/rounded_text_field.dart';
import 'package:profinder/widgets/inputs/text_area.dart';
import 'package:profinder/widgets/lists/generic_vertical_list.dart';

class CustomerAppointments extends StatefulWidget {
  const CustomerAppointments({Key? key}) : super(key: key);

  @override
  State<CustomerAppointments> createState() => _CustomerAppointmentsState();
}

class _CustomerAppointmentsState extends State<CustomerAppointments> {
  late Future<List<CustomerAppointment>> _appointments;

  final CustomerAppointementService _appointmentService =
      CustomerAppointementService();

  final AppointementService appointementService = AppointementService();
  final ReviewService reviewService = ReviewService();

  final TextEditingController reportMessageController = TextEditingController();
  final TextEditingController titleController = TextEditingController();

  Future<void> _loadAppointments() async {
    _appointments = _appointmentService.fetch();
  }

  void _updateAppointments() {
    setState(() {
      _loadAppointments();
    });
  }

  @override
  void initState() {
    super.initState();
    _loadAppointments();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: VerticalList(
              future: _appointments,
              itemBuilder: (appointment) {
                return Card(
                  surfaceTintColor: Colors.white,
                  color: Colors.white,
                  elevation: 0.8,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 2),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Colors.grey.shade300, width: 0.6),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.fromLTRB(15, 8, 2, 8),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(FluentIcons.clock_12_filled),
                              SizedBox(width: 10),
                              Text(
                                  'Date: ${appointment.date != null ? appointment.date : 'N/A'}'),
                              SizedBox(width: 10),
                              Icon(
                                FluentIcons.circle_12_filled,
                                size: 8,
                              ),
                              SizedBox(width: 10),
                              Text(
                                  '${appointment.time != null ? appointment.time : 'N/A'}'),
                            ],
                          ),
                          if (appointment.status != 'processing')
                            PopupMenuButton<int>(
                              color: Colors.white,
                              surfaceTintColor: Colors.white,
                              onSelected: (value) {
                                switch (value) {
                                  case 0:
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          insetPadding: EdgeInsets.all(0),
                                          surfaceTintColor: Colors.white,
                                          title: Text("Send report"),
                                          content: Container(
                                            height: 200,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .stretch, // Expand items horizontally
                                              children: [
                                                RoundedTextField(
                                                  controller: titleController,
                                                  hintText: 'Subject',
                                                ),
                                                SizedBox(height: 8),
                                                Expanded(
                                                  child: RoundedTextArea(
                                                    controller:
                                                        reportMessageController,
                                                    hintText: 'Message...',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: <Widget>[
                                            FilledAppButton(
                                              icon: Icons.close,
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              text: 'Cancel',
                                            ),
                                            FilledAppButton(
                                              icon: Icons.check,
                                              onPressed: () async {
                                                final ReportService
                                                    reportService =
                                                    ReportService();
                                                final String reportContent =
                                                    'Subject: ${titleController.text}, Content: ${reportMessageController.text}';
                                                ReportEntity report =
                                                    new ReportEntity(
                                                  description: reportContent,
                                                  reported_id: appointment
                                                      .service.serviceId,
                                                );

                                                try {
                                                  await reportService
                                                      .post(report);
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content:
                                                          Text('Report sent'),
                                                      duration: Duration(
                                                        seconds: 2,
                                                      ),
                                                    ),
                                                  );
                                                  Navigator.of(context).pop();
                                                } catch (e) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                          'An error has occured, try again'),
                                                      duration: Duration(
                                                        seconds: 2,
                                                      ),
                                                    ),
                                                  );
                                                }
                                              },
                                              text: 'Send',
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                    break;
                                  case 1:
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        int rating = 0;
                                        TextEditingController
                                            _commentController =
                                            TextEditingController();

                                        return AlertDialog(
                                          backgroundColor: Colors.white,
                                          surfaceTintColor: Colors.white,
                                          title: Padding(
                                            padding: EdgeInsets.all(10),
                                            child: Text(
                                              'Review service',
                                              style: AppTheme.headingTextStyle,
                                            ),
                                          ),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              // Star rating widget
                                              RatingBar.builder(
                                                initialRating: 0,
                                                minRating: 1,
                                                direction: Axis.horizontal,
                                                allowHalfRating: false,
                                                itemCount: 5,
                                                itemPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 4.0),
                                                itemBuilder: (context, _) =>
                                                    Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                  size: 1,
                                                ),
                                                onRatingUpdate: (value) {
                                                  rating = value
                                                      .toInt(); // Update rating when user selects stars
                                                },
                                              ),
                                              SizedBox(height: 10),
                                              // Text field for comment
                                              RoundedTextArea(
                                                  controller:
                                                      _commentController,
                                                  hintText: "Type comment..."),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: FilledAppButton(
                                                      icon: Icons.check,
                                                      text: "Send",
                                                      onPressed: () async {
                                                        ReviewCreationRequest
                                                            req =
                                                            ReviewCreationRequest(
                                                          comment:
                                                              _commentController
                                                                  .text,
                                                          rating: rating,
                                                          serviceId: appointment
                                                              .service
                                                              .serviceId,
                                                        );

                                                        await reviewService
                                                            .post(
                                                          req,
                                                          appointment
                                                              .professional
                                                              .userId,
                                                        );
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content: Text(
                                                              'Review submitted',
                                                            ),
                                                            duration: Duration(
                                                              seconds: 3,
                                                            ),
                                                          ),
                                                        );
                                                        _updateAppointments();
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                    break;
                                  case 2:
                                    _cancelAppointment(appointment);
                                    break;
                                  case 3:
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ChatRoom(
                                          available: false,
                                          firstname: appointment
                                              .professional.firstname,
                                          lastname:
                                              appointment.professional.lastname,
                                          pictureUrl: appointment
                                              .professional.profilePicture,
                                          user_id:
                                              appointment.professional.userId,
                                        ),
                                      ),
                                    );
                                    break;
                                }
                              },
                              itemBuilder: (context) => [
                                if (appointment.status == 'confirmed' ||
                                    appointment.status == 'cancelled')
                                  PopupMenuItem<int>(
                                    value: 0,
                                    child: Row(
                                      children: [
                                        Icon(Icons.flag),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text('Report')
                                      ],
                                    ),
                                  ),
                                if (appointment.status == 'confirmed')
                                  PopupMenuItem<int>(
                                    value: 1,
                                    child: Row(
                                      children: [
                                        Icon(FluentIcons.star_12_filled),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text('Review'),
                                      ],
                                    ),
                                  ),
                                if (appointment.status == 'pending')
                                  PopupMenuItem<int>(
                                    value: 2,
                                    child: Row(
                                      children: [
                                        Icon(Icons.cancel),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text('Cancel'),
                                      ],
                                    ),
                                  ),
                                PopupMenuItem<int>(
                                  value: 3,
                                  child: Row(
                                    children: [
                                      Icon(Icons.message),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text('Send Message'),
                                    ],
                                  ),
                                ),
                              ],
                            )
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(8, 0, 15, 5),
                            child: Divider(
                              color: Color(0xFFF5f6fa),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.white,
                                isScrollControlled: true,
                                builder: (BuildContext context) {
                                  return SingleChildScrollView(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: EdgeInsets.all(16),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CircleAvatar(
                                            radius: 50,
                                            backgroundImage: NetworkImage(
                                                appointment.professional
                                                        .profilePicture ??
                                                    Constants.defaultAvatar),
                                          ),
                                          SizedBox(height: 16),
                                          Text(
                                            '${appointment.professional.firstname} ${appointment.professional.lastname}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            '@${appointment.professional.username}',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 16,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            appointment.service.status == true
                                                ? 'Available'
                                                : 'Not available',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 16,
                                            ),
                                          ),
                                          SizedBox(height: 16),
                                          FilledAppButton(
                                            icon: Icons.close,
                                            text: "Close",
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Row(
                              children: [
                                StatedAvatar(
                                  imageUrl:
                                      appointment.professional.profilePicture,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${appointment.professional.firstname} ${appointment.professional.lastname}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      'State: ${appointment.status != null ? Helpers.getAppointementStatus(appointment.status) : 'N/A'}',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Description: ${appointment.description!}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              errorMessage: "No appointements",
              emptyText: "No appointements",
            ),
          ),
        ],
      ),
    );
  }

  void _cancelAppointment(CustomerAppointment appointment) async {
    AppointementUpdateRequest req = AppointementUpdateRequest(
      state: 'cancelled',
    );
    await appointementService.update(
      req,
      appointment.appointmentId,
      appointment.professional.userId,
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Appointement cancelled'),
        duration: Duration(seconds: 2),
      ),
    );
    _updateAppointments();
  }
}
