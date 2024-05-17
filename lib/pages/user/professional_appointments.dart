import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:profinder/models/appointement/appointment_update_request.dart';
import 'package:profinder/models/appointement/professional_appointment.dart';
import 'package:profinder/pages/messages/chat_room.dart';
import 'package:profinder/services/appointement/appointement.dart';
import 'package:profinder/services/appointement/professional_appointement.dart';
import 'package:profinder/utils/helpers.dart';
import 'package:profinder/widgets/buttons/filled_button.dart';
import 'package:profinder/widgets/cards/stated_avatar.dart';
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
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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
                        PopupMenuButton<int>(
                          color: Colors.white,
                          surfaceTintColor: Colors.white,
                          onSelected: (value) {
                            switch (value) {
                              case 0:
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChatRoom(
                                      available: false,
                                      firstname: appointment.customer.firstname,
                                      lastname: appointment.customer.lastname,
                                      pictureUrl: '',
                                      user_id: appointment.customer.userId,
                                    ),
                                  ),
                                );
                                break;
                              case 1:
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
                                break;
                              case 2:
                                _cancelAppointment(appointment);
                                break;
                            }
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem<int>(
                              value: 0,
                              child: Row(
                                children: [
                                  Icon(Icons.message),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('Send message')
                                ],
                              ),
                            ),
                            PopupMenuItem<int>(
                              value: 1,
                              child: Row(
                                children: [
                                  Icon(FluentIcons.pen_16_filled),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('Edit')
                                ],
                              ),
                            ),
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
                          ],
                        )
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Divider(
                          color: Color(0xFFF5f6fa),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Row(
                            children: [
                              StatedAvatar(
                                imageUrl: appointment.customer.profilePicture,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    '${appointment.customer.firstname} ${appointment.customer.lastname}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    'Etat: ${appointment.status != null ? Helpers.getAppointementStatus(appointment.status) : 'N/A'}',
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
                        SizedBox(height: 4),
                        SizedBox(height: 4),
                        Text(
                          'Phone number : ${appointment.customer.phoneNumber}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
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
