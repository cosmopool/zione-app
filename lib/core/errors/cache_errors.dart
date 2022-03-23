
import 'package:zione/core/errors/failures.dart';

class EntryNotFound extends Failure {
  late final String _prop;
  EntryNotFound(this._prop);

  @override
  String get message => "No entry was found with given property: $_prop";

  @override
  List<Object?> get props => [];
}

class NoResponseFromCache extends Failure {
  @override
  String get message => "No response from cache";

  @override
  List<Object?> get props => [];
}

class ThisEntryDoesNotExistsInCache extends Failure {
  @override
  String get message => "Could not save content in cache";

  @override
  List<Object?> get props => [];
}

class NotAbleToUpdateContent extends Failure {
  @override
  String get message => "Could not save content in cache";

  @override
  List<Object?> get props => [];
}

class NotAbleToSaveContent extends Failure {
  @override
  String get message => "Could not save content in cache";

  @override
  List<Object?> get props => [];
}

class EmptyResponseFromCache extends Failure {
  @override
  String get message => "Empty response from cache";

  @override
  List<Object?> get props => [];
}

