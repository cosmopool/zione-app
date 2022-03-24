import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  get message;
}

class NoFailure extends Failure {
  @override
  String get message => "No Error";

  @override
  List<Object?> get props => [];
}

class NullParamFailure extends Failure {
  @override
  String get message => "No parameter was given";

  @override
  List<Object?> get props => [];
}
