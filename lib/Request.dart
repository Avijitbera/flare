

class Request {
  final String method;
  final String path;
  final Map<String, String> headers;
  final String body;
  final Map<String, String> queryParameters;

  Request({
    required this.method,
    required this.path,
    required this.headers,
    required this.body,
    required this.queryParameters
  });
}