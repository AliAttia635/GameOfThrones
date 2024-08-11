import 'package:dio/dio.dart';
import 'package:rickandmorty/constants/Strings.dart';

class CharactersApi {
  late Dio? dio;

  CharactersApi() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: Duration(seconds: 20),
      receiveTimeout: Duration(seconds: 20),
    );

    dio = Dio(options);
  }

  Future<List<dynamic>> fetchAllCharacters() async {
    try {
      Response? response = await dio?.get('Characters');
      print(response?.data.toString());
      return response?.data;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  // Future<List<dynamic>> fetchSpecificCharacter(int id) async {
  //   try {
  //     Response? response = await dio?.get('Characters/$id');
  //     print(response?.data.toString());
  //     return response?.data;
  //   } catch (e) {
  //     print(e.toString());
  //     return [];
  //   }
  // }
}
