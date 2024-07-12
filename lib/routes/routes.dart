library routes;

import 'dart:convert';

import 'package:mongo_server/config/set_up.dart';
import 'package:mongo_server/utils/utils.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

part "create_product.dart";
part "delete_product.dart";
part "get_products.dart";
part "purchase_product.dart";
