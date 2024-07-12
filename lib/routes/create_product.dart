part of "routes.dart";

// Handler per una richiesta di creazione di un prodotto.
Future<Response> createProduct(Request req) async {
  final data = await RequestUtils.getPayload(req);

  // Controlliamo che tutti i campi siano forniti.
  if (data["name"] == null || data["price"] == null || data["amount"] == null) {
    return Response.badRequest(body: "Product info is missing");
  }

  // Inseriamo il prodotto nel database.
  final product = await getIt.get<ProductRepository>().insertProductInDB(data);

  return Response.ok(
    jsonEncode(product.toJson()),
    headers: {"Content-Type": "application/json"},
  );
}
