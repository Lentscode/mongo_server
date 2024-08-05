import "package:mongo_dart/mongo_dart.dart";

// Eccezione lanciata in caso di prodotto non trovato.
class ProductNotFoundException {
  ProductNotFoundException(this.productId);

  final ObjectId productId;
}

class InsufficientAmountException {
  const InsufficientAmountException(this.productId, this.requested, this.available);

  final ObjectId productId;
  final int requested;
  final int available;
}
