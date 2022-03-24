// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginStore on _LoginStore, Store {
  final _$loadingAtom = Atom(name: '_LoginStore.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$failureAtom = Atom(name: '_LoginStore.failure');

  @override
  Failure? get failure {
    _$failureAtom.reportRead();
    return super.failure;
  }

  @override
  set failure(Failure? value) {
    _$failureAtom.reportWrite(value, super.failure, () {
      super.failure = value;
    });
  }

  final _$signedInAtom = Atom(name: '_LoginStore.signedIn');

  @override
  bool get signedIn {
    _$signedInAtom.reportRead();
    return super.signedIn;
  }

  @override
  set signedIn(bool value) {
    _$signedInAtom.reportWrite(value, super.signedIn, () {
      super.signedIn = value;
    });
  }

  final _$signInAsyncAction = AsyncAction('_LoginStore.signIn');

  @override
  Future<void> signIn(String user, String pass) {
    return _$signInAsyncAction.run(() => super.signIn(user, pass));
  }

  @override
  String toString() {
    return '''
loading: ${loading},
failure: ${failure},
signedIn: ${signedIn}
    ''';
  }
}
