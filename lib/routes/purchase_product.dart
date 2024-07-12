part of "routes.dart";

Future<Response> purchaseProduct(Request req) async {
  try {
    final data = await RequestUtils.getPayload(req);

    final id = data["_id"] as String;
    final amount = data["amount"] as int;

    final product = await getIt.get<ProductRepository>().updateAmountOfProduct(id, amount);

    return Response.ok(
      jsonEncode(product.toJson()),
      headers: {"Content-Type": "application/json"},
    );
  } on ProductNotFoundException catch (e) {
    return Response.badRequest(body: "Product with id: ${e.productId} not found");
  }
}
