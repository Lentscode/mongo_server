part of "routes.dart";

Future<Response> createProduct(Request req) async {
  final data = await RequestUtils.getPayload(req);

  if (data["name"] == null || data["price"] == null || data["amount"] == null) {
    return Response.badRequest(body: "Product info is missing");
  }

  final product = await getIt.get<ProductRepository>().insertProductInDB(data);

  return Response.ok(
    jsonEncode(product.toJson()),
    headers: {"Content-Type": "application/json"},
  );
}
