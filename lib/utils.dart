

import 'Request.dart';
import 'Response.dart';

typedef Middleware = Future<void> Function(Request request, Response response);
typedef Handler = Future<void> Function(Request request, Response response);