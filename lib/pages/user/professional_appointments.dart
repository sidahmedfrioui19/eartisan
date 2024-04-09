import 'package:flutter/material.dart';
import 'package:profinder/models/appointement/professional_appointment.dart';
import 'package:profinder/services/appointement/professional_appointement.dart';
import 'package:profinder/widgets/lists/generic_vertical_list.dart';

class ProfessionalAppointments extends StatefulWidget {
  const ProfessionalAppointments({super.key});

  @override
  State<ProfessionalAppointments> createState() =>
      _ProfessionalAppointmentsState();
}

class _ProfessionalAppointmentsState extends State<ProfessionalAppointments> {
  late Future<List<ProfessionalAppointment>> _appointments;

  final ProfessionalAppointementService _appointmentService =
      ProfessionalAppointementService();

  Future<void> _loadAppointments() async {
    _appointments = _appointmentService.fetch();
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
                      'Description du client: ${appointment.description!}',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 4),
                        Text(
                          'Client: ${appointment.customer.firstname} ${appointment.customer.lastname}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        Text(
                          'Numéro de téléphone: ${appointment.customer.phoneNumber}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        SizedBox(height: 4),
                        Text(
                            'Date: ${appointment.date != null ? appointment.date : 'N/D'}'),
                        SizedBox(height: 4),
                        Text(
                            'Temps: ${appointment.time != null ? appointment.time : 'N/D'}'),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.cancel),
                      onPressed: () {
                        // Add cancel appointment logic here
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
