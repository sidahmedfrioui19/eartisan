import 'package:flutter/material.dart';
import 'package:profinder/models/appointement/appointment_creation_request.dart';
import 'package:profinder/services/appointement.dart';
import 'package:profinder/widgets/buttons/filled_button.dart';
import 'package:profinder/widgets/inputs/text_area.dart';

class CreateAppointmentBottomSheet extends StatefulWidget {
  final int serviceId;
  final String professionalId;
  CreateAppointmentBottomSheet(
      {required this.professionalId, required this.serviceId});
  @override
  _CreateAppointmentBottomSheetState createState() =>
      _CreateAppointmentBottomSheetState();
}

class _CreateAppointmentBottomSheetState
    extends State<CreateAppointmentBottomSheet> {
  late String description;
  AppointementService appointment = AppointementService();
  final TextEditingController _descriptionController = TextEditingController();

  AppointementCreationRequest buildRequest() {
    return AppointementCreationRequest(
      description: _descriptionController.text,
      serviceId: widget.serviceId,
      professionalId: widget.professionalId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                RoundedTextArea(
                    controller: _descriptionController,
                    hintText: "Description"),
                SizedBox(height: 16.0),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: FilledAppButton(
                          onPressed: () async {
                            try {
                              await appointment.post(buildRequest());
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Rendez-vous crée'),
                                  duration: Duration(
                                    seconds: 2,
                                  ),
                                ),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text('Veuillez verifier vos cordonnées'),
                                  duration: Duration(
                                    seconds: 2,
                                  ),
                                ),
                              );
                            }
                          },
                          text: 'Confirmer',
                          icon: Icons.check,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
