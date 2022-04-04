import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logging/logging.dart';
import 'package:zione/app/modules/agenda/domain/entities/agenda_entity.dart';
import 'package:zione/app/modules/agenda/ui/stores/agenda_store.dart';

import 'components/input_text.dart';
// import 'package:zione_app/repositories/entry_repository.dart';

class EntryForm extends StatefulWidget {
  const EntryForm({Key? key}) : super(key: key);

  @override
  _EntryFormState createState() => _EntryFormState();
}

class _EntryFormState extends State<EntryForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final log = Logger('AddEntryForm');
  final store = Modular.get<AgendaStore>();

  late String _clientName;
  late String _clientPhone;
  late String _clientAddress;
  late String _serviceType;
  late String _description;
  late String _date;
  late String _time;
  late String _duration;

  Widget _buildClientName() {
    const textType = TextInputType.text;
    const label = 'Nome do cliente';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
      child: TextFormField(
        keyboardType: textType,
        decoration: customInputDecoration(label),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Preencha esse campo';
          }
        },
        onSaved: (value) {
          if (value != null) {
            _clientName = value;
          }
        },
      ),
    );
  }

  Widget _buildClientPhone() {
    const textType = TextInputType.phone;
    const label = 'Telefone';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
      child: TextFormField(
        keyboardType: textType,
        decoration: customInputDecoration(label),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Preencha esse campo';
          }
        },
        onSaved: (value) {
          if (value != null) {
            _clientPhone = value;
          }
        },
      ),
    );
  }

  Widget _buildClientAddress() {
    const textType = TextInputType.text;
    const label = 'Endereço';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
      child: TextFormField(
        keyboardType: textType,
        decoration: customInputDecoration(label),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Preencha esse campo';
          }
        },
        onSaved: (value) {
          if (value != null) {
            _clientAddress = value;
          }
        },
      ),
    );
  }

  Widget _buildServiceType() {
    const label = 'Tipo de Serviço';
    const textType = TextInputType.text;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
      child: TextFormField(
        keyboardType: textType,
        decoration: customInputDecoration(label),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Preencha esse campo';
          }
        },
        onSaved: (value) {
          if (value != null) {
            _serviceType = value;
          }
        },
      ),
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        decoration: customInputDecoration('Descrição'),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Preencha esse campo';
          }
        },
        onSaved: (value) {
          if (value != null) {
            _description = value;
          }
        },
      ),
    );
  }

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
        decoration: customInputDecoration('Data'),
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
        decoration: customInputDecoration('Horário'),
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
        decoration: customInputDecoration('Duração'),
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

  void _addEntry() async {
    log.info("[ADD][FORM][APPOINTMENT] preparing agenda entity intance...");
    final entry = AgendaEntity(
      date: _date,
      time: _time,
      duration: _duration,
      clientName: _clientName,
      clientPhone: _clientPhone,
      clientAddress: _clientAddress,
      serviceType: _serviceType,
      description: _description,
    );
    log.finer("[ADD][FORM][APPOINTMENT] entry to be sent: $entry");

    store.insert(entry);
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
            title: const Text('Adicionar Agendamento e chamado'),
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(FontAwesomeIcons.xmark),
            ),
          ),
          _buildDate(),
          _buildTime(),
          _buildDuration(),
          _buildClientName(),
          _buildClientPhone(),
          _buildClientAddress(),
          _buildServiceType(),
          _buildDescription(),
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
                      _addEntry();
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
