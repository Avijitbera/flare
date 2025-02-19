

import '../Request.dart';
import '../Response.dart';

class Router {
   final Map<String, Map<String, Function(Request, Response)>> _routes = {
    'GET': {},
    'POST': {},
    'PUT': {},
    'DELETE': {},
  };

  void get(String path, Function(Request, Response) handler) {
    _routes['GET']![path] = handler;
  }

  void post(String path, Function(Request, Response) handler) {
    _routes['POST']![path] = handler;
  }

  void put(String path, Function(Request, Response) handler) {
    _routes['PUT']![path] = handler;
  }

  void delete(String path, Function(Request, Response) handler) {
    _routes['DELETE']![path] = handler;
  }
  
}