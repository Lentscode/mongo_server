import 'package:dotenv/dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../utils/utils.dart';

final getIt = GetIt.instance;

Future<void> setUp() async {
  final env = DotEnv()..load();
  final db = await Db.create(env["MONGO_CREDENTIALS"]!);

  await db.open();

  final productRepository = ProductRepository(db.collection("products"));

  getIt.registerSingleton<ProductRepository>(productRepository);
}
