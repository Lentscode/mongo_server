part of "routes.dart";

Future<Response> getProducts(Request req) async {
  final underPriceStr = RequestUtils.getQueryParams(req)["under"];

  final underPrice = underPriceStr == null ? null : double.tryParse(underPriceStr);

  final products = await getIt.get<ProductRepository>().getProducts(underPrice);
  final data = products.map((prod) => prod.toJson()).toList();

  return Response.ok(
    jsonEncode(data),
    headers: {"Content-Type": "application/json"},
  );
}
