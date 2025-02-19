

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
}