import 'package:dartz/dartz.dart';
import 'package:flutter_triple/flutter_triple.dart';

class CustomEitherAdapter<L, R> implements EitherAdapter<L, R> {
  // receive an usecase in constructor
  final Either<L, R> usecase;
  CustomEitherAdapter(this.usecase);

  @override
  T fold<T>(T Function(L l) leftF, T Function(R l) rightF) {
    return usecase.fold(leftF, rightF);
  }

  // Adapter Future Either(Dartz) to Future EitherAdapter(Triple)
  static Future<EitherAdapter<L, R>> adapter<L, R>(
      Future<Either<L, R>> usecase) {
    return usecase.then((value) => CustomEitherAdapter(value));
  }
}
