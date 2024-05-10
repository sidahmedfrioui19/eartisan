import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:profinder/models/appointement/appointment_update_request.dart';
import 'package:profinder/models/appointement/customer_appointment.dart';
import 'package:profinder/models/report/report.dart';
import 'package:profinder/models/review/review_creation_request.dart';
import 'package:profinder/services/appointement/appointement.dart';
import 'package:profinder/services/appointement/customer_appointement.dart';
import 'package:profinder/services/report/report.dart';
import 'package:profinder/services/review/review.dart';
import 'package:profinder/utils/helpers.dart';
import 'package:profinder/utils/theme_data.dart';
import 'package:profinder/widgets/buttons/filled_button.dart';
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
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    title: Text(
                      appointment.description!,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 4),
                        Text(
                          'Professional: ${appointment.professional.firstname} ${appointment.professional.lastname}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text('Date: ${appointment.date ?? 'N/D'}'),
                        SizedBox(height: 4),
                        Text('Time: ${appointment.time ?? 'N/D'}'),
                        SizedBox(height: 4),
                        Text(
                            'State: ${Helpers.getAppointementStatus(appointment.status)}'),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (appointment.status == 'pending')
                              Expanded(
                                child: FilledAppButton(
                                  icon: Icons.cancel,
                                  text: "Cancel",
                                  onPressed: () async {
                                    AppointementUpdateRequest req =
                                        AppointementUpdateRequest(
                                      state: 'cancelled',
                                    );
                                    await appointementService.update(
                                        req, appointment.appointmentId);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Appointement cancelled'),
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                    _updateAppointments();
                                  },
                                ),
                              ),
                            if (appointment.status == 'confirmed')
                              Expanded(
                                child: FilledAppButton(
                                  icon: Icons.star,
                                  text: "Review",
                                  onPressed: () async {
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
                                                            .post(req);
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
                                  },
                                ),
                              ),
                            SizedBox(
                              width: 10,
                            ),
                            if (appointment.status == 'confirmed')
                              Expanded(
                                child: FilledAppButton(
                                  text: 'Report',
                                  icon: FluentIcons.info_12_filled,
                                  onPressed: () {
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
                                                    'Sujet: ${titleController.text}, Contenu: ${reportMessageController.text}';
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
                                  },
                                ),
                              ),
                          ],
                        ),
                      ],
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
}
