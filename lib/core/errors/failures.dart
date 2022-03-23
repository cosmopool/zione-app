import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  get message;
}

class NullParamFailure extends Failure {
  @override
  String get message => "No parameter was given";

  @override
  List<Object?> get props => [];
}
