part of "utils.dart";

// Classe ausiliaria che esegue operazioni CRUD sulla collezione
// "products". 
class ProductRepository {
  const ProductRepository(this._productCollection);

  // Proprietà per accedere alla collezione "products".
  final DbCollection _productCollection;

  // Metodo che inserisce un prodotto nel DB.
  Future<Product> insertProductInDB(Map<String, dynamic> data) async {
    final finalData = {
      ...data,
      "_id": ObjectId(),
    };

    await _productCollection.insertOne(finalData);

    return Product.fromMongo(finalData);
  }

  // Metodo che ritorna i prodotti presenti all'interno del DB.
  Future<List<Product>> getProducts([double? underPrice]) async {
    // Se [underPrice] è definito assegna un selettore per selezionare solo i prodotti
    // con un prezzo inferiore.
    final selector = underPrice != null ? where.lte("price", underPrice) : null;

    return await _productCollection.find(selector).map((data) => Product.fromMongo(data)).toList();
  }

  // Metodo per aggiornare la quantità disponibile di un prodotto.
  Future<Product> updateAmountOfProduct(String id, int amountPurchased) async {
    final doc = await _productCollection.findOne(where.id(ObjectId.parse(id)));

    // Se il documento non viene trovato, viene lanciata un'eccezione.
    if (doc == null) {
      throw ProductNotFoundException(id);
    }

    final product = Product.fromMongo(doc)..updateAmount(amountPurchased);

    await _productCollection.updateOne(
      where.eq("_id", ObjectId.parse(id)),
      modify.set("amount", product.amount),
    );

    return product;
  }

  // Metodo per eliminare un prodotto.
  Future<void> deleteProduct(String id) async {
    await _productCollection.deleteOne(where.id(ObjectId.parse(id)));
  }
}
