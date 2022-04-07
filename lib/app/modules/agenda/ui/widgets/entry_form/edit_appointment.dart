import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logging/logging.dart';
import 'package:zione/app/modules/agenda/domain/entities/appointment_entity.dart';
import 'package:zione/app/modules/agenda/ui/stores/appointment_store.dart';
import 'package:zione/app/modules/agenda/ui/widgets/entry_form/components/input_text.dart'
    as input;

class EditAppointmentForm extends StatefulWidget {
  AppointmentEntity appointment;
  final store = Modular.get<AppointmentStore>();

  EditAppointmentForm({Key? key, required this.appointment}) : super(key: key);

  @override
  _EditAppointmentFormState createState() => _EditAppointmentFormState();
}

class _EditAppointmentFormState extends State<EditAppointmentForm> {
  final log = Logger('EditAppointmentForm');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildDate() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
      child: DateTimePicker(
        initialDate: DateTime.parse(widget.appointment.date),
        type: DateTimePickerType.date,
        dateMask: 'dd/MM/yyyy',
        initialValue: widget.appointment.date,
        firstDate: DateTime(2022),
        lastDate: DateTime(2030),
        icon: const Icon(Icons.event),
        decoration: input.customInputDecoration('Data'),
        onChanged: (val) => widget.appointment.date = val.toString(),
        onSaved: (value) {
          if (value != null) {
            widget.appointment.date = value;
          }
        },
      ),
    );
  }

  Widget _buildTime() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
      child: DateTimePicker(
        initialValue: widget.appointment.time,
        decoration: input.customInputDecoration('Horário'),
        type: DateTimePickerType.time,
        dateLabelText: 'Horário',
        onChanged: (val) => widget.appointment.time = val.toString(),
        onSaved: (value) {
          if (value != null) {
            widget.appointment.time = value;
          }
        },
      ),
    );
  }

  Widget _buildDuration() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
      child: DateTimePicker(
        initialValue: widget.appointment.duration,
        decoration: input.customInputDecoration('Duração'),
        type: DateTimePickerType.time,
        dateLabelText: 'Duração',
        onChanged: (val) => widget.appointment.duration = val.toString(),
        onSaved: (value) {
          if (value != null) {
            widget.appointment.duration = value;
          }
        },
      ),
    );
  }

  void _editAppointment() async {
    log.info("[EDIT][APPOINTMENT][FORM] preparing appointment with new values");
    log.finer(
        "[EDIT][FORM][APPOINTMENT] Appointment to be sent: ${widget.appointment.toMap()}");
    widget.store.edit(widget.appointment);
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
            title: const Text('Editar Agendamento'),
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(FontAwesomeIcons.xmark),
            ),
          ),
          _buildDate(),
          _buildTime(),
          _buildDuration(),
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
