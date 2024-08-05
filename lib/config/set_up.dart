import "package:dotenv/dotenv.dart";
import "package:get_it/get_it.dart";
import "package:mongo_dart/mongo_dart.dart";

import "../utils/utils.dart";

// Variabile globale che contiene tutte le classi ausiliarie.
final getIt = GetIt.instance;

Future<void> setUp([bool testing = false]) async {
  // Carichiamo il contenuto del file .env
  final env = DotEnv(includePlatformEnvironment: true)..load();

  final credentials = testing ? env["MONGO_CREDENTIALS_TEST"] : env["MONGO_CREDENTIALS"];

  // Creiamo un'istanza al database MongoDB e apriamo la connessione.
  final db = await Db.create(credentials!);
  await db.open();

  // Creiamo un'oggetto [ProductRepository] passandogli la referenza alla collezione
  // dei prodotti in MongoDB.
  final productRepository = ProductRepository(db.collection("products"));

  // Registriamo la nostra repository nel service locator.
  getIt.registerSingleton<ProductRepository>(productRepository);
}
