

import '../utils.dart';

class RouteHandler {
  final Handler handler;
  final List<Middleware> middleware;

  RouteHandler(this.handler, this.middleware);
}