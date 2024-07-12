part of "routes.dart";

Future<Response> deleteProduct(Request req) async {
  final id = req.params["_id"];

  if (id == null) {
    return Response.badRequest(body: "Product id not given");
  }

  await getIt.get<ProductRepository>().deleteProduct(id);

  return Response.ok("Deleted product with id: $id");
}
