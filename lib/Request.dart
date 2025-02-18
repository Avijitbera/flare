

import 'dart:convert';
import 'dart:typed_data';

class Request {
  final String method;
  final String path;
  final Map<String, String> headers;
  final String body;
  final Map<String, String> queryParameters;

  Request({
    required this.method,
    required this.path,
    required this.headers,
    required this.body,
    required this.queryParameters
  });

  factory Request.fromRawData(List<int> data){
    final rawRequest = utf8.decode(data);
    final lines = rawRequest.split('\r\n');
   

    final requestLine = lines[0].split(' ');
    
    final method = requestLine[0];
    final path = requestLine[1].split('?')[0];
    final queryParams = Uri.parse(requestLine[1]).queryParameters;
   final headers = <String, String>{};

    for (int i = 1; i < lines.length; i++) {
      final line = lines[i];
      if (line.isNotEmpty) {
        final parts = line.split(': ');
        headers[parts[0]] = parts[1];
      }
    }
    final body = lines.last;

    return Request(method: method, path: path, headers: headers, body: body, queryParameters: queryParams);
  }
}