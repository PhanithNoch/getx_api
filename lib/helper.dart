import 'package:dio/dio.dart';

import 'models/product_res_model.dart';

class Helper {
  final dio = Dio();

  Future<List<ProductResModel>> getProduct() async {
    try {
      final response = await dio.get('https://fakestoreapi.com/products');
      return (response.data as List)
          .map((e) => ProductResModel.fromJson(e))
          .toList();
    } catch (e) {
      throw e;
    }
  }
}
