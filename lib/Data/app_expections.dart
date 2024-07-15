class AppExpections implements Exception {
  final _message;
  final _prefix;

  AppExpections([this._message, this._prefix]);

  String toString()
  {
return '$_message$_prefix';
  }

}

class FetchDataExpections extends AppExpections {

  FetchDataExpections([String? message]) : super(message," Error During Communication ");
}

class BadRequestExpections extends AppExpections {

  BadRequestExpections([String? message]) : super(message," Invalid Request ");
}
class UnauthorisedExpections extends AppExpections {

  UnauthorisedExpections([String? message]) : super(message," Unauthorised request ");
}