
import 'package:zione/core/errors/failures.dart';

class CouldNotFinishRequest extends Failure {
  late final String _msg;
  CouldNotFinishRequest(this._msg);

  @override
  String get message => _msg;

  @override
  List<Object?> get props => [message];
}

class MissingFieldError extends Failure {
  @override
  String get message => "There's one or more missing required fields";

  @override
  List<Object?> get props => [];
}

class InvalidValueError extends Failure {
  @override
  String get message => "There's one or more field with invalid value";

  @override
  List<Object?> get props => [];
}

class ValidationError extends Failure {
  @override
  String get message => "Error validating data sent";

  @override
  List<Object?> get props => [];
}

class UnformattedResponse extends Failure {
  @override
  String get message => "A error occured on the database side";

  @override
  List<Object?> get props => [];
}

class DatabaseError extends Failure {
  @override
  String get message => "A error occured on the database side";

  @override
  List<Object?> get props => [];
}

class ServerSideFailure extends Failure {
  @override
  String get message => "A error occured on the server side";

  @override
  List<Object?> get props => [];
}

class NoConnectionWithServer extends Failure {
  @override
  String get message => "No connection with server";

  @override
  List<Object?> get props => [];
}
