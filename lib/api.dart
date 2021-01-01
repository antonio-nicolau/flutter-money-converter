import 'package:http/http.dart' as http;
import 'cambio_model.dart';

class Api {
  Future<List<CambioModel>> fetchAllData() async {
    final url = 'http://cambio-api-testing.herokuapp.com/getCambios';

    var response = await http.get(url);
    return modelFromJson(response.body);
  }
}
