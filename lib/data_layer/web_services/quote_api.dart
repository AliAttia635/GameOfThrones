import 'package:dio/dio.dart';
import 'package:rickandmorty/constants/Strings.dart';
import 'package:rickandmorty/data_layer/models/quotes_model.dart';

class QuoteApi {
  late Dio dio;

  QuoteApi() {
    BaseOptions options = BaseOptions(
      baseUrl: quoteBaseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: Duration(seconds: 20),
      receiveTimeout: Duration(seconds: 20),
    );

    dio = Dio(options);
  }

  Future<dynamic> fetchSpecificCharacterQuote(String charName) async {
    try {
      Response? response = await dio?.get('character/$charName');
      print(response?.data.toString());
      return response?.data;
    } catch (e) {
      print("errorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
      print(e.toString());
      return Quote(name: 'Default Name', quotes: []);
    }
  }
}
