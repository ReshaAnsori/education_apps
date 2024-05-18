import 'package:equatable/equatable.dart';

class ServerException extends Equatable implements Exception {
  const ServerException({
    required this.statusCode,
    required this.message,
  });

  final int statusCode;
  final String message;

  @override
  List<Object?> get props => [statusCode, message];
}