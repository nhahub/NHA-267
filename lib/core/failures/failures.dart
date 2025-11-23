class Failers{
  String ErrorMsg;
  Failers({required this.ErrorMsg});
}

class ServerError extends Failers{
  ServerError({required super.ErrorMsg});
}
class NetworkError extends Failers{
  NetworkError({required super.ErrorMsg});
}
