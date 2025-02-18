

import 'dart:io';

import 'package:dio/dio.dart';

void main()async{
  Dio dio = Dio();
  var result = await dio.get('http://localhost:3000');
  print(result);
  // Socket socket = await Socket.connect(InternetAddress.loopbackIPv4, 3000);
  // socket.listen((data){
  //   print("data from server");
  //   print(data);
  // },
  // onError: (e){
  //   print(e);
  //   print("Error");
  // });
  // socket.write('Hello');
  // socket.close();
}