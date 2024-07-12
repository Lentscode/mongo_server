import 'package:mongo_dart/mongo_dart.dart';

class Product {
  final String id;
  final String name;
  final double price;
  int _amount;

  Product({required this.id, required this.name, required this.price, required int amount}) : _amount = amount;

  int get amount => _amount;

  void updateAmount(int amount) {
    _amount -= amount;
  }

  factory Product.fromMongo(Map<String, dynamic> json) => Product(
        id: (json["_id"] as ObjectId).oid,
        name: json["name"],
        price: json["price"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "price": price,
        "amount": _amount,
      };
}
