import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logging/logging.dart';
import 'package:zione/app/modules/agenda/data/mappers/appointment_mapper.dart';
import 'package:zione/app/modules/agenda/domain/entities/ticket_entity.dart';
import 'package:zione/app/modules/agenda/ui/stores/appointment_store.dart';
import 'package:zione/app/modules/agenda/ui/widgets/entry_form/components/input_text.dart'
    as input;

class AddAppointmentForm extends StatefulWidget {
  TicketEntity ticket;

  AddAppointmentForm({Key? key, required this.ticket}) : super(key: key);

  @override
  _AddAppointmentFormState createState() => _AddAppointmentFormState();
}

class _AddAppointmentFormState extends State<AddAppointmentForm> {
  final log = Logger('AddAppointmentForm');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final store = Modular.get<AppointmentStore>();

  String? _date;
  String? _time;
  String? _duration;

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
            final dateTime = value.split(" ");
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
            _time = value;
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
            _duration = value;
          }
        },
      ),
    );
  }

  void _editAppointment() async {
    log.info(
        "[ADD][FORM][APPOINTMENT] preparing map to instantiate AppointmentEntity");
    final Map<String, dynamic> appointmentMap = {
      'date': _date,
      'time': _time,
      'duration': _duration,
      'ticketId': widget.ticket.id,
    };
    log.finer(
        "[ADD][FORM][APPOINTMENT] Appointment to be sent: $appointmentMap");

    final appointment = AppointmentMapper.fromMap(appointmentMap);
    store.insert(appointment);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ListTile(
            title: const Text('Adicionar Agendamento'),
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(FontAwesomeIcons.xmark),
            ),
          ),
          _buildDate(),
          _buildTime(),
          _buildDuration(),
          /* _buildIsFinished(), */
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                style: ButtonStyle(
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
                child: Text(
                  'Salvar',
                  style: Theme.of(context).primaryTextTheme.titleMedium,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
