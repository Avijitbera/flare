

import 'package:flare/utils.dart';

import '../Request.dart';
import '../Response.dart';
import 'RouteHandler.dart';

class Router {
   final Map<String, Map<String, RouteHandler>> _routes = {
    'GET': {},
    'POST': {},
    'PUT': {},
    'DELETE': {},
  };

  Map<String, Map<String, RouteHandler>> get routes => _routes;
  final List<Middleware> _middlewares = [];

  List<Middleware> get middlewares => _middlewares;

  void use(Middleware middleware) {
    _middlewares.add(middleware);
  }

  void get(String path, Handler handler, { List<Middleware> middleware = const [] }) {
    _routes['GET']![path] = RouteHandler(handler, middleware);
  }

  void post(String path, Handler handler, { List<Middleware> middleware = const [] }) {
    _routes['POST']![path] = RouteHandler(handler, middleware);
  }

  void put(String path, Handler handler, { List<Middleware> middleware = const [] }) {
    _routes['PUT']![path] = RouteHandler(handler, middleware);
  }

  void delete(String path, Handler handler, { List<Middleware> middleware = const [] }) {
    _routes['DELETE']![path] = RouteHandler(handler, middleware);
  }
  
}