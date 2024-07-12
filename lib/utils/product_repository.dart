part of "utils.dart";

class ProductRepository {
  const ProductRepository(this._productCollection);

  final DbCollection _productCollection;

  Future<Product> insertProductInDB(Map<String, dynamic> data) async {
    final finalData = {
      ...data,
      "_id": ObjectId(),
    };

    await _productCollection.insert(finalData);

    return Product.fromMongo(finalData);
  }

  Future<List<Product>> getProducts([double? underPrice]) async {
    final selector = underPrice != null ? where.lte("price", underPrice) : null;

    return await _productCollection.find(selector).map((data) => Product.fromMongo(data)).toList();
  }

  Future<Product> updateAmountOfProduct(String id, int amountPurchased) async {
    final doc = await _productCollection.findOne(where.id(ObjectId.parse(id)));

    if (doc == null) {
      throw ProductNotFoundException();
    }

    final product = Product.fromMongo(doc)..updateAmount(amountPurchased);

    await _productCollection.updateOne(
      where.eq("_id", ObjectId.parse(id)),
      modify.set("amount", product.amount),
    );

    return product;
  }

  Future<void> deleteProduct(String id) async {
    await _productCollection.deleteOne(where.id(ObjectId.parse(id)));
  }
}
