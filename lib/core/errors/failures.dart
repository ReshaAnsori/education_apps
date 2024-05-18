import 'package:education_apps/core/errors/exceptions.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure({required this.message, required this.statusCode})
      : assert(
          statusCode.runtimeType is int || statusCode.runtimeType is String,
          "status code shoudn't be ${statusCode.runtimeType} ",
        );

  final String message;
  final int statusCode;

  String get errorMessage => '$statusCode Error : $message';

  @override
  List<Object> get props => [message, statusCode];
}

class CacheFailure extends Failure {
  CacheFailure({required super.message, required super.statusCode});
}

class ServerFailure extends Failure {
  ServerFailure({
    required super.message,
    required super.statusCode,
  });

  ServerFailure.fromException(ServerException e)
      : this(statusCode: e.statusCode, message: e.message);
}
