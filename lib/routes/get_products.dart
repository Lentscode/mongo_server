part of "routes.dart";

// Handler che ritorna i prodotti presenti nel DB.
Future<Response> getProducts(Request req) async {
  final underPriceStr = RequestUtils.getQueryParams(req)["under"];

  // Se è presente il parametro "under", lo converte in [double] per passarlo
  // a getProducts().
  final underPrice = underPriceStr == null ? null : double.tryParse(underPriceStr);

  // Ottiene i prodotti e li trasforma in JSON.
  final products = await getIt.get<ProductRepository>().getProducts(underPrice);
  final data = products.map((prod) => prod.toJson()).toList();

  return Response.ok(
    jsonEncode(data),
    headers: {"Content-Type": "application/json"},
  );
}
