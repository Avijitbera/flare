


import 'package:flare/flare.dart';
 final app = Flare();


void main(){

  app.use((req, res) async{
    print("Global middleware");
  });

  app.get("/", (req, res) async{
    res.send("Hello world");
  });

  app.post("/create", (req, res)async{
    return res.json({"body":req.rawBody});
  });

  app.put("/update", (req, res)async{

  },
  middleware: [

  ]);

  app.listen(port: 3000);
}

