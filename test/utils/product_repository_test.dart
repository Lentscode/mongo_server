import "package:mongo_dart/mongo_dart.dart";
import "package:mongo_server/config/set_up.dart" as lib;
import "package:mongo_server/errors/exceptions.dart";
import "package:mongo_server/models/models.dart";
import "package:mongo_server/utils/utils.dart";
import "package:test/test.dart";

void main() {
  late ProductRepository repo;
  late Product product;

  setUpAll(() async {
    await lib.setUp(true);
    repo = lib.getIt.get<ProductRepository>();
  });

  group("ProductRepository", () {
    group("insertProductInDb", () {
      test("Success", () async {
        final name = "Cake";
        final price = 7.99;
        final amount = 12;

        final data = {
          "name": name,
          "price": price,
          "amount": amount,
        };

        product = await repo.insertProductInDB(data);

        expect(product, isA<Product>());
        expect(product.id, isA<ObjectId>());
        expect(product.name, name);
        expect(product.price, price);
        expect(product.amount, amount);
      });
    });

    group("getProducts", () {
      test("Success", () async {
        final products = await repo.getProducts();

        expect(products.length, 1);
        expect(products.first.id, product.id);
      });
    });

    group("updateAmountOfProduct", () {
      test("Success", () async {
        final productUpdated = await repo.updateAmountOfProduct(product.id, 6);

        expect(productUpdated.id, product.id);
        expect(productUpdated.amount, product.amount - 6);
      });

      test("Failure: excessive amount", () async {
        final future = repo.updateAmountOfProduct(product.id, 7);

        expectLater(future, throwsA(isA<InsufficientAmountException>()));
      });

      test("Failure: product not existing", () async {
        final future = repo.updateAmountOfProduct(ObjectId(), 1);

        expectLater(future, throwsA(isA<ProductNotFoundException>()));
      });
    });

    group("deleteProduct", () {
      test("Success", () async {
        await repo.deleteProduct(product.id);

        final products = await repo.getProducts();

        expect(products.length, 0);
      });
    });
  });
}
