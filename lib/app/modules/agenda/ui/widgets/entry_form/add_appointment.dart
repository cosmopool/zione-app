import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:zione/app/modules/agenda/domain/entities/appointment_entity.dart';
import 'package:zione/app/modules/agenda/domain/entities/ticket_entity.dart';
import 'package:zione/app/modules/agenda/ui/providers/feed_provider.dart';
import 'package:zione/app/modules/agenda/ui/widgets/entry_form/components/input_text.dart' as input;

class AddAppointmentForm extends StatefulWidget {
  TicketEntity ticket;

  AddAppointmentForm({Key? key, required this.ticket}) : super(key: key);

  @override
  _AddAppointmentFormState createState() => _AddAppointmentFormState();
}

class _AddAppointmentFormState extends State<AddAppointmentForm> {
  final log = Logger('AddAppointmentForm');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _date;
  String? _time;
  String? _duration;
  String? _isFinished;

  Widget _buildDate() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
      child: DateTimePicker(
        type: DateTimePickerType.date,
        dateMask: 'dd/MM/yyyy',
        initialValue: DateTime.now().toString(),
        firstDate: DateTime(2022),
        lastDate: DateTime(2030),
        icon: const Icon(Icons.event),
        decoration: input.customInputDecoration('Data'),
        onChanged: (val) => _date = val.toString(),
        validator: (e) {
          if (e == null) {
            return 'Selecione uma data';
          }
        },
        onSaved: (value) {
          if (value != null) {
            final dateTime = value.toString().split(" ");
            final date = dateTime[0];
            _date = date;
          }
        },
      ),
    );
  }

  Widget _buildTime() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
      child: DateTimePicker(
        decoration: input.customInputDecoration('Horário'),
        type: DateTimePickerType.time,
        dateLabelText: 'Horário',
        onChanged: (val) => _time = val.toString(),
        validator: (e) {
          if (e == null) {
            return 'Selecione um horário';
          }
        },
        onSaved: (value) {
          if (value != null) {
            final dateTime = value.toString().split(" ");
            final time = dateTime[0].split(":");

            final hour = time[0];
            final minute = time[1];
            final val = "$hour:$minute";
            _time = val;
            // widget._time = dateTime;
          }
        },
      ),
    );
  }

  Widget _buildDuration() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
      child: DateTimePicker(
        decoration: input.customInputDecoration('Duração'),
        type: DateTimePickerType.time,
        dateLabelText: 'Duração',
        onChanged: (val) => _duration = val.toString(),
        validator: (e) {
          if (e == null) {
            return 'Selecione a duração';
          }
        },
       onSaved: (value) {
         if (value != null) {
           final dateTime = value.toString().split(" ");
           final time = dateTime[0].split(":");

           final hour = time[0];
           final minute = time[1];
           final val = "$hour:$minute";
           _duration = val;
         }
       },
      ),
    );
  }

  void _editAppointment() async {
    log.info("[ADD][FORM][APPOINTMENT] preparing map to instantiate AppointmentEntity");
    final Map<String, dynamic> appointmentMap = {
      'date': _date,
      'time': _time,
      'duration': _duration,
      'ticketId': widget.ticket.id,
    };
    log.finer("[ADD][FORM][APPOINTMENT] Appointment to be sent: $appointmentMap");

    final appointment = AppointmentEntity(appointmentMap);
    context.read<FeedProvider>().insert(appointment, appointment.endpoint);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const ListTile(
            title: Text('Adicionar Chamado'),
            leading: Icon(FontAwesomeIcons.times),
          ),
          _buildDate(),
          _buildTime(),
          _buildDuration(),
          /* _buildIsFinished(), */
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    fixedSize: MaterialStateProperty.all(const Size(130, 40)),
                  ),
                  onPressed: () {
                    final currentState = _formKey.currentState;
                    if (currentState != null) {
                      final isValid = currentState.validate();
                      if (isValid) {
                        currentState.save();
                        _editAppointment();
                        Navigator.pop(context, true);
                      }
                    }
                  },
                  child: const Text('Salvar'))
            ],
          )
        ],
      ),
    );
  }
}
