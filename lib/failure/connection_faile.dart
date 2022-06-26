import 'failure.dart';

class ConnectionFailure implements Failure {
  ConnectionFailure({String? message})
      : _message = message ?? "Error To Connect Internet";

  final String _message;

  @override
  String get message => _message;
}
