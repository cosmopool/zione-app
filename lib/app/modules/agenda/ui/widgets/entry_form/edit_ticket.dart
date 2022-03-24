import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:zione/app/modules/agenda/domain/entities/ticket_entity.dart';
import 'package:zione/app/modules/agenda/ui/providers/feed_provider.dart';
import 'package:zione/app/modules/core/utils/enums.dart';
import 'package:zione/app/modules/agenda/ui/widgets/entry_form/components/input_text.dart' as input;

import 'components/input_text.dart';

class EditTicketForm extends StatefulWidget {
  TicketEntity ticket;

  EditTicketForm({Key? key, required this.ticket}) : super(key: key);

  @override
  _EditTicketFormState createState() => _EditTicketFormState();
}

class _EditTicketFormState extends State<EditTicketForm> {
  final log = Logger('EditTicketForm');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildClientName() {
    const textType = TextInputType.text;
    const label = 'Nome do cliente';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
      child: TextFormField(
        initialValue: widget.ticket.clientName,
        keyboardType: textType,
        decoration: input.customInputDecoration(label),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Preencha esse campo';
          } else {
            return null;
          }
        },
        onSaved: (value) {
          if (value != null) {
            widget.ticket.clientName = value;
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
        initialValue: widget.ticket.clientPhone,
        keyboardType: textType,
        decoration: input.customInputDecoration(label),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Preencha esse campo';
          } else {
            return null;
          }
        },
        onSaved: (value) {
          if (value != null) {
            widget.ticket.clientPhone = value;
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
        initialValue: widget.ticket.clientAddress,
        keyboardType: textType,
        decoration: input.customInputDecoration(label),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Preencha esse campo';
          } else {
            return null;
          }
        },
        onSaved: (value) {
          if (value != null) {
            widget.ticket.clientAddress = value;
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
        initialValue: widget.ticket.serviceType,
        keyboardType: textType,
        decoration: input.customInputDecoration(label),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Preencha esse campo';
          } else {
            return null;
          }
        },
        onSaved: (value) {
          if (value != null) {
            widget.ticket.serviceType = value;
          }
        },
      ),
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
      child: TextFormField(
        initialValue: widget.ticket.description,
        keyboardType: TextInputType.multiline,
        decoration: input.customInputDecoration('Descrição'),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Preencha esse campo';
          } else {
            return null;
          }
        },
        onSaved: (value) {
          if (value != null) {
            widget.ticket.description = value;
          }
        },
      ),
    );
  }

  void _editTicket() async {
    log.info("[EDIT TICKET][FORM] preparing ticket with new values");
    log.finer("[EDIT TICKET][FORM] Ticket to be sent: ${widget.ticket.toMap()}");
    context.read<FeedProvider>().edit(widget.ticket, Endpoint.tickets);
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
                        _editTicket();
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
