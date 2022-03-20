import 'package:logging/logging.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:zione/features/agenda/domain/entities/ticket_entity.dart';
import 'package:zione/features/agenda/ui/providers/feed_provider.dart';
import 'package:zione/utils/enums.dart';

import 'components/input_text.dart';

class AddTicketForm extends StatefulWidget {


  AddTicketForm({Key? key}) : super(key: key);

  @override
  _AddTicketFormState createState() => _AddTicketFormState();
}

class _AddTicketFormState extends State<AddTicketForm> {
  final log = Logger('AddAddTicketForm');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map ticketMap = {};

  Widget _buildInput(String label, TextInputType inputType, valueToSave) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
      child: TextFormField(
        keyboardType: inputType,
        decoration: customInputDecoration(label),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Preencha esse campo';
          }
        },
        onSaved: (value) {
          if (value != null) {
            /* valueToSave = value; */
            ticketMap[valueToSave] = value;
          }
        },
      ),
    );
  }

  void _addTicket() async {
    log.info("[ADD TICKET][FORM] preparing map to instantiate TicketEntity");
    log.fine("[ADD TICKET][FORM] resulting map: $ticketMap");
    final ticket = TicketEntity.fromMap(ticketMap);
    log.fine("[ADD TICKET][FORM] TicketEntity instance to add: $ticket");
    /* context.read<FeedProvider>().insert(ticket, Endpoint.tickets); */
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
          _buildInput("Nome do Cliente", TextInputType.text, "clientName"),
          _buildInput("Telefone", TextInputType.phone, "clientPhone"),
          _buildInput(
              "Endereço do Cliente", TextInputType.text, "clientAddress"),
          _buildInput(
              "Tipo de Serviço", TextInputType.text, "serviceType"),
          _buildInput(
              "Descrição do Serviço", TextInputType.text, "description"),
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
