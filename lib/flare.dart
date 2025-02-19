
import 'dart:convert';
import 'dart:io';

import 'package:flare/Request.dart';
import 'package:flare/Response.dart';
import 'package:flare/connection.dart';

void main(){
  Flare flare = Flare();
  // flare.start();
}

class Flare {
 final Map<String, Map<String, Function(Request, Response)>> _routes = {
    'GET': {},
    'POST': {},
    'PUT': {},
    'DELETE': {},
  };

  final List<Function(Request, Response)> _middlewares = [];

  void use(Function(Request, Response) middleware) {
    _middlewares.add(middleware);
  }

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
