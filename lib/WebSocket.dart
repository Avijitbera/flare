

import 'dart:io';

import 'package:flare/Request.dart';

class WebSocket{
  final Socket socket;
  final Request request;
  final String socketId;

  WebSocket(this.socket, this.request, this.socketId);

  void send(String message){
    socket.write(message);
  }

  void close(){
    socket.close();
  }
}