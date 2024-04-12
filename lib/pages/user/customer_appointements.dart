import 'package:flutter/material.dart';
import 'package:profinder/models/appointement/appointment_update_request.dart';
import 'package:profinder/models/appointement/customer_appointment.dart';
import 'package:profinder/services/appointement/appointement.dart';
import 'package:profinder/services/appointement/customer_appointement.dart';
import 'package:profinder/utils/helpers.dart';
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
                          'Professionel: ${appointment.professional.firstname} ${appointment.professional.lastname}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text('Date: ${appointment.date ?? 'N/D'}'),
                        SizedBox(height: 4),
                        Text('Temps: ${appointment.time ?? 'N/D'}'),
                        SizedBox(height: 4),
                        Text(
                            'Status: ${Helpers.getAppointementStatus(appointment.status)}'),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.cancel),
                      onPressed: () async {
                        AppointementUpdateRequest req =
                            AppointementUpdateRequest(
                          state: 'cancelled',
                        );
                        await appointementService.update(
                            req, appointment.appointmentId);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Rendez-vous annulé'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                        _updateAppointments();
                      },
                    ),
                  ),
                );
              },
              errorMessage: "Aucun rendez-vous",
              emptyText: "Aucun rendez-vous",
            ),
          ),
        ],
      ),
    );
  }
}
