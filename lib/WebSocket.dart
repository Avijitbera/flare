

import 'dart:convert';
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

  void listen({
    required void Function(String message) onMessage,
    void Function()? onClose,
  }) {
    socket.listen(
      (data) {
        final message = utf8.decode(data);
        onMessage(message);
      },
      onError: (error) {
        print('WebSocket error: $error');
        onClose?.call();
      },
      onDone: () {
        print('WebSocket connection closed');
        onClose?.call();
      },
    );
  }
}