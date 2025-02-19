

import 'dart:convert';
import 'dart:io';

class Response {
  final Socket socket;
  Response(this.socket);

  int _statusCode = 200;
  final Map<String, String> _headers = {};

  void send(String data){
     _headers['Content-Type'] = 'text/plain';
    _headers['Content-Length'] = data.length.toString();
    _sendResponse(data);
  }

  void json(Map<String, dynamic> data){
    final jsonString = jsonEncode(data);
    _headers['Content-Type'] = 'application/json';
    _headers['Content-Length'] = jsonString.length.toString();
    _sendResponse(jsonString);
  }

  Response status(int code) {
    _statusCode = code;
    return this;
  }

  void _sendResponse(String body) {
    final response = StringBuffer();
    response.write('HTTP/1.1 $_statusCode ${_getStatusMessage(_statusCode)}\r\n');
    _headers.forEach((key, value) {
      response.write('$key: $value\r\n');
    });
    response.write('\r\n');
    response.write(body);
    socket.write(response.toString());
  }


  /// Get the status message for a given status code
  String _getStatusMessage(int code) {
   switch (code) {
      case 200:
        return 'OK';
      case 201:
        return 'Created';
      case 404:
        return 'Not Found';
      case 500:
        return 'Internal Server Error';
      default:
        return '';
    }
  }
}