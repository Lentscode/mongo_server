part of "routes.dart";

// Handler per aggiornare la quantità disponibile di un prodotto
// in caso venga acquistato.
Future<Response> purchaseProduct(Request req) async {
  try {
    final data = await RequestUtils.getPayload(req);

    // Accediamo ai dati inviati dal client.
    final id = data["_id"];
    final amount = data["amount"];

    // Controlliamo che non siano nulli.
    if (id == null || amount == null) {
      return Response.badRequest(body: "Id or amount missing");
    }

    // Aggiorniamo il documento del prodotto e lo recuperiamo.
    final product = await getIt.get<ProductRepository>().updateAmountOfProduct(id, amount);

    return Response.ok(
      jsonEncode(product.toJson()),
      headers: {"Content-Type": "application/json"},
    );
  } on ProductNotFoundException catch (e) {
    // In caso il prodotto non venga trovato, viene lanciata un'eccezione,
    // che intercettiamo.
    return Response.badRequest(body: "Product with id: ${e.productId} not found");
  }
}
