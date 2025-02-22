

import 'dart:convert';
import 'dart:typed_data';

class Request {
  final String method;
  final String path;
  final Map<String, String> headers;
  final List<int> rawBody;
  final Map<String, String> queryParameters;

  Request({
    required this.method,
    required this.path,
    required this.headers,
    required this.rawBody,
    required this.queryParameters
  });

  factory Request.fromRawData(List<int> data){
    final rawRequest = utf8.decode(data);
    final lines = rawRequest.split('\r\n');
   

    final requestLine = lines[0].split(' ');

    var bodyStartIndex = 1;
    
    final method = requestLine[0];
    final path = requestLine[1].split('?')[0];
    final queryParams = Uri.parse(requestLine[1]).queryParameters;
   final headers = <String, String>{};
  

    for (int i = 1; i < lines.length; i++) {
      // final line = lines[i];
      if (lines[i].isEmpty) {
        bodyStartIndex = i+1;
        break;
        // final parts = line.split(': ');
        // headers[parts[0]] = parts[1];
      }
      final parts = lines[i].split(': ');
      headers[parts[0]] = parts[1];
    }
    final body = lines.sublist(bodyStartIndex).join('\r\n');
    // final body = lines.last;

    return Request(method: method,
     path: path, headers: headers, 
     rawBody: utf8.encode(body),
      queryParameters: queryParams);
  }

  String get bodyAsString => utf8.decode(rawBody);

  Map<String, dynamic> get bodyAsJson {
    try {
      return jsonDecode(bodyAsString);
    } catch (e) {
      throw FormatException('Invalid JSON data');
    }
  }

  Map<String, String> get bodyAsFormData {

    final formData = <String, String>{};
    final pairs = bodyAsString.split('&');
    for(final pair in pairs){
      final keyValue = pair.split('=');
      if(keyValue.length == 2){
        formData[Uri.decodeComponent(keyValue[0])] =
            Uri.decodeComponent(keyValue[1]);
      }
    }
    return formData;
  }

  Future<Map<String, dynamic>> parseMultipart()async{
    final boundary  = _extractBoundary(headers['Content-Type'] ?? '');
    if(boundary == null){
      throw FormatException('Invalid multipart request');
    }

    final parts = _splitMultipartBody(rawBody, boundary);
    final result = <String, dynamic>{};
    for(final part in parts){
      final headers ;
    }
    return result;
  }

  Map<String, String> _parsePartHeaders(List<int> part){
    final headers = <String, String>{};
    var headerEnd = part.indexOf(13);

    if(headerEnd == -1) return headers;

    final headerLines = utf8.decode(part.sublist(0, headerEnd)).split('\r\n');

    for(final line in headerLines){
      final separator = line.indexOf(':');
      if(separator != -1){
        headers[line.substring(0, separator).toLowerCase()]
        = line.substring(separator + 1).trim();
      }
    }
    return headers;
  }


  List<List<int>> _splitMultipartBody(List<int> body, String boundary){
    final boundaryBytes = utf8.encode('--$boundary');
    final parts = <List<int>>[];
    var start = 0;
    while(true){
      final end = _findBoundary(body, boundaryBytes, start);
      if(end == -1){
        break;
      }
      parts.add(body.sublist(start, end));
      start = end + boundaryBytes.length + 2;
    }
    return parts;
  }

  int _findBoundary(List<int> body, List<int> boundary, int start){
    for(var i = start; i < body.length - boundary.length; i++){
      if(body[i] == boundary[0]
      && body.sublist(i, i + boundary.length) == boundary){
        return i;
      }
    }
    return -1;
  }
   String? _extractBoundary(String contentType) {
    final match = RegExp(r'boundary=([^;]+)').firstMatch(contentType);
    return match?.group(1);
  }
  
}