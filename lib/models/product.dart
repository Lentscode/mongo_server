part of "models.dart";

class Product {
  final ObjectId id;
  final String name;
  final double price;
  int _amount;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required int amount,
  }) : _amount = amount;

  int get amount => _amount;

  void updateAmount(int amount) {
    _amount -= amount;
  }

  factory Product.fromMongo(Map<String, dynamic> doc) => Product(
        id: doc["_id"],
        name: doc["name"],
        price: doc["price"],
        amount: doc["amount"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id.oid,
        "name": name,
        "price": price,
        "amount": _amount,
      };
}
