import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:zione/app/modules/login/ui/controller/login_store.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = Modular.get<LoginStore>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void checkFailure(context) {
    if (controller.failure != null) {
      final snackBar = SnackBar(
        content: const Text('Não foi possível logar! :()'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            /* Navigator.pop(context); */
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    late String username;
    late String password;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Login'),
                    validator: (e) => e == null ? 'Preencha este campo' : null,
                    onSaved: (e) => e == null || e.isEmpty ? "" : username = e,
                    /* onSaved: (e) => e == null || e.isEmpty ? "" : controller.setUser(e), */
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Password'),
                    validator: (e) => e == null ? 'Preencha este campo' : null,
                    onSaved: (e) => e == null || e.isEmpty ? "" : password = e,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        final currentState = _formKey.currentState;
                        if (currentState != null && currentState.validate()) {
                          currentState.save();
                          controller.signIn(username, password);
                          checkFailure(context);
                        }
                      },
                      child: const Text('Submit'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
