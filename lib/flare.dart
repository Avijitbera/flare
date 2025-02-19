
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


  final List<Function(Request, Response)> _middlewares = [];

  void use(Function(Request, Response) middleware) {
    _middlewares.add(middleware);
  }

  
}
