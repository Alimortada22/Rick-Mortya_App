import 'package:dio/dio.dart';
import 'package:rick_and_mortya_app/constant/constant_strings.dart';

class CharacterWebServies {
  late Dio dio;
  CharacterWebServies() {
    BaseOptions options = BaseOptions(
      baseUrl: baseurl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
    );
    dio = Dio(options);
  }

  Future<List<dynamic>> getAllCharacters()async{
    Response response = await dio.get("character");
    if (response.data != null) {
      return response.data["results"];
    }else{
      return [];
    }

  }
}
