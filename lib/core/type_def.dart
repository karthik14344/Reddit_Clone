import 'package:fpdart/fpdart.dart';

import 'failure.dart';

//Intializing the data types.
typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureVoid = FutureEither<void>;
