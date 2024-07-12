// Eccezione lanciata in caso di prodotto non trovato.
class ProductNotFoundException {
  ProductNotFoundException(this.productId);

  final String productId;
}
