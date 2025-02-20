


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
    return res.json({"body":req.bodyAsJson});
  });

  app.put("/update", (req, res)async{
    return res.json({"bodyUpdate":req.bodyAsJson});
  },
  middleware: [
    (r, res)async{
      print("Update middleware");
    },
  ]);

  app.listen(port: 3000);
}

