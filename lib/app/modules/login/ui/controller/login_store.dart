import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:logging/logging.dart';
import 'package:mobx/mobx.dart';
import 'package:zione/app/modules/login/domain/entities/user_entity.dart';
import 'package:zione/app/modules/login/domain/usecases/login_usecase.dart';
import 'package:zione/app/modules/core/errors/failures.dart';
part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  final LoginUsecase _usecase;
  final log = Logger('LoginStore');
  _LoginStore(this._usecase);
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @observable
  bool loading = false;

  @observable
  Failure? failure;

  @observable
  bool signedIn = false;

  @action
  Future<void> signIn(String user, String pass) async {
    log.info("[LOGIN][STORE] -- TRYING TO SIGN IN...");
    log.finest("[LOGIN][STORE] username: $user, password: $pass");
    loading = true;
    failure = null;

    final res = await _usecase(
      UserEntity(
        username: user,
        password: pass,
      ),
    );

    res.fold((l) {
      failure = l;
      log.info("[LOGIN][STORE] a failure occured");
    }, (r) {
      signedIn = r;
      Modular.to.pushNamedAndRemoveUntil('/', (_) => false);
      log.info("[LOGIN][STORE] success, user signed in, all good!");
    });

    loading = false;
  }
}
