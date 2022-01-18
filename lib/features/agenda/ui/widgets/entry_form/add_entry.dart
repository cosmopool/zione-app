import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:date_field/date_field.dart';

import 'package:zione_app/features/entry_form/input_text.dart' as input;
import 'package:zione_app/repositories/request.dart' as req;
import 'package:zione_app/repositories/entry_repository.dart';

class EntryForm extends StatefulWidget {
  String? _clientName;
  String? _clientPhone;
  String? _clientAddress;
  String? _serviceType;
  String? _description;
  String? _date;
  String? _time;
  String? _duration;

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
        decoration: input.customInputDecoration(label),
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
        decoration: input.customInputDecoration(label),
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
        decoration: input.customInputDecoration(label),
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
        decoration: input.customInputDecoration(label),
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
        decoration: input.customInputDecoration('Descrição'),
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
      child: DateTimeFormField(
        mode: DateTimeFieldPickerMode.date,
        decoration: input.customInputDecoration('Data'),
        autovalidateMode: AutovalidateMode.always,
        validator: (e) {
          // final now = DateTime.now();
          if (e == null) {
            return 'Selecione uma data';
            // if (e != null) {
            // final sameOrGreaterYear = e.year >= now.year;
            // final sameOrGreaterMonth = e.month >= now.month;
            // final sameOrGreaterDay = e.day >= now.day;
            // return sameOrGreaterYear && sameOrGreaterMonth && sameOrGreaterDay
            //     ? null
            //     : 'Não é possível adicionar datas passadas';
          }
        },
        onSaved: (value) {
          if (value != null) {
            final dateTime = value.toString().split(" ");
            final date = dateTime[0];
            widget._date = date;
          }
        },
        // onDateSelected: (DateTime value) {
        //   widget._date = value.toString();
        // },
      ),
    );
  }

  Widget _buildTime() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
      child: DateTimeFormField(
        mode: DateTimeFieldPickerMode.time,
        decoration: input.customInputDecoration('Horário'),
        autovalidateMode: AutovalidateMode.always,
        validator: (e) {
          if (e == null) {
            return 'Selecione um horário';
          }
        },
        onSaved: (value) {
          if (value != null) {
            final dateTime = value.toString().split(" ");
            final time = dateTime[1].split(":");

            final hour = time[0];
            final minute = time[1];
            final val = "$hour:$minute";
            widget._time = val;
          }
        },
        // onDateSelected: (DateTime value) {
        //   widget._time = value.toString();
        // },
      ),
    );
  }

  Widget _buildDuration() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
      child: DateTimeFormField(
        mode: DateTimeFieldPickerMode.time,
        decoration: input.customInputDecoration('Duração'),
        autovalidateMode: AutovalidateMode.always,
        validator: (e) {
          if (e == null) {
            return 'Selecione a duração';
          }
        },
        onSaved: (value) {
          if (value != null) {
            final dateTime = value.toString().split(" ");
            final time = dateTime[1].split(":");

            final hour = time[0];
            final minute = time[1];
            final val = "$hour:$minute";
            widget._duration = val;
          }
        },
        // onDateSelected: (DateTime value) {},
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

    // print(agendaEntry);
    await req.postContent('agenda', agendaEntry).then((value) {
      String status;
      late String res;

      try {
        status = value['Status'];
      } catch (e) {
        status = 'Error';
      }

      if (status == 'Success') {
        res = 'Adicionado';
      } else {
        // TODO: save resquest to try later so user do not need to write all again
        res = 'Erro ao adicionar Chamado. Veja mais em pendentes';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(res),
          behavior: SnackBarBehavior.floating,
        ),
      );
    });
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
                        context.pop();
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
