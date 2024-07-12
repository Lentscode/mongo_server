part of "models.dart";

// Modello rappresentante un prodotto all'interno del DB.
class Product {
  // Id del prodotto.
  final ObjectId id;
  // Nome del prodotto.
  final String name;
  // Prezzo del prodotto.
  final double price;
  // Quantità disponibile.
  int _amount;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required int amount,
  }) : _amount = amount;

  int get amount => _amount;

  // Funzione che aggiorna la quantità rimanente.
  void updateAmount(int amountPurchased) {
    _amount -= amountPurchased;
  }

  // Crea un oggetto da un documento MongoDB.
  factory Product.fromMongo(Map<String, dynamic> doc) => Product(
        id: doc["_id"],
        name: doc["name"],
        price: doc["price"],
        amount: doc["amount"],
      );

  // Crea una mappa per ritornare un prodotto da una richiesta.
  Map<String, dynamic> toJson() => {
        "_id": id.oid,
        "name": name,
        "price": price,
        "amount": _amount,
      };
}
