enum Status { INITIAL, LOADING, SUCCESS, ERROR }

class Response<T> {
  final Status status;
  final T? data;
  final String message;

  const Response.initial()
      : status = Status.INITIAL,
        data = null,
        message = '';

  const Response.loading(this.message)
      : status = Status.LOADING,
        data = null;

  const Response.success(this.data, {this.message = ''})
      : status = Status.SUCCESS;

  const Response.error(this.message)
      : status = Status.ERROR,
        data = null;

  const Response({
    this.status = Status.INITIAL,
    this.message = '',
    this.data,
  });

  bool get isLoading => status == Status.LOADING;
  bool get isSuccess => status == Status.SUCCESS;
  bool get isError => status == Status.ERROR;
  bool get isInitial => status == Status.INITIAL;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}
