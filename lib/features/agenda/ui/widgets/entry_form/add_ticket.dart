import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import 'package:zione_app/features/entry_form/input_text.dart' as input;
import 'package:zione_app/repositories/request.dart' as req;

class TicketForm extends StatefulWidget {
  String? _clientName;
  String? _clientPhone;
  String? _clientAddress;
  String? _serviceType;
  String? _description;

  @override
  _TicketFormState createState() => _TicketFormState();
}

class _TicketFormState extends State<TicketForm> {
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

  void _addTicket() async {
    Map<String, String?> ticket = {
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

    // print(ticket);
    await req.postContent('tickets', ticket).then((value) {
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
                        _addTicket();
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
