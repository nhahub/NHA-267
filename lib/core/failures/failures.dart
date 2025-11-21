class Failers{
  String ErrorMsg;
  Failers({required this.ErrorMsg});
}

class ServerError extends Failers{
  ServerError({required super.ErrorMsg});
}
class ClientError extends Failers{
  ClientError({required super.ErrorMsg});
}
