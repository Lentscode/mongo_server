part of "routes.dart";

Future<Response> purchaseProduct(Request req) async {
  final data = await RequestUtils.getPayload(req);

  final id = data["_id"] as String;
  final amount = data["amount"] as int;

  final product = await getIt.get<ProductRepository>().updateAmountOfProduct(id, amount);

  return Response.ok(
    jsonEncode(product.toJson()),
    headers: {"Content-Type": "application/json"},
  );
}
