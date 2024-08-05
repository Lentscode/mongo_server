import "package:mongo_server/config/set_up.dart" as lib;
import "package:mongo_server/utils/utils.dart";
import "package:test/test.dart";

void main() {
  setUp(() async => await lib.setUp(true));

  group("setUp", () {
    test("Services registered", () async {
      final repo = lib.getIt.get<ProductRepository>();

      expect(repo, isA<ProductRepository>());
    });
  });
}
