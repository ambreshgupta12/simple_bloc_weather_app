class ApiResponse<T>{
  Status status;
  String message;
  T data;
  ApiResponse.loading(this.message):status=Status.Loading;
  ApiResponse.completed(this.data):status=Status.Completed;
  ApiResponse.error(this.message):status=Status.Error;
  ApiResponse.unNotifiedError(this.message,this.data):status=Status.UnNotifiedError;

}

enum Status {Loading,Completed,Error,UnNotifiedError}