import 'package:flutter/material.dart';
import 'package:profinder/models/appointement/appointment_update_request.dart';
import 'package:profinder/models/appointement/professional_appointment.dart';
import 'package:profinder/services/appointement/appointement.dart';
import 'package:profinder/services/appointement/professional_appointement.dart';
import 'package:profinder/utils/helpers.dart';
import 'package:profinder/widgets/buttons/filled_button.dart';
import 'package:profinder/widgets/inputs/dropdown.dart';
import 'package:intl/intl.dart';
import 'package:profinder/widgets/lists/generic_vertical_list.dart';

class ProfessionalAppointments extends StatefulWidget {
  const ProfessionalAppointments({Key? key}) : super(key: key);

  @override
  State<ProfessionalAppointments> createState() =>
      _ProfessionalAppointmentsState();
}

class _ProfessionalAppointmentsState extends State<ProfessionalAppointments> {
  late Future<List<ProfessionalAppointment>> _appointments;

  final ProfessionalAppointementService _appointmentService =
      ProfessionalAppointementService();
  final AppointementService appointementService = AppointementService();

  String? state = '';

  Future<void> _loadAppointments() async {
    setState(() {
      _appointments = _appointmentService.fetch();
    });
  }

  void _updateAppointments() {
    setState(() {
      _loadAppointments();
    });
  }

  void showEditAppointmentDialog(
      String? initialDate, String? initialTime, String? initialState, int? id) {
    TextEditingController dateController = TextEditingController(
      text: initialDate != null ? Helpers.reverseDateFormat(initialDate) : null,
    );
    TextEditingController timeController =
        TextEditingController(text: initialTime);
    String? selectedState = initialState;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
              title: Text("Edit appointement"),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: dateController,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          barrierColor: Colors.white,
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate != null)
                          setState(() {
                            dateController.text =
                                DateFormat('dd/MM/yyyy').format(pickedDate);
                          });
                      },
                      decoration: InputDecoration(
                        hintText: "Date: JJ/MM/AAAA",
                      ),
                    ),
                    TextFormField(
                      controller: timeController,
                      onTap: () async {
                        TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (pickedTime != null)
                          setState(() {
                            timeController.text = pickedTime.format(context);
                          });
                      },
                      decoration: InputDecoration(
                        hintText: "Time: HH:MM",
                      ),
                    ),
                    RoundedDropdownButton<String>(
                      value: selectedState,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedState = newValue;
                        });
                      },
                      hintText: 'State',
                      items: [
                        DropdownMenuItem(
                          value: 'pending',
                          child: Text('Waiting'),
                        ),
                        DropdownMenuItem(
                          value: 'processing',
                          child: Text('Confirmed'),
                        ),
                        DropdownMenuItem(
                          value: 'confirmed',
                          child: Text('Completed'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: FilledAppButton(
                          icon: Icons.check,
                          text: "Ok",
                          onPressed: () async {
                            AppointementUpdateRequest req =
                                AppointementUpdateRequest(
                              date: Helpers.formatDateForMySQL(
                                  dateController.text),
                              time: timeController.text,
                              state: selectedState!,
                            );
                            try {
                              await appointementService.update(req, id);
                              _updateAppointments();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Appointement updated'),
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
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: FilledAppButton(
                        icon: Icons.close,
                        text: "Cancel",
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                )
              ],
            );
          },
        );
      },
    );
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
                      'Customer description: ${appointment.description!}',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 4),
                        Text(
                          'Customer: ${appointment.customer.firstname} ${appointment.customer.lastname}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          'Phone number: ${appointment.customer.phoneNumber}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        SizedBox(height: 4),
                        Text(
                            'Date: ${appointment.date != null ? appointment.date : 'N/A'}'),
                        SizedBox(height: 4),
                        Text(
                            'Time: ${appointment.time != null ? appointment.time : 'N/A'}'),
                        SizedBox(height: 4),
                        Text(
                            'Etat: ${appointment.status != null ? Helpers.getAppointementStatus(appointment.status) : 'N/A'}'),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 10,
                            bottom: 5,
                            left: 0,
                            right: 0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FilledAppButton(
                                icon: Icons.edit,
                                text: 'Edit',
                                onPressed: () {
                                  if (appointment.status == 'cancelled') {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Appointement already canceled',
                                        ),
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                  } else {
                                    showEditAppointmentDialog(
                                      appointment.date,
                                      appointment.time,
                                      appointment.status,
                                      appointment.appointmentId,
                                    );
                                  }
                                },
                              ),
                              FilledAppButton(
                                icon: Icons.cancel,
                                text: 'Cancel',
                                onPressed: () {
                                  _cancelAppointment(appointment);
                                },
                              ),
                            ],
                          ),
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

  void _cancelAppointment(ProfessionalAppointment appointment) async {
    AppointementUpdateRequest req = AppointementUpdateRequest(
      state: 'cancelled',
    );
    await appointementService.update(req, appointment.appointmentId);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Appointement cancelled'),
        duration: Duration(seconds: 2),
      ),
    );
    _updateAppointments();
  }
}
