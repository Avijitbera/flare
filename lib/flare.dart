
import 'dart:convert';
import 'dart:io';

import 'package:flare/connection.dart';

void main(){
  Flare flare = Flare();
  flare.start();
}

class Flare {
  void start()async{
    ServerSocket server = await ServerSocket.bind(InternetAddress.anyIPv4, 3000);
    await for(var socket in  server){
      handleConnection(socket);
    }
  }

  void handleConnection(Socket socket){
    socket.listen((data){
      print("Connection from ${socket.address}");
      print(utf8.decode(data));
    },
    onError: (e){
      print("error");
    },
    onDone: () {
      print("done");
    },);
  }
}
