

import 'dart:convert';
import 'dart:io';

class Response {
  final Socket socket;
  Response(this.socket);

  void send(String data){
    final response = 'HTTP/1.1 200 OK\r\n'
        'Content-Type: text/plain\r\n'
        'Content-Length: ${data.length}\r\n'
        '\r\n'
        '$data'; 

    socket.write(response);
  }

  void json(Map<String, dynamic> data){
    final jsonString = jsonEncode(data);
    final response = 'HTTP/1.1 200 OK\r\n'
        'Content-Type: application/json\r\n'
        'Content-Length: ${jsonString.length}\r\n'
        '\r\n'
        '$jsonString';
    socket.write(response);
  }
}