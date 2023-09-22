
class AppExceptions implements Exception{

  final  _message;
  final  _prefix;

  AppExceptions([this._message,this._prefix]);

  @override
  String toString(){
    return '$_message$_prefix';
  }
}
class FetchDataException extends AppExceptions{

  FetchDataException([String? message]): super (message,'Error During Communication');
}
class BadRequestException extends AppExceptions{

  BadRequestException([String? message]): super (message,'Invalid request');
}
class UnautherisedException extends AppExceptions{

  UnautherisedException([String? message]): super (message,'Unautherised request');
}
class InvalidInputException extends AppExceptions{

  InvalidInputException([String? message]): super (message,'Invalid Input');
}
