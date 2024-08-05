import "dart:io";

import "package:args/args.dart";
import "package:mongo_server/config/set_up.dart";
import "package:mongo_server/routes/routes.dart";
import "package:shelf/shelf.dart";
import "package:shelf/shelf_io.dart";
import "package:shelf_router/shelf_router.dart";

// Router principale.
final _router = Router()
  ..get("/getProducts", getProducts)
  ..post("/createProduct", createProduct)
  ..post("/purchaseProduct", purchaseProduct)
  ..delete("/deleteProduct", deleteProduct);

void main(List<String> args) async {
  // Configurazione del parser per gli argomenti della riga di comando.
  final parser = ArgParser()..addFlag("test", negatable: false, help: "Indicates if it is a test run");

  final argResults = parser.parse(args);

  // Verifica se la flag 'test' è stata passata.
  final isTest = argResults["test"] as bool;

  // Chiamata alla funzione di configurazione con il valore della flag.
  await setUp(isTest);

  final ip = InternetAddress.anyIPv4;

  final handler = Pipeline().addMiddleware(logRequests()).addHandler(_router.call);

  final port = int.parse(Platform.environment["PORT"] ?? "8080");
  final server = await serve(handler, ip, port);
  print("Server listening on port ${server.port}");
}
