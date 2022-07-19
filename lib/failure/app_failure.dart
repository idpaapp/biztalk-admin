import 'failure.dart';

class ApiFailure implements Failure {
  ApiFailure(this._message);

  final String _message;

  @override
  String get message => _message;
}