part of "utils.dart";

class RequestUtils {
  static Future<Map<String, dynamic>> getPayload(Request req) async {
    final payload = await req.readAsString();

    final data = jsonDecode(payload);

    return data;
  }

  static Map<String, String> getQueryParams(Request req) {
    return req.requestedUri.queryParameters;
  }
}
