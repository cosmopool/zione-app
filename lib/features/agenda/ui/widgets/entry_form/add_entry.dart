import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:zione/features/agenda/domain/entities/agenda_entry_entity.dart';
import 'package:zione/features/agenda/ui/providers/feed_provider.dart';
import 'package:zione/utils/enums.dart';

import 'components/input_text.dart';
// import 'package:zione_app/repositories/entry_repository.dart';

class EntryForm extends StatefulWidget {
  late String _clientName;
  late String _clientPhone;
  late String _clientAddress;
  late String _serviceType;
  late String _description;
  late String _date;
  late String _time;
  late String _duration;

  @override
  _EntryFormState createState() => _EntryFormState();
}

class _EntryFormState extends State<EntryForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // var _clientName;

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
            widget._clientName = value;
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
            widget._clientPhone = value;
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
            widget._clientAddress = value;
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
            widget._serviceType = value;
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
            widget._description = value;
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
        onChanged: (val) => widget._date = val.toString(),
        validator: (e) {
          if (e == null) {
            return 'Selecione uma data';
          }
        },
        onSaved: (value) {
          if (value != null) {
            final dateTime = value.toString().split(" ");
            final date = dateTime[0];
            widget._date = date;
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
        onChanged: (val) => widget._time = val.toString(),
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
            widget._time = val;
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
        decoration: customInputDecoration('Duração'),
        type: DateTimePickerType.time,
        dateLabelText: 'Duração',
        onChanged: (val) => widget._duration = val.toString(),
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
           widget._duration = val;
         }
       },
      ),
    );
  }

  void _addEntry() async {
    Map<String, String?> agendaEntry = {
      'date': widget._date,
      'time': widget._time,
      'duration': widget._duration,
      'clientName': widget._clientName,
      'clientPhone': widget._clientPhone,
      'clientAddress': widget._clientAddress,
      // 'clientAddressStreet': widget._clientAddressStreet,
      // 'clientAddressNumber': widget._clientAddressNumber,
      // 'clientAddressCity': widget._clientAddressCity,
      // 'clientAddressRegion': widget._clientAddressRegion,
      'serviceType': widget._serviceType,
      'description': widget._description,
    };

    context.read<FeedProvider>().insert(AgendaEntryEntity(agendaEntry), Endpoint.tickets );
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
          _buildClientName(),
          _buildClientPhone(),
          _buildClientAddress(),
          _buildServiceType(),
          _buildDescription(),
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
                        _addEntry();
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
