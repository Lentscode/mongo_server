library routes;

import "dart:convert";

import "package:mongo_dart/mongo_dart.dart";
import "package:shelf/shelf.dart";
import "package:shelf_router/shelf_router.dart";

import "../config/set_up.dart";
import "../errors/exceptions.dart";
import "../utils/utils.dart";

part "create_product.dart";
part "delete_product.dart";
part "get_products.dart";
part "purchase_product.dart";
