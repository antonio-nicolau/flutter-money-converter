import 'package:http/http.dart' as http;
import 'package:cambiodiario/app/modules/model/cambio_model.dart';

class Repository {
  Future<List<CambioModel>> getCambios() async {
    final url = 'https://cambio-diario.vercel.app/get-exchanges';

    var response = await http.get(Uri.parse(url));
    return modelFromJson(response.body);
  }
}
