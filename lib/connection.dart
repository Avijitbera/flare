import 'dart:io';

class Connection {
   ServerSocket serverSocket;

   Connection(this.serverSocket);

   void connect(){
    serverSocket.listen((socket) {
      socket.listen((data) {
        print("Data from client");
        print(data);
        socket.write("Hello");
      },
      onError: (){
        print("Error");
      });
    },
    onError: (e){
      print("Error Here");
      print(e);
    });
   }
}

