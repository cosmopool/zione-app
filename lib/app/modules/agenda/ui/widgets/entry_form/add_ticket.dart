import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logging/logging.dart';
import 'package:zione/app/modules/agenda/data/mappers/ticket_mapper.dart';
import 'package:zione/app/modules/agenda/ui/stores/ticket_store.dart';

import 'components/input_text.dart';

class AddTicketForm extends StatefulWidget {
  const AddTicketForm({Key? key}) : super(key: key);

  @override
  _AddTicketFormState createState() => _AddTicketFormState();
}

class _AddTicketFormState extends State<AddTicketForm> {
  final log = Logger('AddAddTicketForm');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final store = Modular.get<TicketStore>();
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
    final ticket = TicketMapper.fromMap(ticketMap);
    log.fine("[ADD TICKET][FORM] TicketEntity instance to add: $ticket");
    store.insert(ticket);
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
            title: const Text('Adicionar Chamado'),
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(FontAwesomeIcons.xmark),
            ),
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
                      _addTicket();
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
