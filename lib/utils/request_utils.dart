part of "utils.dart";

// Classe ausiliaria per ottenere dati dalla richiesta HTTP.
class RequestUtils {
  // Metodo per ricavare i dati dal payload.
  static Future<Map<String, dynamic>> getPayload(Request req) async {
    final payload = await req.readAsString();

    final data = jsonDecode(payload);

    return data;
  }

  // Metodo per ottenere i parametri di query.
  static Map<String, String> getQueryParams(Request req) {
    return req.requestedUri.queryParameters;
  }
}
