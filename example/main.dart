

import 'dart:io';

void main()async{
  Socket socket = await Socket.connect(InternetAddress.loopbackIPv4, 3000);
  socket.listen((data){
    print("data from server");
    print(data);
  },
  onError: (e){
    print(e);
    print("Error");
  });
  socket.write('Hello');
  socket.close();
}