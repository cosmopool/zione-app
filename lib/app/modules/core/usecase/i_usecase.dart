import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:zione/app/modules/core/errors/failures.dart';


abstract class IUsecase<Output, Input> {
  Future<Either<Failure, Output>> call(Input params);
}

abstract class IUsecaseNoInput<Output> {
  Future<Either<Failure, Output>> call();
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
