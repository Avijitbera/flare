
import 'dart:convert';
import 'dart:io';

import 'package:flare/Request.dart';
import 'package:flare/Response.dart';
import 'package:flare/connection.dart';
import 'package:flare/router/RouteHandler.dart';
import 'package:flare/utils.dart';

import 'router/Router.dart';

void main(){
  Flare flare = Flare();
  // flare.start();
}

class Flare {
 final Map<String, Map<String, RouteHandler>> _routes = {
    'GET': {},
    'POST': {},
    'PUT': {},
    'DELETE': {},
  };

  final List<Middleware> _middlewares = [];

  void use(Middleware middleware) {
    _middlewares.add(middleware);
  }

  void useRouter(String path, Router router, {List<Middleware> middleware = const []}) {
    for (final method in router.routes.keys) {
      for (final routePath in router.routes[method]!.keys) {
        final fullPath = '$path${routePath == '/' ? '' : routePath}';
        _routes[method]![fullPath] = RouteHandler(
          router.routes[method]![routePath]!.handler,
          [
            ...middleware, // Middleware applied when mounting the router
            ...router.middlewares, // Router-level middlewares
            ...router.routes[method]![routePath]!.middleware, // Route-specific middlewares
          ],
        );
      }
    }
  }

  void get(String path, Handler handler, {List<Middleware> middleware = const []}) {
    _routes['GET']![path] = RouteHandler(handler, middleware);
  }

  void post(String path, Handler handler, {List<Middleware> middleware = const []}) {
    _routes['POST']![path] = RouteHandler(handler, middleware);
  }

  void put(String path, Handler handler, {List<Middleware> middleware = const []}) {
    _routes['PUT']![path] = RouteHandler(handler, middleware);
  }

  void delete(String path, Handler handler, {List<Middleware> middleware = const []}) {
    _routes['DELETE']![path] = RouteHandler(handler, middleware);
  }
  
}
