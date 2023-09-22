import 'response_status.dart';
class ApiResponse<T>{
  ResponseStatus? status;
  T? data;
  String? message;

  ApiResponse(this.status,this.message,this.data);

  ApiResponse.loading() : status=ResponseStatus.LOADING;
  ApiResponse.completed() : status=ResponseStatus.COMPLETED;
  ApiResponse.error() : status=ResponseStatus.ERROR;

  @override
  String toString(){
    return 'Status: $status \n Message: $message \n Data: $data';
  }
}