import 'package:dotenv/dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../utils/utils.dart';

// Variabile globale che contiene tutte le classi ausiliarie.
final getIt = GetIt.instance;

Future<void> setUp() async {
  // Carichiamo il contenuto del file .env
  final env = DotEnv()..load();

  // Creiamo un'istanza al database MongoDB e apriamo la connessione.
  final db = await Db.create(env["MONGO_CREDENTIALS"]!);
  await db.open();

  // Creiamo un'oggetto [ProductRepository] passandogli la referenza alla collezione
  // dei prodotti in MongoDB.
  final productRepository = ProductRepository(db.collection("products"));

  // Registriamo la nostra repository nel service locator.
  getIt.registerSingleton<ProductRepository>(productRepository);
}
