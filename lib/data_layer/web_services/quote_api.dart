import 'package:dio/dio.dart';
import 'package:rickandmorty/constants/Strings.dart';

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

  Future<List<dynamic>> fetchSpecificCharacterQuote() async {
    try {
      Response? response = await dio?.get('characters');
      print(response?.data.toString());
      return response?.data;
    } catch (e) {
      print("errorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
      print(e.toString());
      return [];
    }
  }
}
