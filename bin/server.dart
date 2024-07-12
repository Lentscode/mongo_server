import 'dart:io';

import 'package:mongo_server/config/set_up.dart';
import 'package:mongo_server/routes/routes.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

// Configure routes.
final _router = Router()
  ..get('/products', getProducts)
  ..post("/products", createProduct)
  ..patch("/products", purchaseProduct)
  ..delete("/products/<_id>", deleteProduct);

void main(List<String> args) async {
  await setUp();
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // Configure a pipeline that logs requests.
  final handler = Pipeline().addMiddleware(logRequests()).addHandler(_router.call);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
